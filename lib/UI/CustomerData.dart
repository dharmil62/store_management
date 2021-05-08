import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_management/Menu/globals.dart' as globals;
import 'package:store_management/Widgets/SideDrawer.dart';


class CustomerData extends StatefulWidget {
  @override
  _CustomerDataState createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  TextEditingController _nameController,_emailController,_numberController,_addressController, limitAmt;
  String url;

  @override
  void initState(){
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _numberController = TextEditingController();
    _addressController = TextEditingController();
    globals.outstandingAmt = TextEditingController();
    limitAmt = TextEditingController();
    // _quantityController = TextEditingController();
    // _priceController = TextEditingController();
    // _reference = FirebaseDatabase.instance.reference().child('Items');
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _addressController.dispose();
    globals.outstandingAmt.dispose();
    limitAmt.dispose();
    // dispose textEditingControllers to prevent memory leaks
  }

  getData() {
    _nameController.text = globals.cName;
    limitAmt.text = 3000.toString();
    globals.outstandingAmt.text = 1000.toString();
    return FirebaseFirestore.instance.collection('customers').where(
        'customerName',
        isEqualTo: globals.cName
    ).get().then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData = event.docs.single.data();//if it is a single document
        _addressController.text = documentData['address'];
        _numberController.text = documentData['contactNumber'];
        _emailController.text = documentData['emailID'];
        url = documentData['customerURL'];
      }
    }).catchError((e) => print("error fetching data: $e"));

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),

        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 38, 1),
          brightness: Brightness.dark,
          centerTitle: true,
          elevation: 1.0,
          leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Menu',
              color: Colors.white,
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  SideDrawer()));
              }
          ),
          title: SizedBox(
            height: 20.0, child: Text("Customer Data", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),),), //<Widget>[]
        ),

        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FutureBuilder<dynamic>(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        }
                        else if (snapshot.hasError) {
                          return Text('Its Error!');
                        }
                        return Padding(padding: EdgeInsets.all(10));
                      }
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Center(
                    child : InkWell(
                      onTap: () {
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: (url == null) ? AssetImage('assets/manage.png') : NetworkImage(url),
                        ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  makeInput1(label: "Name           "),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  makeInput2(label: "Email ID       "),

                  Padding(
                    padding: EdgeInsets.all(5),
                  ),

                  makeInput3(label: "Contact No."),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  makeInput4(label: "Address       "),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  makeInput5(label: "OutSt Amt   "),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  makeInput6(label: "Limit Amt    "),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                ],
            ),
        ),
    );
  }
  Widget makeInput1({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  enabled: false,
                  obscureText: obscureText,
                  controller: _nameController,
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
  Widget makeInput2({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  enabled: false,
                  obscureText: obscureText,
                  controller: _emailController,
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
  Widget makeInput3({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.phone,
                  obscureText: obscureText,
                  controller: _numberController,
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
  Widget makeInput4({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  obscureText: obscureText,
                  controller: _addressController,
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
  Widget makeInput5({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: obscureText,
                  controller: globals.outstandingAmt,
                  enabled: true,
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
  Widget makeInput6({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: obscureText,
                  controller: limitAmt,
                  enabled: true,
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
