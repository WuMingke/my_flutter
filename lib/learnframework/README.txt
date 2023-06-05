基于Dart的Zone机制：
    对于单线程的Dart语言来说，Zone的一个重要功能就是捕获异步逻辑产生的异常。
    在flutter tool中，Zone还负责 隔离每个FlutterCommand的运行环境

启动流程：
    1、Embedder启动流程
    Embedder层的关键类
        FlutterActivity FlutterFragment
                FlutterActivityAndFragmentDelegate
                FlutterEngine、FlutterView
                                    RenderSurface
                                        FlutterSurfaceView
                                        FlutterTextureView
                                        FlutterImageView
    2、FlutterEngine（Embedder层中的Java类）初始化

