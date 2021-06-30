import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/viewmodels/NewsDetailScreenVM.dart';
import 'package:stacked/stacked.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsModel newsModel;

  NewsDetailScreen(this.newsModel);

  @override
  _NewsDetailState createState() => _NewsDetailState(newsModel);
}

class _NewsDetailState extends State<NewsDetailScreen> {
  NewsModel newsModel;

  _NewsDetailState(this.newsModel);

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsDetailScreenVM>.reactive(
      viewModelBuilder: () => NewsDetailScreenVM(newsModel),
      onModelReady: (viewModel) => viewModel.updateTotalLike(0),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text('News Detail', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(11),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "News title: " + viewModel.newsModel.newsTitle,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                previewImage(viewModel),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "News Description: " + viewModel.newsModel.newsDesctiption,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Card(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.amberAccent,
                      height: 30,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/ic_like.png',
                              width: 50,
                              height: 40,
                            ),
                            Text('${viewModel.totalLikText}')
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      viewModel.addLikeToNews().then((value) => {
                            if (value) {viewModel.updateTotalLike(1)}
                          });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 72,
                  child: TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter your comment",
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        viewModel.addComment(commentController.text);
                      } else {
                        viewModel.toast('Comment is empty yet');
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
                addCommentsSection(viewModel)
              ],
            ),
          ),
        ),
      ),
    );
  }

  previewImage(NewsDetailScreenVM viewModel) {
    if (viewModel.newsModel.imagePath.isNotEmpty) {
      return Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Image.network(viewModel.newsModel.imagePath));
    } else
      return Container(
        height: 1,
      );
  }

  addCommentsSection(NewsDetailScreenVM viewModel) {

    log('addCommentsSection comes inside and list  = ${viewModel.newsModel.commentList.length}');

    if (viewModel.newsModel.commentList.isEmpty) {

      log('addCommentsSection list is empty');
      return Container();
    } else {
      return ListView.builder(

          shrinkWrap: true, physics: NeverScrollableScrollPhysics(),

          itemCount: viewModel.newsModel.commentList.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: Card(
                  margin:
                      EdgeInsets.only(left: 11, right: 11, top: 5, bottom: 5),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Comment : " + viewModel.newsModel.commentList[index],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              textBaseline: TextBaseline.alphabetic),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  final item = viewModel.newsList[index];
                  print(item);
                },
              ));
    }
  }
}
