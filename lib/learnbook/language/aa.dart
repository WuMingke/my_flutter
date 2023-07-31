import 'dart:math';

class AB {
  String? name;

  AB({this.name});

  // AB();
  AB.origin() {
    name = "";
  }

  void test() {
    bool next = Random().nextBool();
    if (next) {
    } else {
      name ??= "123";
    }

    List<int> _data = List.generate(30, (index) => index);
    for (final value in _data) {}
    int j = 0;

    print("-------${j.isEven}");
  }
}

void main() {
  AB ab = AB();
  ab.test();
}
