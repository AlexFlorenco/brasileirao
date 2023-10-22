import 'package:brasileirao/controllers/theme_controller.dart';
import 'package:brasileirao/pages/team_page.dart';
import 'package:brasileirao/repositories/teams_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widgets/shield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabela do Brasileirão Série A'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Obx(() => controller.isDark.value
                      ? const Icon(Icons.brightness_7)
                      : const Icon(Icons.brightness_2)),
                  title: Obx(() => controller.isDark.value
                      ? const Text('Light')
                      : const Text('Dark')),
                  onTap: () => controller.changeTheme(),
                ),
              )
            ],
          )
        ],
      ),
      body: Consumer<TeamsRepository>(
        builder: (context, repository, child) {
          return RefreshIndicator(
            onRefresh: () => repository.updateTable(),
            child: repository.loading.value
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Atualizando tabela...'),
                        )
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: repository.teams.length,
                    itemBuilder: (BuildContext context, int team) {
                      return ListTile(
                        leading: Shield(
                            image: repository.teams[team].shield, width: 40),
                        title: Text(repository.teams[team].name),
                        subtitle: Text(
                            'Títulos: ${repository.teams[team].trophies.length}'),
                        trailing:
                            Text(repository.teams[team].points.toString()),
                        onTap: () {
                          Get.to(
                            () => TeamPage(
                              key: Key(repository.teams[team].name),
                              team: repository.teams[team],
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                    padding: const EdgeInsets.all(16),
                  ),
          );
        },
      ),
    );
  }
}
