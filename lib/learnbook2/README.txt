FittedBox   自动缩放尺寸

设置了Key之后，寻找对应关系时Flutter不但会检查组件在树中的位置和类型是否相同，还需要再检查Key值是否相等。
只有满足了这3个条件之后，State才会与新的Widget建立对应关系。

InheritedWidget向下传递数据 Notification向上冒泡事件

Flutter引擎完成布局只需以“深度优先”的顺序遍历一次组件树。在遍历的过程中，向下传递约束，向上传递尺寸。
具体来讲，在布局时，Flutter先由root的组件开始，一层层向下遍历全部组件，并向每个路过的子组件传入父组件的“尺寸约束”，
达到组件树的末梢时，再回头向上遍历，并在返回的路程中将每个子组件最终确定的尺寸依次传递给它们的父组件，父组件此时根据
子组件汇报的实际尺寸，决定如何摆放子组件。


FractionallySizedBox 可以将父级约束乘以一个倍数之后再传递给子组件 =》 可以用来打破父级约束

IgnorePointer 禁用点击响应

Draggable 可拖拽组件

OverlayEntry
    悬浮组件，遵从父组件的尺寸约束，通常沾满全屏
    直接使用Text组件，没有样式，是因为组件树上级缺少DefaultTextStyle组件，可以使用Material组件包裹
    在程序弹窗时可以直观地观察到Navigator将2个OverlayEntry压入Overlay中：首先它会压入barrier屏障层，然后才会压入弹窗的真正内容，
    这就是对话框周围有灰色区域的根本原因。
        opaque 参数：声明该悬浮内容是否能完全遮住整个屏幕，如果是，Flutter框架会自动优化被遮挡的组件层，使它们不再重绘
            如果需要重绘，可以设置 maintainState 参数，使它们不参与这个优化
        maintainState 参数：
    普通页面也同样存在屏障层，也可以在 MaterialPageRoute 传入 maintainState 参数，实现都是Navigator.of(context).push(

ModalBarrier/AnimatedModalBarrier 控制弹窗底部颜色

CompositedTransformTarget/CompositedTransformFollower 追随者可用于将OverlayEntry悬浮内容固定在某个元素附近
目标组件发生了位置变动，追随者也会自动更新，与目标位置保持重合

Flutter 提供了两种创建“匿名组件”的方法，分别是Builder组件和StatefulBuilder组件，用于创建匿名的StatelessWidget和StatefulWidget组件

DraggableScrollableSheet 底部上拉列表

Navigator:
Flutter 路由查找顺序
    根路由，home属性
    routes 属性
    onGenerateRoute 属性
    onUnknownRoute 属性，当路由不存在时，可以配置未知页面


PageRouteBuilder 组件 自定义路由，可构建转场动画

SliverToBoxAdapter 将 “Box约束” 转换成 “Sliver约束”：它将RenderBox布局协议转换成Sliver协议，
布局时，它首先将父级约束SliverConstraints转换成BoxConstraints，布局完成之后再将子组件最终确定的Size
转换成SliverGeometry并汇报给父组件


SliverFillViewport 组件。在List里面的“ViewPager”


Sliver主要解决2大问题：1多样式列表 2复杂的导航行为

SliverAppBar
FlexibleSpaceBar
