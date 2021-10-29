import 'dart:async';
import 'dart:io';

import 'package:cat_cloud_storage/data/models/bucket_object.dart';
import 'package:cat_cloud_storage/data/models/custom_exception.dart';
import 'package:dio/dio.dart';

class Api {
  static const String baseUrl = "https://storage.googleapis.com/storage/v1";
  static const String apiKey =
      "ya29.a0ARrdaM_UYkEgRhu8ZPusu7xJM-_19ddOcXek222xJrR3xhqDFF0LBCkaqbMqwt3J8VFNg_SP-wcgN3V45oDeeylRpBjFacbHz1n63rrV6r4hZx1SLL2-qkAi-25lDvsG6km0PjtnT4q_7D_fbi1XqHAgllFZ";
  static const String bucketName = "test_data_flutter";

  static final options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 3000, // 3 seconds
    headers: {"Authorization": "Bearer $apiKey"},
  );
  static final dio = Dio(options);

  static Future<List<BucketObject>> getAllObjects() async {
    List<BucketObject> bucketObjects = [];

    try {
      final response = await dio.get("/b/test_data_flutter/o");
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> items =
            response.data["items"].cast<Map<String, dynamic>>();

        bucketObjects
            .addAll(items.map((e) => BucketObject.fromJson(e)).toList());
      } else {
        print("Code Error message " + response.statusMessage.toString());
        print("Code Error data " + response.data.toString());
        throw DialogHandledException("An error occurred");
      }
    } on TimeoutException catch (e) {
      throw DialogHandledException("No Internet Connection!");
    } on DialogHandledException {
      rethrow;
    } catch (e) {
      print("General Catch" + e.toString());
      throw DialogHandledException("An error occurred");
    }

    return bucketObjects;
  }

  static Future<bool?> downloadObjectFile(
    BucketObject bucketObject,
    String savePath,
    Function(int, int) onReceiveProgress,
  ) async {
    File? objectFile;

    try {
      final response = await dio.download("/b/test_data_flutter/o", savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: {"object": bucketObject.name});
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Code Error message " + response.statusMessage.toString());
        print("Code Error data " + response.data.toString());
        throw DialogHandledException("An error occurred");
      }
    } on TimeoutException catch (e) {
      throw DialogHandledException("No Internet Connection!");
    } on DialogHandledException {
      rethrow;
    } catch (e) {
      print("General Catch" + e.toString());
      throw DialogHandledException("An error occurred");
    }
  }

  static Future<void> uploadObjectFile(File file, String contentLength,
      String contentType, Function(int, int) onUploadingProgress) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: "OmarFile" + fileName.split(".").last,
        ),
      });
      final response = await dio.post<String>(
        "/b/$bucketName/o",
        data: formData,
        options: Options(headers: {
          "Content-Type": contentType,
          "Content-Length": contentLength
        }),
        queryParameters: {"name": fileName, "uploadType": "media"},
        onSendProgress: onUploadingProgress,
      );
      //  response = await dio.post<String>(
      //   "/b/$bucketName/o",
      //   data: formData,
      //   options: Options(headers: {
      //     "Content-Type": contentType,
      //     "Content-Length": contentLength
      //   }),
      //   // queryParameters: {
      //   //   "name": file.path.split("/").last,
      //   //   "uploadType": "media"
      //   // },
      //   onSendProgress: onUploadingProgress,
      // );
    } on TimeoutException catch (e) {
      throw DialogHandledException("No Internet Connection!");
    } on DialogHandledException {
      rethrow;
    } catch (e) {
      print("General Catch" + e.toString());
      throw DialogHandledException("An error occurred");
    }
  }

  static Future<void> deleteObjectFile(
      BucketObject bucketObject, onReceiveProgress) async {
    try {
      print(bucketObject.toJson().toString());
      await dio.delete("/b/test_data_flutter/o",
          queryParameters: {"object": bucketObject.name});
      //  response = await dio.post<String>(
      //   "/b/$bucketName/o",
      //   data: formData,
      //   options: Options(headers: {
      //     "Content-Type": contentType,
      //     "Content-Length": contentLength
      //   }),
      //   // queryParameters: {
      //   //   "name": file.path.split("/").last,
      //   //   "uploadType": "media"
      //   // },
      //   onSendProgress: onUploadingProgress,
      // );
    } on TimeoutException catch (e) {
      throw DialogHandledException("No Internet Connection!");
    } on DialogHandledException {
      rethrow;
    } catch (e) {
      print("General Catch" + e.toString());
      throw DialogHandledException("An error occurred");
    }
  }
}
