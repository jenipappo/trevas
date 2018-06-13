import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trevas/model/Game.dart';
import 'package:trevas/repository/Repository.dart';

class GameRepository extends Repository<Game>{
  GameRepository() : super(Firestore.instance.collection("game"));
}

