import 'package:brasileirao/repositories/teams_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../models/trophy.dart';

// ignore: must_be_immutable
class EditTrophyPage extends StatefulWidget {
  Trophy trophy;
  Color color;

  EditTrophyPage({super.key, required this.trophy, required this.color});

  @override
  State<EditTrophyPage> createState() => _EditTrophyPageState();
}

class _EditTrophyPageState extends State<EditTrophyPage> {
  final _championship = TextEditingController();
  final _year = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final Color _color;

  @override
  void initState() {
    super.initState();
    _championship.text = widget.trophy.championship;
    _year.text = widget.trophy.year.toString();
    _color = widget.color;
  }

  edit() {
    if (_formKey.currentState!.validate()) {
      Provider.of<TeamsRepository>(context, listen: false).editTrophy(
        widget.trophy,
        _championship.text,
        _year.text,
      );

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Título'),
        backgroundColor: _color,
        actions: [IconButton(onPressed: edit, icon: const Icon(Icons.check))],
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
            ],
          )),
    );
  }
}
