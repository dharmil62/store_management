import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_management/Menu/BalanceSheet2.dart';
import 'package:store_management/Widgets/SideDrawer.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'globals.dart' as globals;
class BalanceSheet extends StatefulWidget {
  @override
  _BalanceSheetState createState() => _BalanceSheetState();
}

class _BalanceSheetState extends State<BalanceSheet> {
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  Widget appBarTitle = new Text("Balance Sheet", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),);
  var x,total;
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
              height: 20.0, child: appBarTitle), //<Widget>[]
          actions: <Widget>[
            new IconButton(icon: actionIcon, onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'jost',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,

                    ),
                    decoration: new InputDecoration(
                        prefixIcon: Padding( padding: const EdgeInsets.fromLTRB(0, 0, 0, 80), child: Icon(Icons.search, color: Colors.white,), ),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white, fontFamily: 'jost', fontWeight: FontWeight.w300, fontSize: 13)
                    ),
                  );
                }
                else{
                  setState(() {
                    if(this.actionIcon.icon == Icons.close){
                      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
                      this.appBarTitle = new Text("Balance Sheet", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),);
                    }
                  });
                }
              });

            },),
          ]
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            SizedBox(
              height: double.maxFinite,
              child: FutureBuilder<QuerySnapshot>(
                // <2> Pass `Future<QuerySnapshot>` to future
                  future: FirebaseFirestore.instance.collection('customers').get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                      final List<DocumentSnapshot> documents = snapshot.data.docs;
                      // documents.map((doc){
                      //   total = doc['sales'] - doc['deposit'];
                      // });
                      return ListView(
                          children: documents
                              .map((doc) => Card(
                            child: ExpansionTileCard(
                              key: Key(doc['customerName']),
                              leading: CircleAvatar(
                                backgroundImage:  NetworkImage(doc['customerURL']),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text(doc['customerName'],style: TextStyle(fontSize: 15, fontFamily: 'jost', fontWeight: FontWeight.w500,color: Colors.black),),
                              subtitle: Text("Total: ${doc['sales'] - doc['deposit']}",style: TextStyle(fontSize: 13, fontFamily: 'jost', fontWeight: FontWeight.w500,color: Colors.black),),
                              children: [
                                Divider(
                                  thickness: 1.0,
                                  height: 1.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(padding: EdgeInsets.all(15),
                                      child:  Text("Sales: ${doc['sales']}",style: TextStyle(fontSize: 13, fontFamily: 'jost', fontWeight: FontWeight.w500,color: Colors.black),),
                                    ),
                                    Padding(padding: EdgeInsets.all(15),
                                      child:  Text("Deposit: ${doc['deposit']}",style: TextStyle(fontSize: 13, fontFamily: 'jost', fontWeight: FontWeight.w500,color: Colors.black),),
                                    ),
                                  ],
                                ),
                                TextButton(onPressed: (){
                                  globals.cName = doc['customerName'];
                                  globals.cid = doc.id;
                                  globals.sales = doc['sales'];
                                  globals.deposit = doc['deposit'];
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>  BalanceSheet2()));
                                },
                                  child: Column(
                                  children: <Widget>[
                                    Icon(Icons.receipt),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Text('Balance Sheet'),
                                  ],
                                ), )
                                // ButtonBar(
                                //   alignment: MainAxisAlignment.spaceAround,
                                //   buttonHeight: 52.0,
                                //   buttonMinWidth: 90.0,
                                //   children: <Widget>[
                                //     TextButton(
                                //       onPressed: () {
                                //         x = Key(doc['customerName']);
                                //         x.currentState?.expand();
                                //       },

                                //     ),
                                //     TextButton(
                                //       onPressed: () {
                                //         x = Key(doc['customerName']);
                                //         x.currentState?.collapse();
                                //       },
                                //       child: Column(
                                //         children: <Widget>[
                                //           Icon(Icons.arrow_upward),
                                //           Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 2.0),
                                //           ),
                                //           Text('Close'),
                                //         ],
                                //       ),
                                //     ),
                                //     TextButton(
                                //       onPressed: () {
                                //         x = doc['customerName'];
                                //         x.currentState?.toggleExpansion();
                                //       },
                                //       child: Column(
                                //         children: <Widget>[
                                //           Icon(Icons.swap_vert),
                                //           Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 2.0),
                                //           ),
                                //           Text('Toggle'),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ))
                              .toList());
                    } else if (snapshot.hasError) {
                      return Text('Its Error!');
                    }
                    return CircularProgressIndicator();
                  }),
            ),

            // Container(
            //   padding: EdgeInsets.only(top: 10,left: 30,right: 10),
            //   child: Text("Welcome ${user.displayName} you are Logged in as ${user.email} and here's your accounting data :",
            //     style: TextStyle(
            //         fontSize: 15.0,
            //         fontWeight: FontWeight.w500,
            //       fontFamily: 'jost',
            //     ),),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(5),
            // ),
            // const Divider(
            //   color: Colors.black54,
            // ),
            // Padding(
            //   padding: EdgeInsets.all(5),
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(padding: EdgeInsets.only(left: 20),
            //       child: Text("Customers", style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w700,
            //         color: Colors.black, fontFamily: 'jost',
            //       ),),
            //     ),
            //     Padding(padding: EdgeInsets.only(right: 20),
            //     child: IconButton(
            //       icon: Icon(Icons.search, color: Colors.black,),
            //       onPressed: (){},
            //     ),
            //     ),
            //   ],
            // ),
            //
            // Padding(
            //   padding: EdgeInsets.all(5),
            // ),
            // const Divider(
            //   color: Colors.black54,
            // ),
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: CircleAvatar(),
            //         title: Text('Dharmil Vekariya'),
            //         subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
            //         trailing: Text('Rs. +700', style: TextStyle(color: Colors.green),),
            //         onTap: () => {},
            //       ),
            //       ListTile(
            //         leading: CircleAvatar(),
            //         title: Text('Alia Bhatt'),
            //         subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
            //         trailing: Text('Rs. +1000', style: TextStyle(color: Colors.green),),
            //         onTap: () => {},
            //       ),
            //       ListTile(
            //         leading: CircleAvatar(),
            //         title: Text('Raju Rastogi'),
            //         subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
            //         trailing: Text('Rs. -2000', style: TextStyle(color: Colors.red),),
            //         onTap: () => {},
            //       ),
            //       ListTile(
            //         leading: CircleAvatar(),
            //         title: Text('Elon Musk'),
            //         subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
            //         trailing: Text('Rs. -10000', style: TextStyle(color: Colors.red),),
            //         onTap: () => {},
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.all(10),
            // ),
            // // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 130, right: 130),
            //         child: InkWell(
            //           onTap: (){
            //             // Fluttertoast.showToast(
            //             //   msg: "Customer Created Successfully",
            //             //   toastLength: Toast.LENGTH_SHORT,
            //             //   gravity: ToastGravity.CENTER,
            //             //   timeInSecForIosWeb: 2,
            //             //   backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            //             //   textColor: Colors.white,
            //             //   fontSize: 15.0,
            //             // );
            //             Navigator.pushReplacement(context, MaterialPageRoute(
            //                 builder: (context) =>  AddCustomer()));
            //           },
            //           child: Container(
            //             height: 50,
            //             decoration: new BoxDecoration(
            //               color: Color.fromRGBO(0, 0, 70, 1),
            //               border: new Border.all(color: Colors.black, width: 2.0),
            //               borderRadius: new BorderRadius.circular(12.0),
            //             ),
            //             child: Center(
            //               child: Text("Add",textAlign: TextAlign.center, style: TextStyle(
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
    );
  }
}
