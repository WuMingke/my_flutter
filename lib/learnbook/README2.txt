线程模型
    Engine不会自己创建和管理线程，线程的创建和管理是由Embedder层负责的，同时Embedder还负责事件循环、平台插件管理等相关逻辑
    Embedder指的是Flutter和运行平台之间的中间层架构

    Engine有四个运行任务：UI Task Runner、Platform Task Runner、GPU Task Runner、IO Task Runner，默认运行在不同的线程上
    UI Task Runner 会执行Dart的 root isolate 去启动运行App的main方法，如果被阻塞界面会卡顿
    Platform Task Runner 是Engine的主线程，为确保线程安全，Flutter中所有和Engine的调用都会通过它，如果发生严重阻塞会发生ANR
    GPU Task Runner 将 UI Task Runner 提交的Layer Tree转化为Skia所需要的绘制指令，通过延迟调度和Buffer来保证绘制任务的流程运行
    IO Task Runner 处理耗时操作

    Dart属于单线程模型，主要是通过消息循环机制来实现任务调度和处理，其中主要有两个任务队列：MicroTask队列、Event队列
    应用启动之后，消息队列就开始工作，首先对MicroTask中的任务进行处理，之后再处理Event中的事件，如果不存在任务和事件时，Flutter会退出运行
    MicroTask主要来自Flutter内部的任务触发，
    Event事件来源于触摸、绘制等外部事件
    如果MicoTask中的任务太多会导致对外部事件的响应过慢，造成卡顿

    在Flutter中常见的async/await和Future等异步执行，并不是真的异步，而是在单线程上的任务调度，一般成为协程。协程并不像线程一样具备
    并发执行功能。当一个async方法被执行时，它内部的代码其实就是一个方法，当程序遇到await时，表示这个方法需要等待结果，这个时候程序会跳过
    这个片段继续执行其它逻辑，然后在下次轮巡时，再判断是否已经有结果返回，是否可以继续往下执行之前的任务
    https://juejin.cn/post/7025200193729462302#heading-5

手势与触摸
    原生层将所有事件打包下发，最后在Dart层的_dispatchPointerDataPacket方法内，通过_unpackPointerDataPacket方法解析成可以用的
    PointerDataPacket对象。

    手势事件都从_dispatchPointerDataPacket开始，之后会通过Zone判断环境进行回调，最后返回到GestureBinding类中的_handlePointerEvent
    方法，开始处理手势事件
    _handlePointerEvent方法主要通过hitTest和dispatchEvent两个方法实现了关键逻辑
    hitTest：得到包含所有待处理控件列表HitTestResult
    dispatchEvent：进行事件分发并产生竞争，最终胜利者可以得到事件的响应权
    事件竞争：
        通过一个竞技场，各个控件参与竞争，只有符合以下两个条件之一的，才可以得到事件的处理权
        1、最后得到直接胜利的控件
        2、活到最后的控件中排在列表第一位的控件

状态管理
    1、State + InheritedWidget：通过State保存数据和管理状态，通过InheritedWidget实现数据共享
        State支持跨帧保存信息，所以Widget可以实现跨帧的状态恢复。当执行setState方式时，Sate内部会通过调用markNeedsBuild方法，
        将State对应的Element标记为dirty，从而在下一帧执行WidgetsBinding.drawFrame时更新界面信息。
        InheritedWidget 可以实现往下传递共享，然后child通过BuildContext可以往上获取InheritedWidget中的数据。
    2、Stream
        首先需要创建StreamController对象，然后通过它获取StreamSink对象用于事件入口，再通过它获取Stream对象用于监听数据变化，
        最后通过Stream的listen监听得到StreamSubscription对象用于管理事件订阅，并且在不需要时结束订阅。
    3、


    // TODO: 2022/12/6 mingKE 私有属性？？？



