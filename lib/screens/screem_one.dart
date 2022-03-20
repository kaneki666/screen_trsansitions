import 'package:flutter/material.dart';
import 'package:hero_animation/screens/screen_two.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CustomPageRoute(
                    enterPage: ScreenTwo(
                      images: images,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: index.toString(),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

List<String> images = [
  'https://images.pexels.com/photos/803290/pexels-photo-803290.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  'https://images.pexels.com/photos/208537/pexels-photo-208537.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  'https://images.pexels.com/photos/262977/pexels-photo-262977.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://images.pexels.com/photos/1166120/pexels-photo-1166120.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  'https://images.pexels.com/photos/162744/tomatoes-tomato-quiche-red-yellow-162744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  'https://images.pexels.com/photos/2909822/pexels-photo-2909822.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
];

class CustomPageRoute extends PageRouteBuilder {
  final Widget? enterPage;

  CustomPageRoute({required this.enterPage})
      : super(
            transitionDuration: const Duration(milliseconds: 1200),
            pageBuilder: (context, animation, secondaryAnimation) => enterPage!,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var fadeIn = Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                      curve: const Interval(.7, 1), parent: animation));
              var fadeOut = Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                      curve: const Interval(0, .2), parent: animation));
              return Stack(children: <Widget>[
                FadeTransition(
                    opacity: fadeOut, child: Container(color: Colors.white)),
                FadeTransition(opacity: fadeIn, child: child)
              ]);
            });
}
