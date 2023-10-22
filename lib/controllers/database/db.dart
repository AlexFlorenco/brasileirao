import 'package:brasileirao/repositories/teams_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../../models/team.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDatabase();
  }

  static get() async {
    return await DB.instance.database;
  }

  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(teams);
        await db.execute(trophies);
        await setupTeams(db);
      },
    );
  }

  setupTeams(db) {
    for (Team team in TeamsRepository.setupTeams()) {
      db.insert('teams', {
        'name': team.name,
        'shield': team.shield,
        'points': team.points,
        'idAPI': team.idAPI,
        'color': team.color,
      });
    }
  }

  String get teams => '''
    CREATE TABLE teams(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      points INTEGER,
      shield TEXT,
      color TEXT,
      idAPI INTEGER
    );
  ''';

  String get trophies => '''
    CREATE TABLE trophies(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      championship TEXT,
      year INTEGER,
      team_id INTEGER,
      FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
    );
  ''';
}
