import 'package:kyogre_getx_lanchonete/database/interface/banco.dart';

class DatabaseRepository extends Banco {
  @override
  Future<void> getDatabase() async {
    print('DatabaseRepository');
  }

  @override
  Future<int> delete(String table, {String? where, List<String>? whereArgs}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> get(String table,
      {String? where,
      List<String>? columns,
      String? orderBy,
      int? limit,
      int? offset}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<int> put(String table, Map<String, dynamic> values) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<int> update(String table, Map<String, dynamic> values,
      {String? where, List<String>? whereArgs}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
