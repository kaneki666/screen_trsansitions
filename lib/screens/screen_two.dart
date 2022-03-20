import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final Animation<double> opacity = Tween<double>(
    begin: 1,
    end: 0.3,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        1,
        curve: Curves.easeOut,
      ),
    ),
  );
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center,
          child: ListView.builder(
              itemCount: widget.images.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: index != activeIndex ? opacity.value : 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Hero(
                                tag: index.toString(),
                                child: Image.network(
                                  widget.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              })),
    );
  }
}
