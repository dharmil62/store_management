import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_management/UI/Customers.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 38, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){Navigator.pop(context);},
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.black54,
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("Settings", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black, fontFamily: 'jost',
            ),),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: new Icon(Icons.inventory),
            title: new Text('Manage Stock Count', style: TextStyle(fontSize: 16, fontFamily: 'jost', fontWeight: FontWeight.w500, color: Colors.black),),
            trailing: CustomSwitch(
              value: globals.stockLimit,
              onChanged: (value) {
                print("VALUE1 : $value");
                setState(() {
                  globals.stockLimit = value;
                });
              },
              activeColor: Colors.redAccent,
            ),
            onTap: () {
            },
          ),
          ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('Manage Credit Limit', style: TextStyle(fontSize: 16, fontFamily: 'jost', fontWeight: FontWeight.w500, color: Colors.black),),
            trailing: CustomSwitch(
              value: globals.creditLimit,
              onChanged: (value) {
                print("VALUE2 : $value");
                setState(() {
                  globals.creditLimit = value;
                });
              },
              activeColor: Colors.redAccent,
            ),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
  Widget makeInput2({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 25,
                width: 150,
                child: TextField(
                  obscureText: obscureText,
                  enabled: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


