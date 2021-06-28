import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/NewsListScreenBloc.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/ui/AddNewsScreen.dart';
import 'package:news_app/ui/NewsDetailScreen.dart';

class NewsListHome extends StatefulWidget {
  NewsListHome({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<NewsListHome> {
  final dbRef = FirebaseDatabase.instance.reference().child("MyNews");
  List<Map<dynamic, dynamic>> lists = [];

  final KEY_NEWS_TITLE = 'NewsTitle';
  final KEY_NEWS_DESCRIPTION = 'NewsDescription';
  final KEY_NEWS_IMAGE = 'NewsImage';

  @override
  Widget build(BuildContext context) {
    final bloc = NewsListScreenBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
      ),
      body: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            print('database snapshot inside');

            if (snapshot.hasData) {
              lists.clear();

              Map<dynamic, dynamic> values = snapshot.data!.value;
              values.forEach((key, values) {
                print('values is---= $values');
                lists.add(values);
              });

              return Stack(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Card(
                            margin: EdgeInsets.only(
                                left: 11, right: 11, top: 5, bottom: 5),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 12, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "News title: " +
                                        lists[index][KEY_NEWS_TITLE],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        textBaseline: TextBaseline.alphabetic),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    "News Description: " +
                                        lists[index][KEY_NEWS_DESCRIPTION],
                                    style: TextStyle(fontSize: 15),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            final item = lists[index];
                            bloc.navigateNext(NewsDetailScreen(
                                NewsModel.fromMapObject(item)));
                          },
                        );
                      }),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.navigateNext(AddNewsScreen());
                        },
                        child: Text('Add More News'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20), // Set padding
                        ),
                      ),
                    ),
                  )
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
