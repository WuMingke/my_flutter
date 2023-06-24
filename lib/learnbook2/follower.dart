import 'package:flutter/material.dart';

class MyFollower extends StatefulWidget {
  const MyFollower({super.key});

  @override
  State<MyFollower> createState() => _MyFollowerState();
}

class _MyFollowerState extends State<MyFollower> {
  final _links = {};
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 50,
      itemBuilder: (_, index) {
        LayerLink link;
        if (_links.containsKey(index)) {
          link = _links[index];
        } else {
          link = LayerLink();
          _links[index] = link;
        }
        return Container(
          color: Colors.primaries[index % 18][200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CompositedTransformTarget(
                link: link,
                child: Text("this is item $index"),
              ),
              ElevatedButton(
                onPressed: () {
                  final entry = OverlayEntry(builder: (_) {
                    return CompositedTransformFollower(
                      offset: const Offset(20, 20),
                      showWhenUnlinked: false,
                      link: link,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    );
                  });
                  Overlay.of(context).insert(entry);
                },
                child: const Icon(
                  Icons.more_horiz,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
