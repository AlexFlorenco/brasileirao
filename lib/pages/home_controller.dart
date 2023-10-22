import 'package:brasileirao/repositories/teams_repository.dart';

import '../models/team.dart';

class HomeController {
  late TeamsRepository teamsRepository;

  List<Team> get table => teamsRepository.teams;

  HomeController() {
    teamsRepository = TeamsRepository();
  }
}
