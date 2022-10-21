Flutter中的四棵树
根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 Element 类。
根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自RenderObject 类。
根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 Layer 类。
真正的布局和渲染逻辑在 Render 树中，Element 是 Widget 和 RenderObject 的粘合剂，可以理解为一个中间代理。

State 中的保存的状态信息可以：
1 在 widget 构建时可以被同步读取。
2 在 widget 生命周期中可以被改变，当State被改变时，可以手动调用其setState()方法通知Flutter 框架状态发生改变，Flutter 框架在收到消息后，会重新调用其build方法重新构建 widget 树，从而达到更新UI的目的。
State 中有两个常用属性：
1 widget，它表示与该 State 实例关联的 widget 实例，由Flutter 框架动态设置。注意，这种关联并非永久的，因为在应用生命周期中，UI树上的某一个节点的 widget 实例在重新构建时可能会变化，但State实例只会在第一次插入到树中时被创建，当在重新构建时，如果 widget 被修改了，Flutter 框架会动态设置State. widget 为新的 widget 实例。
2 context。StatefulWidget对应的 BuildContext，作用同StatelessWidget 的BuildContext。


生命周期：
initState   当 widget 第一次插入到 widget 树时会被调用，对于每一个State对象，
            Flutter 框架只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等
didChangeDependencies()     当State对象的依赖发生变化时会被调用
build() 主要是用于构建 widget 子树的，会在如下场景被调用：
    在调用initState()之后
    在调用didUpdateWidget()之后
    在调用setState()之后
    在调用didChangeDependencies()之后
    在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其他位置之后
reassemble()    此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
didUpdateWidget()   在 widget 重新构建时，Flutter 框架会调用widget.canUpdate来检测 widget 树
                    中同一位置的新旧节点，然后决定是否需要更新，如果widget.canUpdate返回true则会调用此回调
deactivate()    当 State 对象从树中被移除时，会调用此回调。如果移除后没有重新插入到树中则紧接着会调用dispose()方法
dispose()   当 State 对象从树中被永久移除时调用；通常在此回调中释放资源

状态管理：
    Widget 管理自己的状态。
    Widget 管理子 Widget 状态。
    混合管理（父 Widget 和子 Widget 都管理状态）
如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父 Widget 管理。
如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由 Widget 本身来管理。
如果某一个状态是不同 Widget 共享的则最好由它们共同的父 Widget 管理
全局状态管理
    1 实现一个全局的事件总线
    2 使用一些专门用于状态管理的包，如 Provider、Redux

Dart 在单线程中是以消息循环机制来运行的，其中包含两个任务队列，一个是“微任务队列” microtask queue，另一个叫做“事件队列” event queue。微任务队列的执行优先级高于事件队列。
入口函数 main() 执行完后，消息循环机制便启动了。首先会按照先进先出的顺序逐个执行微任务队列中的任务，事件任务执行完毕后程序便会退出，但是，在事件任务执行的过程中也可以插入新的微任务和事件任务，在这种情况下，整个线程的执行过程便是一直在循环，不会退出，而Flutter中，主线程的执行过程正是如此，永不终止。
在Dart中，所有的外部事件任务都在事件队列中，如IO、计时器、点击、以及绘制事件等，而微任务通常来源于Dart内部，并且微任务非常少，之所以如此，是因为微任务队列优先级高，如果微任务太多，执行时间总和就越久，事件队列任务的延迟也就越久，对于GUI应用来说最直观的表现就是比较卡，所以必须得保证微任务队列不会太长。值得注意的是，我们可以通过Future.microtask(…)方法向微任务队列插入一个任务。
在事件循环中，当某个任务发生异常并没有被捕获时，程序并不会退出，而直接导致的结果是当前任务的后续代码就不会被执行了，也就是说一个任务中的异常是不会影响其他任务执行的。

Flutter布局
    基于 RenderBox 的盒模型布局。
    基于 Sliver ( RenderSliver ) 按需加载列表布局
上层组件向下层组件传递约束（constraints）条件。
下层组件确定自己的大小，然后告诉上层组件。注意下层组件的大小必须符合父组件的约束。
上层组件确定下层组件相对于自身的偏移和确定自身的大小（大多数情况下会根据子组件的大小来确定自身的大小）。

盒模型布局组件有两个特点：
组件对应的渲染对象都继承自 RenderBox 类。
在布局过程中父级传递给子级的约束信息由 BoxConstraints 描述。

BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息，包含最大宽高信息，子组件大小需要在约束的范围内
ConstrainedBox用于对子组件添加额外的约束
SizedBox用于给子元素指定固定的宽高
UnconstrainedBox 虽然在其子组件布局时可以取消约束（子组件可以为无限大），
                   但是 UnconstrainedBox 自身是受其父组件约束的，所以当 UnconstrainedBox 随着其子组件变大后，如果UnconstrainedBox 的大小超过它父组件约束时，也会导致溢出报错

Flex 弹性布局
Wrap Flow 流式布局
Stack Positioned 层叠布局
Align 调整一个子元素在父元素中的位置

注意，如果我们需要自定义布局策略，一般首选的方式是通过直接继承RenderObject，然后通过重写 performLayout 的方式实现

Center 居中组件
LayoutBuilder 可以在布局过程中拿到父组件传递的约束信息
         可以使用 LayoutBuilder 来根据设备的尺寸来实现响应式布局。
         LayoutBuilder 可以帮我们高效排查问题。比如我们在遇到布局问题或者想调试组件树中某一个节点布局的约束时 LayoutBuilder 就很有用。
Flutter 的build 和 layout 是可以交错执行的，并不是严格的按照先 build 再 layout 的顺序。

容器类Widget和布局类Widget都作用于其子Widget，不同的是：
布局类Widget一般都需要接收一个widget数组（children），他们直接或间接继承自（或包含）MultiChildRenderObjectWidget ；而容器类Widget一般只需要接收一个子Widget（child），他们直接或间接继承自（或包含）SingleChildRenderObjectWidget。
布局类Widget是按照一定的排列方式来对其子Widget进行排列；而容器类Widget一般只是包装其子Widget，对其添加一些修饰（补白或背景色等）、变换(旋转或剪裁等)、或限制(大小等)。

Padding 边距
DecoratedBox 背景、边框、渐变等
Transform 可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效
Container
Clip 裁剪  CustomClipper 自定义裁剪
FittedBox 空间适配
        FittedBox 在布局子组件时会忽略其父组件传递的约束，可以允许子组件无限大，即FittedBox 传递给子组件的约束为（0<=width<=double.infinity, 0<= height <=double.infinity）。
        FittedBox 对子组件布局结束后就可以获得子组件真实的大小。
        FittedBox 知道子组件的真实大小也知道他父组件的约束，那么FittedBox 就可以通过指定的适配方式（BoxFit 枚举中指定），让起子组件在 FittedBox 父组件的约束范围内按照指定的方式显示。
Scaffold 页面骨架

可滚动组件：
Flutter 中的可滚动主要由三个角色组成：Scrollable、Viewport 和 Sliver：
Scrollable ：用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建 Viewport 。
Viewport：显示的视窗，即列表的可视区域；
Sliver：视窗里显示的元素。
具体布局过程：
Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport 。
Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver。
Sliver 中对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 类型的对象）。

可滚动组件中有很多都支持基于Sliver的按需加载模型，如ListView、GridView，但是也有不支持该模型的，如SingleChildScrollView

ListView 原理
ListView 内部组合了 Scrollable、Viewport 和 Sliver，需要注意：
ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent ，则会使用 SliverFixedExtentList；如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，无论是是哪个，都实现了子组件的按需加载模型。

AnimatedList 有动画的ListView

PageView

AutomaticKeepAlive

TabBarView

CustomScrollView
    主要功能是提供一个公共的的 Scrollable 和 Viewport，来组合多个 Sliver

自定义 Sliver


NestedScrollView

Image 缓存？
动态化？马甲包？
























