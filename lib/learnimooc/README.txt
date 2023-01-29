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

异步：Future与FutureBuilder
    Future表示在接下来的某个时间的值或错误，提供then和catchError的链式调用，
    它有两种状态：
        pending：执行中
        complete：执行结束，要么成功要么失败
    常见用法：
        使用future.then获取future的值与捕获future的异常
        结合async,await
        future.whenComplete // 类似于try-catch的final
        future.timeout

    FutureBuilder是将异步操作和异步UI更新结合在一起的类
eg：MyHttpTest

本地存储：shared_preferences
    eg：SharedPreferenceTest

三种List：eg：ListTest

混合开发：
    Flutter与Native通信：
        Flutter定义了三种不同类型的Channel
        BasicMessageChannel：用于传递字符串和半结构化的信息，持续通信，收到消息后可以回复此次消息，如：Native将遍历到的文件信息陆续传递到Dart，在比如：Flutter将从服务端陆陆续获取到信息交个Native加工，Native处理完返回等；
        MethodChannel：用于传递方法调用（method invocation）一次性通信：如Flutter调用Native拍照；
        EventChannel: 用于数据流（event streams）的通信，持续通信，收到消息后无法回复此次消息，通过长用于Native向Dart的通信，如：手机电量变化，网络连接变化，陀螺仪，传感器等；
        这三种类型的类型的Channel都是全双工通信，即A <=> B，
        Dart可以主动发送消息给platform端，并且platform接收到消息后可以做出回应，同样，platform端可以主动发送消息给Dart端，dart端接收数后返回给platform端。


