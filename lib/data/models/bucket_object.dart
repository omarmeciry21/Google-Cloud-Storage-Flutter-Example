// {
// "kind": "storage#object",
// "id": "test_data_flutter/CAT Reloaded//1634044031178318",
// "selfLink": "https://www.googleapis.com/storage/v1/b/test_data_flutter/o/CAT%20Reloaded%2F",
// "mediaLink": "https://storage.googleapis.com/download/storage/v1/b/test_data_flutter/o/CAT%20Reloaded%2F?generation=1634044031178318&alt=media",
// "name": "CAT Reloaded/",
// "bucket": "test_data_flutter",
// "generation": "1634044031178318",
// "metageneration": "1",
// "contentType": "text/plain",
// "storageClass": "STANDARD",
// "size": "0",
// "md5Hash": "1B2M2Y8AsgTpgAmY7PhCfg==",
// "crc32c": "AAAAAA==",
// "etag": "CM6smrD4xPMCEAE=",
// "temporaryHold": false,
// "eventBasedHold": false,
// "timeCreated": "2021-10-12T13:07:11.213Z",
// "updated": "2021-10-12T13:07:11.213Z",
// "timeStorageClassUpdated": "2021-10-12T13:07:11.213Z"
// }

class BucketObject {
  String? kind;
  String? id;
  String? selfLink;
  String? mediaLink;
  String? name;
  String? bucket;
  String? generation;
  String? metageneration;
  String? contentType;
  String? storageClass;
  String? size;
  String? md5Hash;
  String? crc32c;
  String? etag;
  bool? temporaryHold;
  bool? eventBasedHold;
  String? timeCreated;
  String? updated;
  String? timeStorageClassUpdated;

  BucketObject({
    required this.kind,
    required this.id,
    required this.selfLink,
    required this.mediaLink,
    required this.name,
    required this.bucket,
    required this.generation,
    required this.metageneration,
    required this.contentType,
    required this.storageClass,
    required this.size,
    required this.md5Hash,
    required this.crc32c,
    required this.etag,
    required this.temporaryHold,
    required this.eventBasedHold,
    required this.timeCreated,
    required this.updated,
    required this.timeStorageClassUpdated,
  });
  BucketObject.fromJson(Map<String, dynamic> json) {
    kind = json[BucketObjectFields.kind];
    id = json[BucketObjectFields.id];
    selfLink = json[BucketObjectFields.selfLink];
    mediaLink = json[BucketObjectFields.mediaLink];
    name = json[BucketObjectFields.name];
    bucket = json[BucketObjectFields.bucket];
    generation = json[BucketObjectFields.generation];
    metageneration = json[BucketObjectFields.metageneration];
    contentType = json[BucketObjectFields.contentType];
    storageClass = json[BucketObjectFields.storageClass];
    size = json[BucketObjectFields.size];
    md5Hash = json[BucketObjectFields.md5Hash];
    crc32c = json[BucketObjectFields.crc32c];
    etag = json[BucketObjectFields.etag];
    temporaryHold = json[BucketObjectFields.temporaryHold];
    eventBasedHold = json[BucketObjectFields.eventBasedHold];
    timeCreated = json[BucketObjectFields.timeCreated];
    updated = json[BucketObjectFields.updated];
    timeStorageClassUpdated = json[BucketObjectFields.timeStorageClassUpdated];
  }

  Map<String, dynamic> toJson() {
    return {
      BucketObjectFields.kind: kind,
      BucketObjectFields.id: id,
      BucketObjectFields.selfLink: selfLink,
      BucketObjectFields.mediaLink: mediaLink,
      BucketObjectFields.name: name,
      BucketObjectFields.bucket: bucket,
      BucketObjectFields.generation: generation,
      BucketObjectFields.metageneration: metageneration,
      BucketObjectFields.contentType: contentType,
      BucketObjectFields.storageClass: storageClass,
      BucketObjectFields.size: size,
      BucketObjectFields.md5Hash: md5Hash,
      BucketObjectFields.crc32c: crc32c,
      BucketObjectFields.etag: etag,
      BucketObjectFields.temporaryHold: temporaryHold,
      BucketObjectFields.eventBasedHold: eventBasedHold,
      BucketObjectFields.timeCreated: timeCreated,
      BucketObjectFields.updated: updated,
      BucketObjectFields.timeStorageClassUpdated: timeStorageClassUpdated,
    };
  }
}

class BucketObjectFields {
  static const String kind = "kind";
  static const String id = "id";
  static const String selfLink = "selfLink";
  static const String mediaLink = "mediaLink";
  static const String name = "name";
  static const String bucket = "bucket";
  static const String generation = "generation";
  static const String metageneration = "metageneration";
  static const String contentType = "contentType";
  static const String storageClass = "storageClass";
  static const String size = "size";
  static const String md5Hash = "md5Hash";
  static const String crc32c = "crc32c";
  static const String etag = "etag";
  static const String temporaryHold = "temporaryHold";
  static const String eventBasedHold = "eventBasedHold";
  static const String timeCreated = "timeCreated";
  static const String updated = "updated";
  static const String timeStorageClassUpdated = "timeStorageClassUpdated";
}
