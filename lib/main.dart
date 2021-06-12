import 'package:flutter/material.dart';
import 'package:uneva/TokenModel.dart';
import 'TokenTile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.greenAccent, fontFamily: 'Poppins'),
      home: HomeScreen(),
    );
  }
}

const korangeCol = Color(0xFFEB3223);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int completed;
  String search = "";
  bool isSwitched = false;
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  Widget sort() {
    return Row(
      children: [
        Text("Token Number"),
        Switch(
          onChanged: toggleSwitch,
          value: isSwitched,
          activeColor: Colors.blue,
          activeTrackColor: Colors.orange,
          inactiveThumbColor: Colors.redAccent,
          inactiveTrackColor: Colors.orange,
        ),
        Text("Alphabetical"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ECHO-All",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF33AE99),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.0),
              borderRadius: new BorderRadius.all(Radius.elliptical(45, 45)),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: korangeCol,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  hintText: "Search Tokens... "),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                sort(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: getItems(),
            builder: (c, s) {
              if (s.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (s.hasData &&
                  s.connectionState == ConnectionState.done) {
                var model = tokensModelFromJson(s.data.data);
                if (isSwitched) {
                  model.sort((a, b) {
                    return a.name
                        .toString()
                        .toLowerCase()
                        .compareTo(b.name.toString().toLowerCase());
                  });
                } else {
                  model.sort((a, b) {
                    return a.tokenNumber
                        .toString()
                        .toLowerCase()
                        .compareTo(b.tokenNumber.toString().toLowerCase());
                  });
                }

                if (search != "") {
                  var data = model.where((row) =>
                      (row.name.toLowerCase().contains(search.toLowerCase())));
                  model = data.toList();
                }
                var len = model.where((row) => (row.status == 1));
                completed = len.length;

                return Expanded(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Waiting : " +
                                (model.length - completed).toString()),
                            Text("Completed : " + completed.toString()),
                            Text("Total : " + model.length.toString()),
                          ],
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: model.length,
                            itemBuilder: (c, i) {
                              return TokenTile(
                                tokenName: model[i].tokenName,
                                name: model[i].name,
                                desc: model[i].description,
                                rate: model[i].createdAt.toString(),
                                pid: model[i].other.pid.toString(),
                                status: model[i].status == 1 ? true : false,
                              );
                            }),
                      ],
                    ),
                  ),
                );
              } else {
                return Text("No data found");
              }
            },
          ),
        ],
      ),
    );
  }
}
