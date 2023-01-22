空安全：  ?.    !   late

class CommonModel {
    List names = []; // 定义时初始化
    final List colors; // 在构造方法中初始化
    late List urls; // 延迟初始化
    CommonModel(this.colors)
}

