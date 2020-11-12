import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  runApp(MaterialApp(home: MyAWS(),));
}

class MyAWS extends StatefulWidget {
  @override
  _MyAWSState createState() => _MyAWSState();
}

class _MyAWSState extends State<MyAWS> {

  List viewData;

  @override
  void initState() {

    Future(() async{
      const String _url = "https://kbeqiu31zk.execute-api.ap-northeast-2.amazonaws.com/default/myFlutter"; // AWS API Gateway
      final http.Response _res = await http.get(_url);
      final Map<String, dynamic> _data = json.decode(_res.body);
      final List _result = _data['records'];
      setState(() {
        this.viewData = _result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("[AWS] Lambda + API Gateway"),
      ),
      body: this.viewData == null
        ? Center(child: Text("Load..."),)
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: this.viewData.length,
            padding: EdgeInsets.all(10.0),
            itemBuilder: (BuildContext context, int index)
              => GridTile(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        this.viewData[index]['fields']['ProfileImg'][0]['thumbnails']['large']['url'].toString(),
                      )
                    )
                  ),
                ),
                footer: Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.only(left:1.0, right: 1.0,bottom: 1.0),
                  alignment: Alignment.center,
                  child: Text(this.viewData[index]['fields']['Name'].toString())
                ),
              )
          )
    );
  }
}
