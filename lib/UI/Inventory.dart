import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_management/UI/Customers.dart';
import 'package:store_management/Widgets/SideDrawer.dart';
import 'AddItem.dart';
import 'Bill.dart';
import 'Deposit.dart';
import 'HomePage.dart';
import 'Start.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {

  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  Icon actionIcon2 =  Icon(Icons.flag, color: Colors.red, size: 20,);
  Icon actionIcon3 = Icon(Icons.flag, color: Colors.blue, size: 20,);

  Widget appBarTitle = new Text("Inventory", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),);
  var url;
  PageController _controller = PageController(
    initialPage: 0,
  );

//   fetchImage() async{
//     final ref = FirebaseStorage.instance.ref().child('itemname');
// // no need of the file extension, the name will do fine.
//     url = await ref.getDownloadURL();
//     print(url);
//   }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              height: 20.0, child: appBarTitle),
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
                      this.appBarTitle = new Text("Inventory", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),);
                    }
                  });
                }
              });

            },),
          ]
        //<Widget>[]
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
            //       child: Text("Inventory", style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w700,
            //         color: Colors.black, fontFamily: 'jost',
            //       ),),
            //     ),
            //     Padding(padding: EdgeInsets.only(right: 20),
            //       child: IconButton(
            //         icon: Icon(Icons.search, color: Colors.black,),
            //         onPressed: (){},
            //       ),
            //     )
            //   ],
            // ),
            // Padding(
            //   padding: EdgeInsets.all(5),
            // ),
            // const Divider(
            //   color: Colors.black54,
            // ),
            SizedBox(
                  height: double.maxFinite,
                  child: FutureBuilder<QuerySnapshot>(
                // <2> Pass `Future<QuerySnapshot>` to future
                  future: FirebaseFirestore.instance.collection('items').get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                          final List<DocumentSnapshot> documents = snapshot.data.docs;
                          return ListView(
                              children: documents
                                  .map((doc) => Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:  NetworkImage(doc['url']),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title: Text(doc['itemname'],style: TextStyle(fontSize: 15, fontFamily: 'jost', fontWeight: FontWeight.w500,color: Colors.black),),
                                  subtitle: Text(doc['quantity'],style: TextStyle(fontSize: 12, fontFamily: 'jost', fontWeight: FontWeight.w300,color: Colors.black),),
                                  trailing: Wrap(
                                            children: [
                                              IconButton(icon : Icon(Icons.edit, color: Colors.blue,size: 20,),
                                                onPressed: (){},
                                              ),
                                              // IconButton(icon : Icon(Icons.flag, color: Colors.red,size: 20,),
                                              //   onPressed: (){},
                                              // ),
                                            ],
                                          ),
                                ),
                              ))
                                  .toList());
                        } else if (snapshot.hasError) {
                          return Text('Its Error!');
                          }
                        return CircularProgressIndicator();
                          }),
                ),


              // child: Column(
              //   children: [
              //     ListTile(
              //       leading: CircleAvatar(),
              //       title: Text("Item 1", style: TextStyle(color: Colors.black, fontFamily: 'jost', fontWeight: FontWeight.w500, fontSize: 14),),
              //       subtitle: Text("Stock", style: TextStyle(color: Colors.black, fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 12),),
              //       trailing: Wrap(
              //         children: [
              //           IconButton(icon : Icon(Icons.edit, color: Colors.blue,),
              //             onPressed: (){},
              //           ),
              //           IconButton(icon : Icon(Icons.flag, color: Colors.red,),
              //             onPressed: (){},
              //           ),
              //         ],
              //       ),
              //       onTap: () => {},
              //     ),
              //     ListTile(
              //       leading: CircleAvatar(),
              //       title: Text('Item 2'),
              //       subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
              //       trailing: Text('Stock: 3 KG', style: TextStyle(color: Colors.black),),
              //       onTap: () => {},
              //     ),
              //     ListTile(
              //       leading: CircleAvatar(),
              //       title: Text('Item 3'),
              //       subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
              //       trailing: Text('Stock: 10 litres', style: TextStyle(color: Colors.black),),
              //       onTap: () => {},
              //     ),
              //     ListTile(
              //       leading: CircleAvatar(),
              //       title: Text('Item 4'),
              //       subtitle: Text("Edit", style: TextStyle(color: Colors.blue),),
              //       trailing: Text('Stock: 50 units', style: TextStyle(color: Colors.black),),
              //       onTap: () => {},
              //     ),
              //   ],
              // ),
            // Padding(
            //   padding: EdgeInsets.all(10),
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 130, right: 130),
            //         child: InkWell(
            //           onTap: (){
            //             // Fluttertoast.showToast(
            //             //   msg: "Item Added Successfully",
            //             //   toastLength: Toast.LENGTH_SHORT,
            //             //   gravity: ToastGravity.CENTER,
            //             //   timeInSecForIosWeb: 2,
            //             //   backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            //             //   textColor: Colors.white,
            //             //   fontSize: 15.0,
            //             // );
            //             Navigator.pushReplacement(context, MaterialPageRoute(
            //                 builder: (context) =>  AddItem()));
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
            //












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

     floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.redAccent,
           focusColor: Colors.grey,
           foregroundColor: Colors.black,
           onPressed:() {Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context) =>  AddItem()));},
         child: Icon(Icons.add, color: Colors.white,),

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
                  color: Colors.redAccent,
                  // color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Inventory()));
                },
              ),
              new IconButton(
                color:Colors.white,
                icon: Icon(
                  Icons.group,
                  // color: Colors.black54,
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
                  // color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Deposit()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Family()));

                },
              ),
            ],
          ),
        ),
      ),

    );
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;



  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "Start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }



  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
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
          padding: EdgeInsets.only(left: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 25,
                width: 70,
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

