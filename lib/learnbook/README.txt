const 用于表示编译时常量，static const 表示静态常量
final 运行时才能确定值

var与dynamic
    Dart属于强类型语言，但可以使用var声明变量，Dart对于var声明会自推导出数据类型。实际上var是编译期的语法糖，
    而dynamic声明才表示动态类型，dynamic被编译后是一个object类型，在编译期间不对任何的类型进行检查，而是在运行时对类型进行检查。

方法参数可以不声明类型
    void getDao(name, id, {branch = "213"}) {}

方法可以作为另一个方法的参数

如果类实现了call()方法，则该类的对象可以作为方法使用

mixins混入
    混入时的基础顺序是从右到左依次执行，而且和super方法是否执行有关
    当多种关键字同时实现时，顺序是 extends mixins implements

构造方法
    默认构造只能有一个，其余的定义通过 "类型.xxx()"模式实现

Isolate
    Dart在单线程模式中增加了Isolate提供跨线程的真异步操作。
    Dart中线程不共享内存，所以也不存在死锁，从而也导致了Isolate之间的数据只能通过port的端口方式发送接口，所以Isolate也称为隔离的执行

Zone
    Dart可通过Zone表示指定的代码执行环境：  runZoned(() => null)

异步
    async/await
    Future
    Stream （async*/yield）

路由跳转
    命名路由跳转：
    直接使用Route跳转：

Key
    Key可用于控制控件如何替代渲染树中的另一个控件。一个Widget的runtimeType和Key结合，可以用于这个Widget的基本标识。
    比如控制更新：
      static bool canUpdate(Widget oldWidget, Widget newWidget) {
        return oldWidget.runtimeType == newWidget.runtimeType
            && oldWidget.key == newWidget.key;
      }
    所以如果具备相同的Key，那么这个Widget就可能被Element复用。
    通过Key可以获取到Widget，从而获取到BuildContext，从而获取到对应的RenderBox，从而可以获取到Widget的大小位置等。

    常见的Key：ValueKey、ObjectKey、UniqueKey、PageStorageKey

SafeArea控件：使用MediaQueryData，留出padding的距离

懒加载：FutureBuilder、StreamBuilder

不应该在StatelessWidget内声明非final的成员变量

Widget和Element是多对一的关系
Element和RenderObject是一对一的关系

Element在初始化时将Widget实例作为参数传入，所以Element在创建时就持有了Widget对象，而后Element对象在被mount后，
会调用Widget的createRenderObject方法，创建出对应的RenderObject

Widget作为配置文件描述如何渲染界面，多个Widget会组合成Widget Tree；
Element表示Widget Tree中特定位置的实例，多个Element在mount之后，会构成一棵Element Tree；
Element只有在mount之后才算激活，激活之后如果Element存在RenderObject，Element会通过Widget的createRenderObject
    方法创建出对应的RenderObject，并与Element一一绑定

MVP ？
widget renderObject element

RenderObject
    真正的绘制实例，实际控件中一般不会直接使用，大部分情况下，会是其子类RenderBox、RenderSliver

一般情况下，RenderBox的performLayout流程可以理解为向下输入Constraints，然后向上返回了Size

Layer
    RenderObject和Layer之间是多对一的关系，但是并非所有的RenderObject都有Layer，这
        受到isRepaintBoundary和alwaysNeedsCompositing的影响

StatelessWidget和StatefulWidget的Element都是ComponentElement，并且都不具备RenderObject

生命周期对比
                    Widget              Element                  State
parent Element   createElement       new Element              createState
inflate Widget                      _state.element = this
                                    _state.widget = widget

                                         mount               initState、didChangeDependencies

                                    markNeedsBuild              setState

                                    rebuild                     didUpdateWidget

                                    unmount                     dispose

_state.element = this
_state.widget = widget
State初始化时会持有Element和Widget，而Element又是BuildContext，所以通过State可以获取他们

ViewPort
    提供可滑动窗口，RenderSliver对应的Sliver相关控件需要在ViewPort下使用

InheritedWidget 共享状态
    每个Element的内部都有一个Map<Type, InheritedElement>? _inheritedWidgets;成员变量，当本身或者父控件是InheritedWidget时
    会初始化，当父控件是InheritedWidget时，这个Map会在Element中被一级一级往下传递与合并

ErrorWidget
    红色的错误界面，可以自定义


