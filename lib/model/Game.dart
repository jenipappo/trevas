import 'package:trevas/model/Character.dart';
import 'package:trevas/model/User.dart';

class Game {
  final String id;

  String name;
  String description;
  User master;
  User owner;

  final List<Character> characters = List();

  Game(this.id, this.name, this.description, this.master, this.owner);

}