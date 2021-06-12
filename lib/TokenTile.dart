import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uneva/TokenDetailsScreen.dart';

class TokenTile extends StatelessWidget {
  const TokenTile({
    Key key,
    @required this.tokenName,
    @required this.name,
    @required this.desc,
    @required this.rate,
    @required this.pid,
    @required this.status,
  }) : super(key: key);

  final String tokenName;
  final String name;
  final String desc;
  final String rate;
  final String pid;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //ToDO: Add PID to next screen
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TokenDetailScreen(pid, name),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                tokenName,
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    Text(
                      desc,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 100.0),
                          child: Text(rate),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 35,
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
