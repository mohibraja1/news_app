import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text('News List'),
        ),
        body: Scaffold(
          body: FutureBuilder(

              future: dbRef.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {

                if (snapshot.hasData) {
                  lists.clear();

                  Map<dynamic, dynamic> values = snapshot.data!.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });

                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("News title: " + lists[index][KEY_NEWS_TITLE], style: TextStyle(fontSize: 18),),
                              Text("News Description: " + lists[index][KEY_NEWS_DESCRIPTION], style: TextStyle(fontSize: 15)),
                              Text("news Image: " + lists[index][KEY_NEWS_IMAGE], style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        );
                      });
                }

                return Center(child: CircularProgressIndicator());

              }),
        ));
  }
}
