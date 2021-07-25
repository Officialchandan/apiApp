import 'dart:convert';
import 'package:apiapp/catalog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final url =
  //     "https://www.crazywebdesigners.com/limadi/webservices/customer/slider";
  List<QueryModel> myNote = <QueryModel>[];
  bool isloading = true;
  getByJson() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a8b23d42586f434c88e963fc2b93610e";

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        data["articles"].forEach((element) {
          QueryModel queryModel = new QueryModel();
          queryModel = QueryModel.fromMap(element);
          myNote.add(queryModel);
          setState(() {
            isloading = false;
          });
        });
      });
    } else {
      return print(myNote);
    }
  }

  @override
  void initState() {
    getByJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Json"),
        ),
        body: ListView.builder(
            itemCount: myNote.length,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        myNote[index].queryHead,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        myNote[index].queryImg,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      Text(
                        myNote[index].queryUrl,
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                      Text(
                        myNote[index].queryDes,
                        style: TextStyle(color: Colors.black, fontSize: 10),),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
