class Experience {

  int _value;
  int _level;

  get value => _value;
  get level => _level;

  set value(value) {
    _value = value;
    _level = _xpToLevel.lastIndexWhere((xp) => value >= xp) + 1;
  }

  List<int> _xpToLevel = [ 0, 5, 15, 30, 50, 80, 120, 180, 250, 400, 550, 800, 1100, 1600, 2200 ];
}