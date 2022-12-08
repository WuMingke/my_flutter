import 'package:my_flutter/learnbook/language/aa.dart';

void main() {
  // var g = G();
  // g.a();
  // g.b();
  // g.c();

  var ab = AB("1");
  // ab._name; 私有属性跨文件才有效
}

abstract class Base {
  a() {
    print("base a");
  }

  b() {
    print("base b");
  }

  c() {
    print("base c");
  }
}

class A extends Base {
  a() {
    print("A.a()");
  }

  b() {
    print("A.b()");
    super.b();
  }
}

class A2 extends Base {
  a() {
    print("A2.a()");
    super.a();
  }
}

class B extends Base {
  a() {
    print("B.a()");
    super.a();
  }

  b() {
    print("B.b()");
    super.b();
  }

  c() {
    try {} catch (e) {
      print("");
    }
    print("B.c()");
    super.c();

    var m = ModelA("", "");
    m.id;
  }
}

// class G extends B with A, A2 {}  这里有问题

class ModelA {
  String name = "";
  String tag = "";

  // String _id = "2";

  int get id => 0;

  // set id(String value) {
  //   _id = value;
  // }

  ModelA(this.name, this.tag);

  // ModelA(this.name);

  ModelA.forName(this.name);

  ModelA.empty();
}
