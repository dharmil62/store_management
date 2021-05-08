import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_management/UI/Customers.dart';
import 'package:store_management/UI/Inventory.dart';
import 'package:store_management/Widgets/SideDrawer.dart';
import 'Bill.dart';
import 'Deposit.dart';
import 'Start.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(
    initialPage: 0,
  );


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        HomeScreen(),
        Inventory(),
        Customers(),
        Bill(),
        Deposit(),
        // Profile(),
      ],
    );
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
          height: 20.0, child: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),),), //<Widget>[]
      ),

      body: Container(
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
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            makeInput2(label: "Money To Collect :            "),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            makeInput2(label: "Low Stock Items Count : "),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("Yesterday's Accounting Information", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black, fontFamily: 'jost',
            ),),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.money),
                    title: Text('Dharmil Vekariya'),
                    subtitle: Text("Unpaid", style: TextStyle(color: Colors.red),),
                    trailing: Text('Rs. 1000', style: TextStyle(color: Colors.red),),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.money),
                    title: Text('Alia Bhatt'),
                    subtitle: Text("Paid", style: TextStyle(color: Colors.green),),
                    trailing: Text('Rs. 2000', style: TextStyle(color: Colors.green),),
                    onTap: () => {},
                  ),
                ],
              ),
            ),



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
                    color: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

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
          padding: EdgeInsets.only(left: 20),
          child: Text(label, style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black, fontFamily: 'jost',
          ),),
        ),


        Padding(
          padding: EdgeInsets.only(left: 20,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
                width: 80,
                child: TextField(
                  enabled: false,
                  obscureText: obscureText,
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

