import 'package:open_work_flutter/storage/month_storage.dart';
import 'package:open_work_flutter/storage/sembast/sembast_helper.dart';
import 'package:open_work_flutter/storage/type_storage.dart';

import 'sembast/work_month_sembast_storage.dart';
import 'sembast/work_type_sembast_storage.dart';

typedef StoragePair = (TypeStorage, MonthStorage);

class StorageFactory {
  static Future<StoragePair> createDefault() => sembast();

  static Future<StoragePair> sembast(
      [String name = 'open-work-sembast']) async {
    final database = await SembastHelper.openForCurrentPlatform(name);

    final groupStorege =
        WorkTypeSembastStorage(database: database, name: 'word_group');
    final metadataStorege =
        WorkMonthSembastStorage(database: database, name: 'metadata');

    return (groupStorege, metadataStorege);
  }
}
