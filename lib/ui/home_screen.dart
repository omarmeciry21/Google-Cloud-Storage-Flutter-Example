import 'dart:io';

import 'package:cat_cloud_storage/data/models/bucket_object.dart';
import 'package:cat_cloud_storage/data/models/custom_exception.dart';
import 'package:cat_cloud_storage/data/network/api.dart';
import 'package:cat_cloud_storage/ui/notifiers/progress_notifier.dart';
import 'package:cat_cloud_storage/ui/widgets/show_info_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Manager"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => uploadFile(context),
        child: Icon(Icons.upload_file_rounded),
      ),
      body: SafeArea(
        child: FutureBuilder<List<BucketObject>>(
          future: Api.getAllObjects(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(snapshot.error.toString()),
                ],
              );
            }
            return Container(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data![index].toJson());

                    return SingleBucketObject(
                      bucketObject: snapshot.data![index],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  uploadFile(BuildContext context) async {
    try {
      Provider.of<ProgressNotifier>(context, listen: false).resetProgress();
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path.toString());
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                value: Provider.of<ProgressNotifier>(context).progress,
              ),
            ),
          ),
        );

        await Api.uploadObjectFile(
            file,
            await file.length().toString(),
            p.extension(file.path),
            (p0, p1) => Provider.of<ProgressNotifier>(context, listen: false)
                .updateProgress(p0 / p1));
        Navigator.pop(context);
        showInfoDialog(context, "Uploaded Successfully!");
      }
    } on DialogHandledException catch (e) {
      showInfoDialog(context, e.toString());
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}

class SingleBucketObject extends StatelessWidget {
  const SingleBucketObject({
    Key? key,
    required this.bucketObject,
  }) : super(key: key);
  final BucketObject bucketObject;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(child: Text(bucketObject.contentType!)),
            ),
          ),
          title: Text(
            bucketObject.name!,
            style: const TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            bucketObject.size! + " bit",
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => downloadBucketObject(bucketObject, context),
                  icon: const Icon(Icons.download_rounded)),
              // IconButton(
              //     onPressed: () => deleteBucketObject(bucketObject, context),
              //     icon: const Icon(Icons.delete_forever_rounded)),
            ],
          ),
        ),
      ),
    );
  }

  downloadBucketObject(BucketObject bucketObject, BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: Provider.of<ProgressNotifier>(context).progress,
              ),
            ),
          ),
        ),
      );
      final pathName =
          "/sdcard/download/CAT Cloud Storage/${bucketObject.name ?? "storageFile"}";
      await Api.downloadObjectFile(
          bucketObject,
          pathName,
          (p0, p1) => Provider.of<ProgressNotifier>(context, listen: false)
              .updateProgress(p0 / p1));
      Navigator.pop(context);
      showInfoDialog(
          context, "Downloaded Successfully!\nDownloaded to: $pathName");
    } on DialogHandledException catch (e) {
      showInfoDialog(context, e.toString());
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  // deleteBucketObject(BucketObject bucketObject, BuildContext context) async {
  //   try {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => AlertDialog(
  //         content: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             height: 50,
  //             width: 50,
  //             child: CircularProgressIndicator(
  //               value: Provider.of<ProgressNotifier>(context).progress,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //     await Api.deleteObjectFile(
  //         bucketObject,
  //         (p0, p1) => Provider.of<ProgressNotifier>(context, listen: false)
  //             .updateProgress(p0 / p1));
  //     Navigator.pop(context);
  //     showInfoDialog(context, "Deleted Successfully!");
  //   } on DialogHandledException catch (e) {
  //     showInfoDialog(context, e.toString());
  //     print(e.toString());
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
