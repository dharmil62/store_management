import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:store_management/Widgets/SideDrawer.dart';
import 'package:store_management/Menu/globals.dart' as globals;
import 'Bill.dart';
import 'Customers.dart';
import 'HomePage.dart';
import 'Inventory.dart';
class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  var customer, deposit = 0;
  TextEditingController depositController = TextEditingController();
  int x;


  @override
  void initState(){

    // _quantityController = TextEditingController();
    // _priceController = TextEditingController();
    // _reference = FirebaseDatabase.instance.reference().child('Items');
    super.initState();
    depositController = TextEditingController();

  }

  @override
  void dispose() {
    depositController.dispose();
    super.dispose();
    // dispose textEditingControllers to prevent memory leaks
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
          height: 20.0, child: Text("Add Deposit", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),),), //<Widget>[]
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Container(
            //   padding: EdgeInsets.only(top: 10,left: 30,right: 10),
            //   child: Text("Welcome ${user.displayName} you are Logged in as ${user.email} and here's your accounting data :",
            //     style: TextStyle(
            //         fontSize: 15.0,
            //         fontWeight: FontWeight.w500,
            //       fontFamily: 'jost',
            //     ),),
            // ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Padding(padding: EdgeInsets.only(left: 20),
              child: Text("Add Deposits made by Customers", style: TextStyle(
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
              padding: EdgeInsets.all(10),
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     makeInput2(label: "Select Customer :   "),
            //     Padding(
            //       padding: EdgeInsets.all(5),
            //     ),
            //     Icon(Icons.arrow_drop_down, color: Colors.black,)
            //   ],
            // ),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('customers').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData)
                    const Text("Loading......");
                  else{
                    List<DropdownMenuItem> customers = [];
                    for(int i = 0; i < snapshot.data.docs.length; i++){
                      DocumentSnapshot snap = snapshot.data.docs[i];
                      customers.add(
                        DropdownMenuItem(
                          child: Text(
                            snap.data()['customerName'],
                            style: TextStyle(fontFamily: 'jost', color: Colors.black),
                          ),
                          value: "${snap.data()['customerName']}",
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 40,),
                          child: Icon(Icons.person,
                            size: 25.0, color: Colors.black,),
                        ),

                        Expanded(
                          child: Padding(padding: EdgeInsets.only(left: 40, right: 40),
                            child: SearchableDropdown.single(
                              items: customers,
                              onChanged: (value) {
                                setState(() {
                                  customer = value;
                                });
                              },
                              value: customer,
                              isExpanded: true,
                              searchHint: "Select Customer",
                              hint: "Choose Customer",
                            ),
                          ),
                        ),

                      ],
                    );
                  }
                  return CircularProgressIndicator();
                }

            ),

            Padding(
              padding: EdgeInsets.all(10),
            ),
            makeInput2(label: "Add Amount     "),

            // Padding(
            //   padding: EdgeInsets.all(40),
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 130, right: 130),
            //         child: InkWell(
            //           onTap: (){
            //             Fluttertoast.showToast(
            //               msg: "Deposit Added Successfully",
            //               toastLength: Toast.LENGTH_SHORT,
            //               gravity: ToastGravity.CENTER,
            //               timeInSecForIosWeb: 2,
            //               backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            //               textColor: Colors.white,
            //               fontSize: 15.0,
            //             );
            //             Navigator.pushReplacement(context, MaterialPageRoute(
            //                 builder: (context) =>  Deposit()));
            //           },
            //           child: Container(
            //             height: 50,
            //             decoration: new BoxDecoration(
            //               color: Colors.redAccent,
            //               border: new Border.all(color: Colors.black, width: 2.0),
            //               borderRadius: new BorderRadius.circular(12.0),
            //             ),
            //             child: Center(
            //               child: Text("Add Deposit",textAlign: TextAlign.center, style: TextStyle(
            //                 fontWeight: FontWeight.w400,
            //                 fontSize: 15, fontFamily: 'jost', color: Colors.white,
            //               ),),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),



            // RaisedButton(
            //
            //   padding: EdgeInsets.fromLTRB(60,10,60,10),
            //   onPressed: signOut,
            //   child: Text('Logout',style: TextStyle(
            //
            //       color: Colors.white,
            //       fontSize: 20.0,
            //       fontWeight: FontWeight.bold
            //
            //   )),
            //
            //   color: Color.fromRGBO(0, 0, 70, 1),
            //   shape: RoundedRectangleBorder(
            //
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            // )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        focusColor: Colors.grey,
        foregroundColor: Colors.black,
        label: Text("Add Deposit", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'jost', color: Colors.white),),
        icon: Icon(Icons.add, color: Colors.white,),
        onPressed:() {
          var id;
          FirebaseFirestore.instance.collection('customers').where(
              'customerName',
              isEqualTo: customer
          ).get().then((event) {
            if (event.docs.isNotEmpty) {
              Map<String, dynamic> documentData = event.docs.single.data();//if it is a single document
              deposit = documentData['deposit'] + int.parse(depositController.text);
            }
          }).catchError((e) => print("error fetching data: $e"));
          FirebaseFirestore.instance
              .collection('customers')
              .where("customerName", isEqualTo: customer)
              .get()
              .then(
                (QuerySnapshot snapshot) => {
              snapshot.docs.forEach((f) {
                id = f.reference.id;
                FirebaseFirestore.instance.collection('customers').doc(id).update({
                  "deposit": deposit,
                });
              }),
            },
          );

          Fluttertoast.showToast(
            msg: "Deposit Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            textColor: Colors.white,
            fontSize: 15.0,
          );
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>  Deposit()));
        },
      ),

      bottomNavigationBar: new Container(
        height: 50.0,
        alignment: Alignment.center,
        child: new BottomAppBar(
          color: Color.fromRGBO(0, 0, 38, 1),
          child: new Row(
            // alignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(
                color:Colors.white,
                icon: Icon(
                  Icons.home,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

                },
              ),
              new IconButton(
                color:Colors.white,
                icon: Icon(
                  Icons.inventory,
                  // color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Inventory()));
                },
              ),
              new IconButton(
                color:Colors.white,
                icon: Icon(
                  Icons.group,

                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Customers()));

                },
              ),
              new IconButton(
                color:Colors.white,
                icon: Icon(
                  Icons.receipt,

                  // color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Bill()));

                },
              ),
              new IconButton(
                color:Colors.white,
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.redAccent,
                  // color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Deposit()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Family()));

                },
              ),
            ],
          ),
        ),
      ),

    );
  }
  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(label, style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black, fontFamily: 'jost',
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.mic, color: Colors.black,),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(left: 20, top: 5),
          child:Container(
            height: 100,
            width: 320,
            child: TextField(
              obscureText: obscureText,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
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
          padding: EdgeInsets.only(left: 40),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 70,
                child: TextField(
                  keyboardType: TextInputType.number,
                  obscureText: obscureText,
                  controller: depositController,
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
