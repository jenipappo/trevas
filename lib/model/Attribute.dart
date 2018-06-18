import 'package:trevas/model/AttributeType.dart';

class Attribute {
  final AttributeType type;

  int value;

  int get percentage => value * 4;

  Attribute(this.type, [this.value]);
}
