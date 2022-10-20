// void main() {
//   // for (int i = 0; i < 5; i++) {
//   //   print('hello ${i + 1}');
//   // }
//   // printNum(2);
//   // test();
//   // test2();
//   enableFlag(bold: null, hidden: false);
// }

// void main() {
//   // var a = A();
//   // var b = B();
//   //
//   // print(b is C);
//   // b.baz();
//   // (b as A).baz();
//
//   // var paint = Paint()
//   //   ..color = Color.fromARGB(1, 1, 1, 1)
//   //   ..blendMode =;
//
//   var num = 1;
//   switch (num) {
//     case 1:
//       print("111");
//       continue two;
//     two:
//     case 2:
//       print("222");
//       break;
//     default:
//       print("333");
//   }
// }

// void main() {
//   // try {
//   //   excep();
//   // }
//   // /* on NullThrownError {
//   //   print("333");
//   // } */
//   // catch (e) {
//   //   print(e.toString());
//   //   // rethrow;
//   //   // print("222");
//   // } finally {
//   //   print("final");
//   // }
//
//   // var d = D.origin();
//   // d.name = "3";
//   // d.name = 2;
//   //
//   // print(d.name);
//
//   var a = A();
//   var b = B();
//
//   // print(b is C);
//   // b.baz();
//   (b as A).baz();
// }

void main() async {
  var entrypoint = await findEntryPoint();
}

String findEntryPoint() {
  return "23";
}

class D {
  var name = "2";

  // D(this.name);
  D.origin() : name = "22";
}

void excep() {
  throw NullThrownError();
}

void foo() {}

class C {
  void baz() {
    print("CCCC");
  }
}

class B extends A {
  @override
  void baz() {
    // super.baz();
    // print("BBB");
  }
}

class A {
  static bar() {}

  void baz() {
    print("aaaa");
    print("AAA");
  }
}

Function makeAdder(int num) {
  return (int i) => i + num;
}

void testFunc2() {
  var list = [1, 2, 3];
  list.forEach(testFunc);
}

void testFunc(int element) {
  // print(element);
  var num = makeAdder(element);
  print(num(2));
}

void enableFlag({bool? bold, required bool? hidden}) {
  print("result => bold:$bold,hidden:$hidden");

  // repeat()
}

void test2() {
  var set = {2, 3, 4};
  print(set);

  var names = <String>{};
  var name2 = <String, int>{};
  var name3 = Map<String, int>;
}

void test() {
  var result = 3.141592653.toStringAsFixed(4);
  print(result);

  late var data = [1, 3, 4];

  var data2 = [5, ...data];
  // ...?
  print(data2);

  var nav = ['Home', 'Furniture', 'Plants', if (true) 'Outlet'];

  print(nav);

  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  print(listOfStrings);
}

//
void printNum(int num) {
  print("num is ${num + 1}");

  List<Object> date;
  List<Object> _data;
  Object _23ww;
  // int? num;
  int num2 = 0;
  // assert(num == 2);
  print("2222");

  int num4 = 4;
  int num3 = 3;

  // const num5 = num3 * num4;
  final num6 = num3 * num4;
  // num5 = 8;

  double x = 9;
}
