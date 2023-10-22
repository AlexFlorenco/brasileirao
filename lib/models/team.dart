import 'package:flutter/material.dart';
import 'package:brasileirao/models/trophy.dart';

class Team {
  int? id;
  String name;
  String shield;
  int points;
  Color color;
  int? idAPI;
  List<Trophy> trophies = [];

  Team({
    this.id,
    required this.name,
    required this.shield,
    required this.points,
    required this.color,
    this.idAPI,
    required this.trophies,
  });
}
