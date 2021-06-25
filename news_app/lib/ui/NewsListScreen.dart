import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/NewsListScreenBloc.dart';
import 'package:news_app/models/NewsModel.dart';

class NewsListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsList();
  }
}

class _NewsList extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    final mBloc = NewsListScreenBloc(context);

    List<NewsModel> newsList = [];

    mBloc.readAllNewsData().then((value) =>
    {

      newsList = value
    });

    return WillPopScope(
      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('News List'),
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: newsList.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = newsList[index];

            return ListTile(
              title: Text(item.newsTitle),
              subtitle: Text(item.newsDesctiption),
            );
          },
        ),
      ),
    );
  }
}
