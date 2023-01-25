空安全：  ?.    !   late

class CommonModel {
    List names = []; // 定义时初始化
    final List colors; // 在构造方法中初始化
    late List urls; // 延迟初始化
    CommonModel(this.colors)
}


命令式：手动处理每一个View的关系
声明式：（按"计划"）聚焦状态信息的变化

声明式的缺点：
1、逻辑和页面UI耦合，导致难以复用（页面代码膨胀，重复逻辑不停写）
2、跨组件数据交互麻烦
    eg：1、层层传递需要展示的字符串
        2、跨页面共享数据
3、高层级的setState()引起不必要的刷新

所以需要"状态管理"来解决

解偶：
原生：M
     V：对应Widget
     P：对应provider中的ChangeNotifier

provider 基于Flutter的树机制
    Element的定义，
    Provider.of() // 是一个往上找的方法

    provider依赖树机制，必须基于context；提供了子组件访问上层的能力

GetX框架：全局单例，任意位置可以获取；存在类型重复、内存回收问题

