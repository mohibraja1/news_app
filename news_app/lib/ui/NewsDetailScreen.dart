import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsModel newsModel;

  NewsDetailScreen(this.newsModel);

  @override
  _NewsDetailState createState() => _NewsDetailState(newsModel);
}

class _NewsDetailState extends State<NewsDetailScreen> {
  NewsModel newsModel;

  _NewsDetailState(this.newsModel);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail',style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(11),
          child: Column(

            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "News title: " + newsModel.newsTitle,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),

              previewImage(),

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "News Description: " + newsModel.newsDesctiption,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  previewImage() {

    if (newsModel.imagePath.isNotEmpty) {

      return Container( margin : EdgeInsets.only(top: 20,bottom: 20),child: Image.network(newsModel.imagePath));
    } else
      return Container(
        height: 1,
      );
  }
}
