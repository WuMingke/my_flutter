异常：
    Flutter不强制处理异常：Dart 采用事件循环的机制来运行任务，所以各个任务的运行状态是互相独立的。
    也就是说，即便某个任务出现了异常我们没有捕获它，Dart 程序也不会退出，只会导致当前任务后续的代码不会被执行，用户仍可以继续使用其他功能
    如果是Engine层的C++代码异常，会崩溃

    捕获异常的方式：
    App异常：
        a、同步：try-catch
        b、异步：Future.catchError
            两者不能混用
        c、集中管理：Zone.runZoned 的 onError 函数
    Framework异常：
        a、ErrorWidget.builder
        b、FlutterError.onError
            都可以放在Zone中
    异常上报：
        Bugly，需要定义Dart层插件，这里也涉及到Flutter与原生的通信，Flutter->原生->Bugly
        https://time.geekbang.org/column/article/141164
    并发 Isolate 的异常如何采集：
        并发 Isolate 的异常是无法通过 try-catch 来捕获的。并发 Isolate 与主 Isolate 通信是采用 SendPort 的消息机制，
        而异常本质上也可以视作一种消息传递机制。所以，如果主 Isolate 想要捕获并发 Isolate 中的异常消息，
        可以给并发 Isolate 传入 SendPort。而创建 Isolate 的函数 spawn 中就恰好有一个类型为 SendPort 的 onError 参数，
        因此并发 Isolate 可以通过往这个参数里发送消息，实现异常通知。

跨组件传递数据：
    属性传值：
        适合在同一个视图树中使用，传递方向由父及子，通过构造方法将值以属性的方式传递过去，简单高效。
        其缺点是，涉及跨层传递时，属性可能需要跨越很多层才能传递给子组件，导致中间很多并不需要这个属性的组件，
        也得接收其子 Widget 的数据，繁琐且冗余。
    InheritedWidget：
        适用于子 Widget 主动向上层拿数据的场景，传递方向由父及子，可以实现跨层的数据读共享。
        InheritedWidget 也可以实现写共享，需要在上层封装写数据的方法供下层调用。
        其优点是，数据传输方便，无代码侵入即可达到逻辑和视图解耦的效果；
        而其缺点是，如果层次较深，刷新范围过大会影响性能。
    Notification：
        适用于子 Widget 向父 Widget 推送数据的场景，传递方向由子及父，可以实现跨层的数据变更共享。
        其优点是，多个子元素的同一事件可由父元素统一处理，多对一简单；
        而其缺点是，Notification 的自定义过程略繁琐。
    EventBus：
        适用于无需存在父子关系的实体之间通信，订阅者需要显式地订阅和取消。
        其优点是，能够支持任意对象的传递，一对多的方式实现简单；
        而其缺点是，订阅管理略显繁琐。









