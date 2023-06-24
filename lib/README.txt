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
createState()->
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

Flutter应用的生命周期

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

return _show ? const FlutterLogo() :const SizedBox(); // 实现控件隐藏，类似于返回空字符串 “”


盒模型布局组件有两个特点：
组件对应的渲染对象都继承自 RenderBox 类。
在布局过程中父级传递给子级的约束信息由 BoxConstraints 描述。

BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息，包含最大宽高信息，子组件大小需要在约束的范围内
ConstrainedBox用于对子组件添加额外的约束
    有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突。
    对于maxWidth和maxHeight来说，内层控件的大小只跟自己最近的那个父控件的限制有关。
SizedBox用于给子元素指定固定的宽高，"尺寸无法违背父级约束"，
UnconstrainedBox 虽然在其子组件布局时可以取消约束（子组件可以为无限大），
                   但是 UnconstrainedBox 自身是受其父组件约束的，所以当 UnconstrainedBox 随着其子组件变大后，如果UnconstrainedBox 的大小超过它父组件约束时，也会导致溢出报错

Flex 弹性布局 和Expanded组件配合实现弹性布局
Wrap Flow 流式布局  Flow比较难

Stack Positioned 层叠布局 实现绝对定位 Stack自身尺寸变大只是子组件变大后的一个副作用
Align 调整一个子元素在父元素中的位置，可以使子组件溢出

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
    Transform 的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，
                所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
    RotatedBox 和 Transform.rotate 功能相似，但是它的变换是在layout阶段，会影响在子组件的位置和大小
Container
Clip 裁剪  CustomClipper 自定义裁剪
FittedBox 空间适配，适配原理：
        FittedBox 在布局子组件时会忽略其父组件传递的约束，可以允许子组件无限大，即FittedBox 传递给子组件的约束为（0<=width<=double.infinity, 0<= height <=double.infinity）。
        FittedBox 对子组件布局结束后就可以获得子组件真实的大小。
        FittedBox 知道子组件的真实大小也知道他父组件的约束，那么FittedBox 就可以通过指定的适配方式（BoxFit 枚举中指定），让起子组件在 FittedBox 父组件的约束范围内按照指定的方式显示。
Scaffold 页面骨架

可滚动组件：
Flutter 中的可滚动主要由三个角色组成：Scrollable、Viewport 和 Sliver：
    Scrollable ：用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建 Viewport 。
    Viewport：显示的视窗，即列表的可视区域；默认缓存250逻辑像素
    Sliver：视窗里显示的元素。Sliver 并不是 ListView 里的一个个条目组件，而是 ListView 的整个内容主体.
    整个滑动的流程就是 Scrollable 组件将偏移量交给 Viewport 组件， Viewport 组件根据自己的 尺寸 和 偏移量 ，来显示 slivers 的部分内容
具体布局过程：
    Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport 。
    Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver。
    Sliver 中对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，
            保存在 geometry 中（一个 SliverGeometry 类型的对象）。

模板方法模式：定义一个操作中的算法骨架，而将算法的一些步骤延迟到子类中，使得子类可以不改变该算法结构的情况下重定义该算法的某些特定步骤

可滚动组件中有很多都支持基于Sliver的按需加载模型，如ListView、GridView，但是也有不支持该模型的，如SingleChildScrollView
所以SingleChildScrollView最好在内容不会超过屏幕太多时使用

ListView 原理
ListView 内部组合了 Scrollable、Viewport 和 Sliver，需要注意：
ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent ，则会使用 SliverFixedExtentList；(优先使用)
如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，（优先使用）无论是是哪个，都实现了子组件的按需加载模型。
  shrinkWrap: true,  属性会立刻加载所有元素，所以消耗资源

Flutter 中手势的冲突时，默认的策略是子元素生效
如果 CustomScrollView 有孩子也是一个完整的可滚动组件且它们的滑动方向一致，则 CustomScrollView 不能正常工作
CustomScrollView 组合 Sliver 的原理是为所有子 Sliver 提供一个共享的 Scrollable，然后统一处理指定滑动方向的滑动事件

滚动监听
    Flutter Widget树中子Widget可以通过发送通知（Notification）与父(包括祖先)Widget通信。
    父级组件可以通过NotificationListener组件来监听自己关注的通知
    可滚动组件在滚动时会发送ScrollNotification类型的通知，ScrollBar正是通过监听滚动通知来实现的。
    通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同：
    通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。
    而ScrollController只能和具体的可滚动组件关联后才可以。
    收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，
    通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只能获取当前滚动位置。

Sliver 的布局协议如下：
    Viewport 将当前布局和配置信息通过 SliverConstraints 传递给 Sliver。
    Sliver 确定自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 类型的对象）。
    Viewport 读取 geometry 中的信息来对 Sliver 进行布局和绘制。

AnimatedList 有动画的ListView

PageView

AutomaticKeepAlive

TabBarView

CustomScrollView
    主要功能是提供一个公共的的 Scrollable 和 Viewport，来组合多个 Sliver

自定义 Sliver

Sliver布局模型和盒布局模型
两者布局流程基本相同：父组件告诉子组件约束信息 > 子组件根据父组件的约束确定自生大小 > 父组件获得子组件大小调整其位置。不同是：
    父组件传递给子组件的约束信息不同。盒模型传递的是 BoxConstraints，而 Sliver 传递的是 SliverConstraints。
    描述子组件布局信息的对象不同。盒模型的布局信息通过 Size 和 offset描述 ，而 Sliver的是通过 SliverGeometry 描述。
    布局的起点不同。Sliver布局的起点一般是Viewport ，而盒模型布局的起点可以是任意的组件。

// TODO: 2022/10/26 mingKE  NestedScrollView 学习
NestedScrollView？

WillPopScope 返回键拦截

数据共享  InheritedWidget  重要！！！
状态管理的一般原则是：
如果状态是组件私有的，则应该由组件自己管理；如果状态要跨组件共享，则该状态应该由各个组件共同的父元素来管理。

按需rebuild：ValueListenableBuilder
    组件和数据流向无关，可以实现任意流向的数据共享。
    实践中，ValueListenableBuilder 的拆分粒度应该尽可能细，可以提高性能。

异步UI更新（FutureBuilder、StreamBuilder）

手势事件
当指针按下时，Flutter会对应用程序执行命中测试(Hit Test)，以确定指针与屏幕接触的位置存在哪些组件（widget），
指针按下事件（以及该指针的后续事件）然后被分发到由命中测试发现的最内部的组件，然后从那里开始，
事件会在组件树中向上冒泡，这些事件会从最内部的组件被分发到组件树根的路径上的所有组件。

忽略指针事件：
    AbsorbPointer：本身会参与命中测试，自己可以响应事件，但是子控件不行
    IgnorePointer：本身不会参与命中测试

手势识别：
    GestureDetector：
    GestureRecognizer：

解决手势冲突：2个方法：
    1、使用 Listener。这相当于跳出了手势识别那套规则。 // 实时跟踪当前光标位置
    2、自定义手势手势识别器（ Recognizer）。

Flutter事件机制：
    Flutter 事件处理流程主要分两步，为了聚焦核心流程，我们以用户触摸事件为例来说明：
    1、命中测试：当手指按下时，触发 PointerDownEvent 事件，按照深度优先遍历当前渲染（render object）树，
    对每一个渲染对象进行“命中测试”（hit test），如果命中测试通过，则该渲染对象会被添加到一个 HitTestResult 列表当中。
    2、事件分发：命中测试完毕后，会遍历 HitTestResult 列表，调用每一个渲染对象的事件处理方法（handleEvent）
    来处理 PointerDownEvent 事件，该过程称为“事件分发”（event dispatch）。随后当手指移动时，便会分发 PointerMoveEvent 事件。
    3、事件清理：当手指抬（ PointerUpEvent ）起或事件取消时（PointerCancelEvent），会先对相应的事件进行分发，
    分发完毕后会清空 HitTestResult 列表。

    需要注意：
    1、命中测试是在 PointerDownEvent 事件触发时进行的，一个完成的事件流是 down > move > up (cancel)。
    2、如果父子组件都监听了同一个事件，则子组件会比父组件先响应事件。这是因为命中测试过程是按照深度优先规则遍历的，
    所以子渲染对象会比父渲染对象先加入 HitTestResult 列表，又因为在事件分发时是从前到后遍历 HitTestResult 列表的，
    所以子组件比父组件会更先被调用 handleEvent 。

通知 Notification

动画：Animation、Curve、Controller、Tween

自定义组件：3种方式
    1、组合其他组件
    2、自绘
    3、实现RenderObject

原理：// TODO: 2022/10/28 mingKE 还没看
https://book.flutterchina.club/chapter14/



Image 缓存？
动态化？马甲包？


开发体验很差：
代码提示
自动补全
不自动导包
源码阅读
解决报错不清晰



Flutter 图片加载与缓存原理
1 是谁加载了图片
2 图片是如何加载的
3 图片是如何解码的
4 图片是如何缓存的
5 图片缓存的key是怎么生成的
6 如何设置缓存大小

列表图片优化：
    内存缓存
    本地缓存：cached_network_image插件

    默认1000张、100M、LRU
    PaintingBinding.instance.imageCache.maximumSize


// TODO: 2023/2/12 mingKE 复制！！

快速排序就是个二叉树的前序遍历，归并排序就是个二叉树的后序遍历

前序位置的代码在刚刚进入一个二叉树节点的时候执行；

后序位置的代码在将要离开一个二叉树节点的时候执行；

中序位置的代码在一个二叉树节点左子树都遍历完，即将开始遍历右子树的时候执行。






















