布局：
    尺寸特性
    约束特性

    向下传递约束，向上传递尺寸：widget树只需要遍历一遍

约束：
    Flutter里的约束就两种 BoxConstraints、SliverConstraints

    紧约束：BoxConstraints.tight(Size size)

    如何打破紧约束
[1] 通过 UnconstrainedBox [解除约束]，让自身约束变为 [无约束]。
[2] 通过 Align、Flex 等组件 [放松约束]，让自身约束变为 [松约束]。
[3] 通过 CustomSingleChildLayout 等自定义布局组件施加 [新约束]。

盒约束传递链:
    盒约束会随着渲染树自上而下进行传递，每个渲染节点都会根据自身的布局特点，
    对接收到的约束进行处理，然后继续向下传递。

获取父级施加的盒约束:LayoutBuilder

Flex:
[1]: 默认情况下，Flex 施加约束的特点: 在 [主轴] 方向上 [无限约束]，在 [交叉轴] 方向上 [放松约束]。
[2]: Wrap 的 children 列表中的组件，所受到的约束都是一致的。

它内部管理的组件分两类，一类是Flexible的，另一类是非Flexible的，在布局的时候，会先给非Flexible的组件空间，然后
把剩余的部分，按比例分给Flexible的

Wrap:
[1]: 默认情况下，Wrap 施加约束的特点: 在 [主轴] 方向上 [放松约束]，在 [交叉轴] 方向上 [无限约束]。
[2]: Wrap 的 children 列表中的组件，所受到的约束都是一致的。

Stack:
[1]: loose 下,  宽高尽可能 [放松约束]。
[2]: expand 下,  施加 [强约束]，约束尺寸为自身受到约束的 [最大尺寸]。
[3]: passthrough 下,  仅 [传递约束]，把自身受到的约束原封不动的施加给子级。
[4]: Stack 的 children 列表中的组件，所受到的约束都是一致的。

它内部管理的组件分为两类，一类是有位置的，另一类是没有位置的，有位置专门指Position包裹的控件，在布局的时候，
它先布局没有位置的，然后把自己的尺寸调整到跟没有位置的组件中的那个一样大，最后摆放有位置的。如果都是有位置的，
那么它的大小就是无限大（因为这样才有意义啊，才能让Position发挥作用）。如果Position不传位置约束的话，就会被当作
无位置的组件处理。

Container 的尺寸：一般情况：
    有child就匹配尺寸,除非有对齐的情况
    没有child就越大越好,除非约束没有边界

CustomMultiChildLayout

自定义RenderObject
