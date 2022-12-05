void main() {
  var v = Variable();
  // v._ratio = 2;
  v.getDao("2", 2, branch: "22");

  CallObject callObject = CallObject();
  callObject(11, 11.0);
}

class Variable {
  static const double _ratio = 0;

  num i = 0;

  void test() {
    i.isNaN;
    if (i.isNaN) {}
    var list0;
    var list = [1, 2, ...?list0];

    var aSet = {"1", "2"};
    var aMap = {"1": "one", "2": "two"};

    UserType.guest;

    // dynamic i = "";
    // i++;
  }

  void getDao(name, id, {branch = "213"}) {} // 方法参数可以不声明类型

  String getResult(double key) {
    return (key < 0) ? "2" : "1";
  }

  String getResult2(double key) => (key < 0) ? "2" : "1";
}

enum UserType { guest, vip }

class CallObject {
  call(int i, double e) => "$i  xxx $e";

  del(String name) {}
}
