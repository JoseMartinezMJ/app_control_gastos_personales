import 'package:app_control_gastos_personales/model/gasto_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static final DatabaseHandler _instance = DatabaseHandler._internal();
  static Database? _database;

  DatabaseHandler._internal();

  factory DatabaseHandler(){
    return _instance;
  }
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async{
    String path = join(await getDatabasesPath(),"gastos_db.db");
    return await openDatabase(path, version: 1, onCreate: _createTables,);
  }

  Future<void> _createTables(Database db, int version) async{
    await db.execute(''' 
    CREATE TABLE gastos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    monto REAL NOT NULL,
    categoria TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    fecha TEXT NOT NULL,
    )
    ''');
  }
  
  Future<int> crearGasto(GastoModel gasto) async{
    final db = await database;
    return await db.insert("gastos", gasto.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<GastoModel>> obtenerGastos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("gastos");
    return List.generate(maps.length, (i)=> GastoModel.fromMap(maps[i]),);
  }

  Future<GastoModel?> obtenerGastosPorId(int id) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("gastos", where: "id = ?", whereArgs: [id],);
    if (maps.isNotEmpty) {
      return GastoModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<GastoModel>> obtenerGastosPorCategoria(String categoria) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("gastos", where: "categoria = ?", whereArgs: [categoria],);
    return List.generate(maps.length, (i)=> GastoModel.fromMap(maps[i]),);
  }

  Future<int> actualizarGasto(GastoModel gasto) async{
    final db = await database;
    return await db.update("gastos", gasto.toMap(),where: "id = ?", whereArgs: [gasto.id],);
  }
  Future<int> eliminarGasto(int id) async{
    final db = await database;
    return await db.delete("gastos",where: "id = ?", whereArgs: [id],);
  }
}