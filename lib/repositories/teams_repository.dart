import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../controllers/database/db.dart';
import '../models/trophy.dart';
import '../models/team.dart';

class TeamsRepository extends ChangeNotifier {
  final List<Team> _teams = [];
  final loading = ValueNotifier(false);

  UnmodifiableListView<Team> get teams => UnmodifiableListView(_teams);

  void addThophy(Team team, Trophy trophy) async {
    var db = await DB.get();
    int id = await db.insert('trophies', {
      'championship': trophy.championship,
      'year': trophy.year,
      'team_id': team.id,
    });
    trophy.id = id;
    team.trophies.add(trophy);
    notifyListeners();
  }

  editTrophy(Trophy trophy, String championship, String year) async {
    var db = await DB.get();
    await db.update(
        'trophies',
        {
          'championship': championship,
          'year': year,
        },
        where: 'id = ?',
        whereArgs: [trophy.id]);
    trophy.championship = championship;
    trophy.year = int.parse(year);
    notifyListeners();
  }

  static setupTeams() {
    return [
      Team(
        name: 'Botafogo',
        points: 0,
        color: Color(Colors.black.value),
        shield: 'https://logodetimes.com/times/botafogo/logo-botafogo-256.png',
        trophies: [],
        idAPI: 22,
      ),
      Team(
        name: 'Bragantino',
        points: 0,
        color: Color(Colors.red.value),
        shield:
            'https://logodetimes.com/times/red-bull-bragantino/logo-red-bull-bragantino-256.png',
        trophies: [],
        idAPI: 64,
      ),
      Team(
        name: 'Flamengo',
        points: 0,
        color: Color(Colors.red.value),
        shield: 'https://logodetimes.com/times/flamengo/logo-flamengo-256.png',
        trophies: [],
        idAPI: 18,
      ),
      Team(
        name: 'Grêmio',
        points: 0,
        color: Color(Colors.blue.value),
        shield: 'https://logodetimes.com/times/gremio/logo-gremio-256.png',
        trophies: [],
        idAPI: 45,
      ),
      Team(
        name: 'Palmeiras',
        points: 0,
        color: Color(Colors.green.value),
        shield:
            'https://logodetimes.com/times/palmeiras/logo-palmeiras-256.png',
        trophies: [],
        idAPI: 56,
      ),
      Team(
        name: 'Athletico-PR',
        points: 0,
        color: Color(Colors.red.value),
        shield:
            'https://logodetimes.com/times/atletico-paranaense/logo-atletico-paranaense-256.png',
        trophies: [],
        idAPI: 185,
      ),
      Team(
        name: 'Atlético-MG',
        points: 0,
        color: Color(Colors.black.value),
        shield:
            'https://logodetimes.com/times/atletico-mineiro/logo-atletico-mineiro-256.png',
        trophies: [],
        idAPI: 30,
      ),
      Team(
        name: 'Fortaleza',
        points: 0,
        color: Color(Colors.blue.value),
        shield:
            'https://logodetimes.com/times/fortaleza/logo-fortaleza-256.png',
        trophies: [],
        idAPI: 131,
      ),
      Team(
        name: 'Fluminense',
        points: 0,
        color: Color(Colors.green.value),
        shield:
            'https://logodetimes.com/times/fluminense/logo-fluminense-256.png',
        trophies: [],
        idAPI: 26,
      ),
      Team(
        name: 'Cuiabá',
        points: 0,
        color: Color(Colors.amber.value),
        shield: 'https://logodetimes.com/times/cuiaba/logo-cuiaba-256.png',
        trophies: [],
        idAPI: 204,
      ),
      Team(
        name: 'São Paulo',
        points: 0,
        color: Color(Colors.red.value),
        shield:
            'https://logodetimes.com/times/sao-paulo/logo-sao-paulo-256.png',
        trophies: [],
        idAPI: 57,
      ),
      Team(
        name: 'Internacional',
        points: 0,
        color: Color(Colors.red.value),
        shield:
            'https://logodetimes.com/times/internacional/logo-internacional-256.png',
        trophies: [],
        idAPI: 44,
      ),
      Team(
        name: 'Corinthians',
        points: 0,
        color: Color(Colors.black.value),
        shield:
            'https://logodetimes.com/times/corinthians/logo-corinthians-256.png',
        trophies: [],
        idAPI: 65,
      ),
      Team(
        name: 'Bahia',
        points: 0,
        color: Color(Colors.blue.value),
        shield: 'https://logodetimes.com/times/bahia/logo-bahia-256.png',
        trophies: [],
        idAPI: 68,
      ),
      Team(
        name: 'Cruzeiro',
        points: 0,
        color: Color(Colors.blue.value),
        shield: 'https://logodetimes.com/times/cruzeiro/logo-cruzeiro-256.png',
        trophies: [],
        idAPI: 37,
      ),
      Team(
        name: 'Vasco da Gama',
        points: 0,
        color: Color(Colors.black.value),
        shield:
            'https://logodetimes.com/times/vasco-da-gama/logo-vasco-da-gama-256.png',
        trophies: [],
        idAPI: 23,
      ),
      Team(
        name: 'Santos',
        points: 0,
        color: Color(Colors.black.value),
        shield: 'https://logodetimes.com/times/santos/logo-santos-256.png',
        trophies: [],
        idAPI: 63,
      ),
      Team(
        name: 'Goiás',
        points: 0,
        color: Color(Colors.green.value),
        shield:
            'https://logodetimes.com/times/goias/logo-goias-esporte-clube-256.png',
        trophies: [],
        idAPI: 115,
      ),
      Team(
        name: 'Coritiba',
        points: 0,
        color: Color(Colors.green.value),
        shield: 'https://logodetimes.com/times/coritiba/logo-coritiba-256.png',
        trophies: [],
        idAPI: 84,
      ),
      Team(
        name: 'América-MG',
        points: 0,
        color: Color(Colors.green.value),
        shield:
            'https://logodetimes.com/times/america-mineiro/logo-america-mineiro-256.png',
        trophies: [],
        idAPI: 33,
      )
    ];
  }

  TeamsRepository() {
    initRepository();
  }

  showLoading(bool valor) {
    loading.value = valor;
    notifyListeners();
  }

  updateTable() async {
    showLoading(true);
    var http = Dio();
    var response = await http.get(
      'https://api.api-futebol.com.br/v1/campeonatos/10/tabela',
      options: Options(headers: {
        'Authorization': 'Bearer live_59a9941cee82510891609a81e16ace'
      }),
    );

    if (response.statusCode == 200) {
      final table = response.data;
      final db = await DB.get();
      table.forEach((line) async {
        final idAPI = line['time']['time_id'];
        final points = line['pontos'];

        await db.update(
          'teams',
          {'points': points},
          where: 'idAPI = ?',
          whereArgs: [idAPI],
        );

        Team team = _teams.firstWhere((team) => team.idAPI == idAPI);
        team.points = points;
        notifyListeners();
        showLoading(false);
      });
    } else {
      showLoading(false);
      throw Exception('Falha');
    }
  }

  initRepository() async {
    var db = await DB.get();
    List teams = await db.query('teams', orderBy: 'points DESC');

    for (var team in teams) {
      _teams.add(Team(
          id: team['id'],
          name: team['name'],
          shield: team['shield'],
          points: team['points'],
          idAPI: team['idAPI'],
          color: Color(
              int.parse((team['color']).replaceAll('toRadixString(16)', ''))),
          trophies: await getTrophies(team['id'])));
    }
    updateTable();
    notifyListeners();
  }

  getTrophies(teamId) async {
    var db = await DB.get();
    var results =
        await db.query('trophies', where: 'team_id = ?', whereArgs: [teamId]);

    List<Trophy> trophies = [];
    for (var trophy in results) {
      trophies.add(Trophy(
        id: trophy['id'],
        championship: trophy['championship'],
        year: trophy['year'],
      ));
    }
    return trophies;
  }
}
