布局：
    尺寸特性
    约束特性

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

Wrap:
[1]: 默认情况下，Wrap 施加约束的特点: 在 [主轴] 方向上 [放松约束]，在 [交叉轴] 方向上 [无限约束]。
[2]: Wrap 的 children 列表中的组件，所受到的约束都是一致的。

Stack:
[1]: loose 下,  宽高尽可能 [放松约束]。
[2]: expand 下,  施加 [强约束]，约束尺寸为自身受到约束的 [最大尺寸]。
[3]: passthrough 下,  仅 [传递约束]，把自身受到的约束原封不动的施加给子级。
[4]: Stack 的 children 列表中的组件，所受到的约束都是一致的。