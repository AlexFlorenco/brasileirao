import 'package:brasileirao/models/team.dart';
import 'package:brasileirao/models/trophy.dart';
import 'package:brasileirao/repositories/teams_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddTrophyPage extends StatefulWidget {
  Team team;

  AddTrophyPage({super.key, required this.team});

  @override
  State<AddTrophyPage> createState() => _AddTrophyPageState();
}

class _AddTrophyPageState extends State<AddTrophyPage> {
  final _championship = TextEditingController();
  final _year = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  save() {
    Provider.of<TeamsRepository>(context, listen: false).addThophy(
      widget.team,
      Trophy(
        championship: _championship.text,
        year: int.parse(_year.text),
      ),
    );

    Get.back();

    Get.snackbar(
      'Sucesso!',
      'Título cadastrado!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Título'),
        backgroundColor: widget.team.color,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: TextFormField(
                  controller: _championship,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Campeonato',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome do campeonato!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _year,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ano',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o ano do título!';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      save();
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'SALVAR',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
