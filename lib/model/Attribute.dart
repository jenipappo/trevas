import 'package:trevas/model/AttributeType.dart';

class Attribute {
  final AttributeType type;

  int value;

  get percentage => value * 4;

  Attribute(this.type);
}

// TODO move this logic to damage calculation
//    super.value = base;
//    super.modifier = () {
//      if (base < 15) return 0;
//      return ((base - 15) / 2).floor();
//    }();
