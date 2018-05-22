import 'package:trevas/model/User.dart';

class Game {
  String _id;
  String _name;
  String _description;
  User _master;
  User _owner;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  User get master => _master;
  User get owner => _owner;

  Game(this._id, this._name, this._description, this._master, this._owner);

}