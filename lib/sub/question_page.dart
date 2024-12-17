
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuestionPage extends StatefulWidget {
  final String question;
  const QuestionPage( {super.key, required this.question} );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuestionPage();
  }

}

class _QuestionPage extends State<QuestionPage> {
  String title = '';
  int selectNumber = -1;

  Future<String> loadAsset(String fileName) async {
    return await rootBundle.loadString('res/api/$fileName.json');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: loadAsset(widget.question),
      builder: (context, snapshot) {
        if ( snapshot.hasData == false ) {
          return const CircularProgressIndicator();
        } else if ( snapshot.hasError ) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              )
            ),
          );
        } else {
          Map<String, dynamic> questions = jsonDecode(snapshot.data!);
          List<Widget> widgets;

          widgets = List<Widget>.generate(
              (questions['selects'] as List<dynamic>).length,
              (int index) => SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Text(questions['selects'][index]),
                    Radio(
                        value: index,
                        groupValue: selectNumber,
                        onChanged: (value) {
                          setState(() {
                            selectNumber = index;
                          });
                        }
                    )
                  ],
                ),
              )
          );
          
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Column(
              children: [
                Text(questions['question'].toString()),
                Expanded(
                    child: ListView.builder(
                      itemCount: widgets.length,
                      itemBuilder: (context, index) {
                        final item = widgets[index];
                        return item;
                      }
                    )
                ),
                selectNumber == -1
                  ? Container()
                  : ElevatedButton(
                    onPressed: () {
                      // 결과 페이지로 이동하기
                    },
                    child: const Text('성격 보기')
                )
              ],
            ),
          );

        }
      },
    );
  }

}