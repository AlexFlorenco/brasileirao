import 'package:brasileirao/repositories/teams_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../models/team.dart';
import 'add_trophy_page.dart';
import 'edit_trophy_page.dart';
import 'widgets/shield.dart';

// ignore: must_be_immutable
class TeamPage extends StatefulWidget {
  Team team;
  TeamPage({super.key, required this.team});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  trophyPage() {
    Get.to(() => AddTrophyPage(team: widget.team));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.team.color,
          title: Text(widget.team.name),
          actions: [
            IconButton(
              onPressed: trophyPage,
              icon: const Icon(Icons.add),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Estatísticas',
              ),
              Tab(
                icon: Icon(Icons.emoji_events),
                text: 'Títulos',
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Shield(image: widget.team.shield, width: 200),
              ),
              Text(
                'Pontos: ${widget.team.points}',
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
          Provider.of<TeamsRepository>(context)
                  .teams
                  .firstWhere((element) => element.name == widget.team.name)
                  .trophies
                  .isEmpty
              ? const Center(child: Text("Nenhum título ainda"))
              : ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const Icon(Icons.emoji_events),
                      title: Text(Provider.of<TeamsRepository>(context)
                          .teams
                          .firstWhere(
                              (element) => element.name == widget.team.name)
                          .trophies[index]
                          .championship),
                      trailing: Text(Provider.of<TeamsRepository>(context)
                          .teams
                          .firstWhere(
                              (element) => element.name == widget.team.name)
                          .trophies[index]
                          .year
                          .toString()),
                      onTap: () {
                        Get.to(
                          () => EditTrophyPage(
                            trophy: Provider.of<TeamsRepository>(context,
                                    listen: false)
                                .teams
                                .firstWhere((element) =>
                                    element.name == widget.team.name)
                                .trophies[index],
                            color: Provider.of<TeamsRepository>(context,
                                    listen: false)
                                .teams
                                .firstWhere((element) =>
                                    element.name == widget.team.name)
                                .color,
                          ),
                          fullscreenDialog: true,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: widget.team.trophies.length,
                )
        ]),
      ),
    );
  }
}
