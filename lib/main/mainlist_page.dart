import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../sub/question_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }

}

class _MainPage extends State<MainPage> {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('res/api/list.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadAsset(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              Map<String, dynamic> list = jsonDecode(snapshot.data!);
              return ListView.builder(itemBuilder: (context, value) {
                return InkWell(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      child: Text(list['questions'][value]['title'].toString()),
                    ),
                  ),
                  onTap: () async{
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                        return QuestionPage(question: list['questions'][value]['file'].toString());
                      }
                    ));
                  },
                );
              },
              itemCount: list['count'],
              );
            case ConnectionState.none:
              return const Center(
                child: Text('No Data'),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      )
    );

  }


}