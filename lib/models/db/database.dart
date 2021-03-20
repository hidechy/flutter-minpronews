import 'package:moor/moor.dart';

import 'dart:io';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dao.dart';

part 'database.g.dart';

class ArticleRecords extends Table {
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();

  @override
  Set<Column> get primaryKey => {url};
}

@UseMoor(tables: [ArticleRecords], daos: [NewsDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'news.db'));

    return VmDatabase(file);
  });
}
