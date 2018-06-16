import 'package:trevas/model/Model.dart';

class User extends Model {
  final String name;
  final String email;

  User(String id, this.name, this.email) : super(id);
}