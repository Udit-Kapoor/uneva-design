import 'package:flutter/material.dart';
import 'package:uneva/DetailsModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

const detail = TextStyle(color: Colors.grey, fontSize: 20);

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen(this.pid, this.name);
  final String pid;
  final String name;

  @override
  _TokenDetailScreenState createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen> {
  @override
  bool edit = false;

  Widget showDynamicBody() {
    if (edit) {
      return ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://www.computerhope.com/jargon/g/guest-user.jpg"),
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                    bottom: 0,
                    right: -25,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Color(0xFF33AE99),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 25,
                      ),
                      shape: CircleBorder(),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "PID :",
                    hintText: "New PID"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "Name :",
                    hintText: "New Name"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "Gender :",
                    hintText: "New Gender"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "Age :",
                    hintText: "New Age"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "Phone :",
                    hintText: "New Phone"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "Relation :",
                    hintText: "New Relation"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                    labelText: "Address :",
                    hintText: "New Address"),
                style: detail,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 39.0),
                  height: 64,
                  width: 325,
                  decoration: new BoxDecoration(
                    color: Color(0xFF33AE99),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    shape: BoxShape.rectangle,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Dummy Form. Can Post TO API");
                      setState(() {
                        edit = false;
                      });
                    },
                    color: Color(0xFF33AE99),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return FutureBuilder(
        future: getDetails(widget.pid),
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (s.hasData && s.connectionState == ConnectionState.done) {
            var model = detailsModelFromJson(s.data.data);
            print(model.personPic);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: model.personPic != null
                            ? NetworkImage(model.personPic)
                            : NetworkImage(
                                "https://www.computerhope.com/jargon/g/guest-user.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Color(0xFF33AE99),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 25,
                            ),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PID :" + model.personPid,
                        textAlign: TextAlign.left,
                        style: detail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Name :" + model.personFullName,
                        style: detail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Gender :" + model.personGender,
                        style: detail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Age :" + model.personAge,
                        style: detail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Phone :" + model.personPhone,
                        style: detail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Relation :" + model.personRelation,
                        style: detail,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Address :" + model.personAddress,
                        style: detail,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Text("No data found");
          }
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.name,
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF33AE99),
        actions: [
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  edit = !edit;
                });
              })
        ],
      ),
      body: showDynamicBody(),
    );
  }
}
