import 'package:flutter/material.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

class AnimatedCirclePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AnimatedCirclePageState();
  }
}
class _AnimatedCirclePageState extends State<AnimatedCirclePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 4,),
      vsync: this,
    );
    animation = Tween(begin: 100, end: 200).animate(animationController);


    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }

  void animationStatusListener(AnimationStatus status) {

    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  Widget _buildCircle(radius) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Tween<double> _scaleTween = Tween<double>(begin: -1, end: 1);

    final md = MediaQuery.of(context);
    final maxWidth = md.size.width - (md.viewInsets.left + md.viewInsets.right);
    final maxHeight = md.size.height - (md.viewInsets.top + md.viewInsets.bottom);

    return Scaffold(
      appBar: AppBar(
        title: Text("Rotatingdff Circle"),
      ),

      /* body: Center(
        child: TweenAnimationBuilder(
          tween: _scaleTween,
          duration: Duration(seconds: 4),
          builder: (context,double scale,  child){
            log('scale is $scale');
            return Transform.translate(offset : Offset(scale*maxWidth, scale*maxHeight),transformHitTests: true,child: child,);
          },
          child: Text('what is '),

        ),
      ),*/

      //Mr: scaling using tween
      /*body: Center(
        child: TweenAnimationBuilder(
          tween: _scaleTween,
          duration: Duration(seconds: 4),
          builder: (context,double d,  child){
            return Transform.scale(scale: d ,child: child);
        },
          child: Text('what is '),

        ),
      ),*/



      //MR: below transform animation
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              Positioned(
                top: animationController.value*maxHeight,
                left: animationController.value*maxWidth,
                child: Transform(
                  transform: Matrix4.rotationZ(0.0001),
                  alignment: Alignment.center,
                  child: Text('H ${animationController.value}',
                      style: Theme.of(context).textTheme.headline4),
                ),
              ),
            ],
          );
          return Transform.rotate(
            child: child,
            angle: 3.1416 * 2 * animation.value,
            origin: Offset(0, 71),
          );
        },
      ),
    );
  }
}
