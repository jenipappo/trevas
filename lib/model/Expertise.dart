import 'package:trevas/model/Attribute.dart';

class Mastery {
  final String name;
  final Attribute attribute;

  int points;

  Mastery(this.name, this.attribute, this.points);

  get percentage => attribute?.value ?? 0 + points;
}
