import 'package:crud_sqlite/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  final String tabelMahasiswa = "tbmahasiswa";
  final String columnId = "id";
  final String columnNama = "nama";
  final String columnNoBP = "nobp";
  final String columnNoHP = "nohp";
  final String columnEmail = "email";
  final String columnAlamat = "alamat";
  Database? db;

  Future<Database?> cekDB() async {
    if (db != null) {
      return db;
    }
    db = await initDb();
    return db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "mahasiswa.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tabelMahasiswa($columnId INTEGER PRIMARY KEY, $columnNama TEXT, $columnNoBP TEXT, $columnNoHP TEXT, $columnEmail TEXT, $columnAlamat TEXT)');
  }

  Future<int?> saveMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await cekDB();
    var result = await dbClient!.insert(tabelMahasiswa, mahasiswa.toMap());
    print("insert data $result");
    return result;
  }

  Future<List?> getAllMahasiswa() async {
    var dbClient = await cekDB();
    var result = await dbClient!.query(tabelMahasiswa, columns: [
      columnId,
      columnNama,
      columnNoBP,
      columnNoHP,
      columnEmail,
      columnAlamat
    ]);
    return result;
  }

  Future<int?> updateMahasiswa(int id, ModelMahasiswa mahasiswa) async {
    var dbClient = await cekDB();
    var result = await dbClient!.update(tabelMahasiswa, mahasiswa.toMap(),
        where: "$columnId = ?", whereArgs: [id]);
    return result;
  }


  Future<int?> deleteMahasiswa(int id) async {
    var dbClient = await cekDB();
    return await dbClient!
        .delete(tabelMahasiswa, where: "$columnId = ?", whereArgs: [id]);
  }
}