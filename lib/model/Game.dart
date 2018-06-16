import 'package:trevas/model/Model.dart';
import 'package:trevas/model/User.dart';

class Game extends Model {
  String name;
  String description;
  User master;
  User owner;
  int playerCount;
  int characterCount;

  Game(String id, this.name, this.description, this.master, this.owner, this.playerCount, this.characterCount) :  super(id);

}