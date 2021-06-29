import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/SplashScreen.dart';

import '../main.dart';

class Spll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Spll> {
  NetworkImage networkImage = NetworkImage('https://picsum.photos/250?image=9');
  bool ready = false;

  void _updateImage(ImageInfo imageInfo, bool synchronousCall) {
    print("ready");


    setState(() {
      ready = true;
    });
  }

  @override
  void initState() {
    ImageStream imageStream =
    networkImage.resolve(createLocalImageConfiguration(context));
    final ImageStreamListener listener = ImageStreamListener(_updateImage);
    imageStream.addListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Fade in images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            ready == true
                ? Container(
              child: Text("CircularProgressIndicator disappear"),
            )
                : Center(child: CircularProgressIndicator()),
            FadeInImage(
              placeholder: NetworkImage("https://picsum.photos/250?image=9"),
              image: networkImage,
            ),
            /*  Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://picsum.photos/250?image=9',
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}