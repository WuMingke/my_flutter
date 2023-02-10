Key的学习
    Widget与Element的关系：element会尽量保持不变，通过 类型和Key 对比区别
    这就造成了，在同一级别，同一类型的一系列控件，如果不传key的话，
            flutter就分不清它们之间的对应关系，尤其是当空间内需要做位置变化的时候
    直接能在Widget内修改的数据，那么能够正确反映到界面上，而需要更新State的就不一定了，因为State是单独管理的。

    LocalKey：
        同一级别内，需要有唯一性
        ValueKey:对比的是属性
        ObjectKey:对比的是实例是否一样
        UniqueKey:只和自己相等。每次的key都不一样，那么state每次都会刷新，（强行丢掉状态，这个可以通过定义全局变量解决）

    GlobalKey：
        整个app内，需要有唯一性


滚动：

异步：
void sync() async {
  await Future.delayed(Duration.zero);
  print("");
}

void sync1() {
  Future.delayed(Duration.zero, () {
    print("");
  });
}

void sync2() {
  Future.delayed(Duration.zero).then((value) => print(""));
}

都是一样的。

Future<int> getFuture() async {
    return 100;
}

async修饰自动返回一个Future，

int result = await getFuture();

await 自动"打开"Future

async-await 语法糖，简便了sync1()、sync2()两种方式

void main(){
    Event Loop --> (一直会检查 Event Queue)
                    Microtask Queue 比 Event Queue 优先级更高，
}

Future 把它想像成一个盒子，在稍后打开它
    直接立即运行的情况：Future.sync()
                 Future.value()
                 _.then()
    添加到Microtask的情况：scheduleMicrotask()
                        Future.microtask()
                        已经完成的future继续调用then()方法
    添加到Event Queue的情况：Future()
                           Future.delayed()

FutureBuilder
    只需要判断snapshot.hasData hasError 继续了，两者是互斥的


Stream
    Future返回一个值，Stream返回一连串的值
    Future是在状态为done的时候获得结果，Stream是在active状态的时候获得结果，done表示数据流已经关闭。

    StreamController:生成一个stream，并可以监听、关闭它，相当于一个工具类
    final controller = StreamController()
    controller.sink.add() // 添加数据
    controller.stream.listen((event){}) // 监听数据
    controller.close() // 关闭流

    Stream默认不能被同时监听，（StreamController，StreamBuilder都可以监听Stream）
    如果要实现同时监听的话，可以调用controller.broadcast(),将其变成一个广播，就可以多方监听
    但是广播不会被缓存，普通的Stream数据会被缓存

类似Future，Stream的语法糖
    Stream<int> getNumbers() async*{  // 这里多了一个*
        while(true){
            await Future.delayed(Duration(seconds:1));
            yield 1;
        }
    }
    以上，getNumbers()每隔一秒返回一个1

    StreamTransformer:接收一个stream，做处理后返回一个stream


... 拆分操作符