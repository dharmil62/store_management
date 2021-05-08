import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class BalanceSheet2 extends StatefulWidget {
  @override
  _BalanceSheet2State createState() => _BalanceSheet2State();
}

class _BalanceSheet2State extends State<BalanceSheet2> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            brightness: Brightness.dark,
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("Sales",style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("Deposit",style: TextStyle(color: Colors.white, fontSize: 15),),
                ),
              ],
            ),
            title: Text('Balance Sheet', style: TextStyle(color: Colors.white),),
          ),
          body: TabBarView(
            children: [
              SalesScreen(),
              DepositScreen(),
            ],
          ),
        ),
    );
  }
}

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  var x = globals.cName;
  List bill = [];
  var total, date;

  getData () {
    FirebaseFirestore.instance.collection("customers").doc(globals.cid).collection('bill').get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        return bill = element.data()['bill'] ;
      });
    });
  }
  getTotal () {
    FirebaseFirestore.instance.collection("customers").doc(globals.cid).collection('bill').get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        return total = element.data()['total'] ;
      });
    });
  }
  getDate () {
    FirebaseFirestore.instance.collection("customers").doc(globals.cid).collection('bill').get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        return date = element.data()['date'] ;
      });
    });
  }
  // void ReadNestedData() {
  //   Bill bill;
  //   FirebaseFirestore.instance.collection('customers').doc(globals.cid).collection('bill').doc().get().then((docSnapshot) =>
  //   {
  //     bill = Bill.fromMap(docSnapshot.data),
  //     bill.sets.forEach((set) {
  //       Set setInst = set as Set;
  //       log("Reps :" + setInst.reps.toString());
  //     })
  //   });
  // }


  // getData() async{
  //   List<String> billList;
  //   await FirebaseFirestore.instance.collection('customers').doc(globals.cid).collection('bill').get().then((value){
  //
  //     setState(() {
  //       // first add the data to the Offset object
  //       List.from(value.docs.map((doc){
  //         doc['bill'].forEach((element){
  //         //then add the data to the List<Offset>, now we have a type Offset
  //         billList.add(element);
  //         });
  //       })
  //
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20),),
                        Icon(Icons.person, color: Colors.black,),
                        Padding(padding: EdgeInsets.only(left: 5),),
                        Text("$x"),
                        Padding(padding: EdgeInsets.only(left: 50),),
                        Icon(Icons.monetization_on, color: Colors.black,),
                        Padding(padding: EdgeInsets.only(left: 5),),
                        Text("${globals.sales}"),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('customers').doc(globals.cid).collection('bill').snapshots(),
                          builder: (context, snapshot){
                            getData();
                            getDate();
                            getTotal();
                            // snapshot.data.docs.forEach((doc){
                            //   SalesScreen sales = new SalesScreen(
                            //       bill: List<Bill>.from(doc["bill"].map((item) {
                            //       return new Bill(
                            //         name : item["name"],
                            //         price : item["price"],
                            //         quantity : item]["quantity"],
                            //       );
                            //     })
                            //       )
                            //   );
                            // });
                            if(snapshot.hasData){

                              return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index){
                                        return Container(
                                            margin: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                                )
                                              ],
                                            ),
                                            child: Container(width: double.infinity, height: 150,
                                            child:SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(padding: EdgeInsets.all(5)),
                                                  for (int i =0; i < bill.length; i++)
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Padding(padding: EdgeInsets.all(10)),
                                                        Text("${i+1}.", style: TextStyle(fontFamily: 'jost', fontSize: 15, fontWeight: FontWeight.w600),),
                                                        Padding(padding: EdgeInsets.only(left: 20)),
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: Text("${bill[i]}", style: TextStyle(fontFamily: 'jost', fontSize: 15, fontWeight: FontWeight.w500),),)
                                                      ],
                                                    ),
                                                  Padding(padding: EdgeInsets.all(10)),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(padding: EdgeInsets.only(left: 10),
                                                        child: Text("Total : $total", style: TextStyle(fontFamily: 'jost', fontSize: 20, fontWeight: FontWeight.w700),),),
                                                      Text("Status : Remaining", style: TextStyle(fontFamily: 'jost', fontSize: 16, fontWeight: FontWeight.w600),),
                                                      Padding(padding: EdgeInsets.only(right: 10),
                                                        child: Text("Date : $date", style: TextStyle(fontFamily: 'jost', fontSize: 16, fontWeight: FontWeight.w600),),),
                                                    ],
                                                  ),
                                                  Padding(padding: EdgeInsets.all(10)),
                                                ],
                                              ),
                                            ),
                                            ), // child widget, replace with your own
                                        );
                                      }
                                  ); // child widget, replace with your own
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    // Container(
                    //     margin: EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.black,
                    //           blurRadius: 2.0,
                    //           spreadRadius: 0.0,
                    //           offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    //         )
                    //       ],
                    //     ),
                    //     child: Container(width: double.infinity, height: 150) // child widget, replace with your own
                    // ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
    );
  }
}

class DepositScreen extends StatefulWidget {
  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class Bill {
//   String name;
//   int price, quantity;
//   // List<dynamic> bills = [];
//
//   Bill(this.name, this.price, this.quantity);
//
//   // Map<String, dynamic> toMap() =>
//   //     {
//   //       "name": this.name,
//   //       "price": this.price,
//   //       "quantity": this.quantity,
//   //       "bills": this.bills
//   //     };
//   //
//   // Bill.fromMap(Map<dynamic, dynamic> map)
//   //     : name = map['name'],
//   //       price = map['price'],
//   //       quantity = map['quantity'],
//   //       bills = map['bills'].map((set) {
//   //         return Set.from(set);
//   //       }).toList();
// }
