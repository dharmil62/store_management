import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_management/UI/Customers.dart';
class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
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
            child: Text("Store/Shop Information", style: TextStyle(
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
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage:
              AssetImage("assets/manage.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeInput2(label: "Name"),
              makeInput2(label: "Email ID"),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeInput2(label: "Contact No."),
              makeInput2(label: "Address"),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 130, right: 130),
                  child: InkWell(
                    onTap: (){
                      // Fluttertoast.showToast(
                      //   msg: "Customer Created Successfully",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.CENTER,
                      //   timeInSecForIosWeb: 2,
                      //   backgroundColor: Color.fromRGBO(0, 0, 38, 1),
                      //   textColor: Colors.white,
                      //   fontSize: 15.0,
                      // );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>  Store2()));
                    },
                    child: Container(
                      height: 50,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 70, 1),
                        border: new Border.all(color: Colors.black, width: 2.0),
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text("Edit",textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15, fontFamily: 'jost', color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          const Divider(
            color: Colors.black54,
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
class Store2 extends StatefulWidget {
  @override
  _Store2State createState() => _Store2State();
}

class _Store2State extends State<Store2> {
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
            child: Text("Edit Store/Shop Information", style: TextStyle(
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
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage:
              AssetImage("assets/manage.png"),
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeInput2(label: "Name"),
              makeInput2(label: "Email ID"),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              makeInput2(label: "Contact No."),
              makeInput2(label: "Address"),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 130, right: 130),
                  child: InkWell(
                    onTap: (){
                      Fluttertoast.showToast(
                        msg: "Information Edited Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Color.fromRGBO(0, 0, 38, 1),
                        textColor: Colors.white,
                        fontSize: 15.0,
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>  Store()));
                    },
                    child: Container(
                      height: 50,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 70, 1),
                        border: new Border.all(color: Colors.black, width: 2.0),
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text("Change",textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15, fontFamily: 'jost', color: Colors.white,
                        ),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          const Divider(
            color: Colors.black54,
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
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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

