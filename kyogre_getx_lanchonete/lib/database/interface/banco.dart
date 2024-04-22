abstract class Banco {
  //get
  Future<List<Map<String, dynamic>>> get(String table,
      {String? where,
      List<String>? columns,
      String? orderBy,
      int? limit,
      int? offset});

  //put
  Future<int> put(String table, Map<String, dynamic> values);

  //update
  Future<int> update(String table, Map<String, dynamic> values,
      {String? where, List<String>? whereArgs});

  //delete
  Future<int> delete(String table, {String? where, List<String>? whereArgs});
}
