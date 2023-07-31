import 'dart:isolate';

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

  void b() {
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

class C {
  String ccc() => "";
}

abstract class C1 {
  void c1();
}

// mixin 是在多个类层次结构中重用代码的一种方式
// 实现mixin，就创建一个继承Object类的子类（不能继承其它类），不声明任何构造方法，不调用super
class G extends B with C, C1 {
  @override
  void c1() {
    print("c1");
  }
}

class ModelA {
  String name = "";
  String tag = "";
  int _id = 0;

  // getter/setter;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  ModelA(this.name, this.tag); // 通过this关键字初始化变量

  // ModelA(this.name);

  ModelA.forName(this.name); // 命名构造方法

  ModelA.empty();

  // 2命名工厂构造方法
  // 它可以有返回值，而且不需要将类的final变量作为参数，是提供一种灵活获取类对象的方式
  factory ModelA.create(ModelA modelA) {
    return ModelA(modelA.name, modelA.tag);
  }
}

// 1工厂构造方法
class Logger {
  static Logger? _cache;

  // Dart线程安全
  factory Logger() {
    _cache ??= Logger._internal();
    return _cache!;
  }

  Logger._internal(); // 私有的命名构造

/**
 * 在使用的时候
 * Logger log1 = Logger()
 * Logger log2 = Logger()
 * print(log1 == log2)  返回为true
 */
}

// 私有方法的作用域是 当前文件
