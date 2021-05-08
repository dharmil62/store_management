

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_management/UI/Deposit.dart';
import 'package:store_management/Widgets/SideDrawer.dart';
import 'package:store_management/Menu/globals.dart' as globals;
import 'Customers.dart';
import 'HomePage.dart';
import 'Inventory.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart' as open_file;
import 'dart:async';

import 'ItemBill.dart';


class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  var customer, item = "Items Selected", sales = 0;
  List yourItemList= [];
  // List<int> selectedItems = [];

  int l;
  double total = 0;
  List<TextEditingController> controllers = [];
  DocumentSnapshot document;
  String address, phone;
  DateFormat format;


  displayItem(){
  return item;
}




  // TextEditingController _quantityController, _priceController;


  @override
  void initState(){

    // _quantityController = TextEditingController();
    // _priceController = TextEditingController();
    // _reference = FirebaseDatabase.instance.reference().child('Items');
    super.initState();
    controllers = List.generate(globals.selectedItems.length*2, (i) => TextEditingController());

  }

  @override
  void dispose() {
    controllers.forEach((c) => c.dispose());
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
          height: 20.0, child: Text("Bill Generation", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, fontFamily: 'jost', color: Colors.white),),), //<Widget>[]
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
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Padding(padding: EdgeInsets.only(left: 20),
              child: Text("Generate Bills for Customers", style: TextStyle(
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
            // Padding(
            //   padding: EdgeInsets.all(5),
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     makeInput2(label: "Select Items         :   "),
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


            // Padding(
            //   padding: EdgeInsets.all(10),
            // ),
            //
            // StreamBuilder<QuerySnapshot>(
            //     stream: FirebaseFirestore.instance.collection('items').snapshots(),
            //     builder: (context, snapshot) {
            //       if(!snapshot.hasData)
            //         const Text("Loading......");
            //       else{
            //         List<DropdownMenuItem> items = [];
            //         tableItems = items;
            //         for(int i = 0; i < snapshot.data.docs.length; i++){
            //           DocumentSnapshot snap = snapshot.data.docs[i];
            //           items.add(
            //             DropdownMenuItem(
            //               child: Text(
            //                 snap.data()['itemname'],
            //                 style: TextStyle(fontFamily: 'jost', color: Colors.black),
            //               ),
            //               value: "${snap.data()['itemname']}",
            //             ),
            //           );
            //         }
            //         return Row(
            //
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Padding(padding: EdgeInsets.only(left: 40),
            //             child:  Icon(Icons.inventory,
            //               size: 25.0, color: Colors.black,),
            //             ),
            //
            //             Expanded(
            //               child: Padding(padding: EdgeInsets.only(left: 40, right: 40),
            //               child: SearchableDropdown.multiple(
            //                 items: items,
            //                 selectedItems: selectedItems,
            //                 onChanged: (value) {
            //                   setState(() {
            //                     selectedItems = value;
            //                   });
            //                 },
            //
            //                 hint: "Choose Items",
            //                 searchHint: "Select Items",
            //                 isExpanded: true,
            //                 closeButton: (selectedItems) {
            //                   return (selectedItems.isNotEmpty
            //                       ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
            //                       : "Save without selection");
            //                 },
            //
            //               ),
            //             ),
            //             ),
            //
            //           ],
            //         );
            //       }
            //       return CircularProgressIndicator();
            //     }
            //
            // ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                borderRadius: new BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  createTable(),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>  ItemBill()));
                    },
                    child: Container(
                      color: Colors.white60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Icon(Icons.add_circle, color: Colors.redAccent,),
                          SizedBox(
                            width: 30,
                          ),
                          Text("Add/Edit Items", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'jost', color: Colors.black),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            //             generateInvoice();
            //
            //             Fluttertoast.showToast(
            //               msg: "Bill Generated Successfully",
            //               toastLength: Toast.LENGTH_SHORT,
            //               gravity: ToastGravity.CENTER,
            //               timeInSecForIosWeb: 2,
            //               backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            //               textColor: Colors.white,
            //               fontSize: 15.0,
            //             );
            //           },
            //           child: Container(
            //             height: 40,
            //             decoration: new BoxDecoration(
            //               color: Colors.redAccent,
            //               border: new Border.all(color: Colors.black, width: 2.0),
            //               borderRadius: new BorderRadius.circular(12.0),
            //             ),
            //             child: Center(
            //               child: Text("Create",textAlign: TextAlign.center, style: TextStyle(
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
            Padding(
              padding: EdgeInsets.all(35),
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

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        focusColor: Colors.grey,
        foregroundColor: Colors.black,
        label: Text("Generate Bill", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'jost', color: Colors.white),),
        icon: Icon(Icons.add, color: Colors.white,),
        onPressed:() {
          generateInvoice();
          addData();
          Fluttertoast.showToast(
            msg: "Bill Generated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromRGBO(0, 0, 38, 1),
            textColor: Colors.white,
            fontSize: 15.0,
          );
          globals.selectedItems.clear();
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>  Bill()));
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
                  color: Colors.redAccent,
                  // color: Colors.black54,
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Bill()));

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

  Widget makeInput2(int value) {
    return Center(
          child: Container(
                height: 30,
                width: 50,
                child: TextFormField(
                  controller: controllers[value],
                  // onChanged: (value){
                  //   final controller = controllers[i];
                  // },
                  style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 14),
                  // controller: textEditingControllers[index],
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 5),
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
        );
  }

  Widget makeInput3() {
        return Center(
          child: Container(
            height: 30,
            width: 50,
            child: TextFormField(
              style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 14),
              // controller: _priceController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 5),
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
        );
  }

  Widget createTable() {

    controllers.length = globals.selectedItems.length*2;
    controllers = [
      for(int j=0; j<globals.selectedItems.length*2; ++j )
        TextEditingController()
    ];
    // selectedItems.forEach((element) {
    //   var controller = TextEditingController();
    //   controllers.add(controller);
    // });
    // int q = _quantityController as int, p = _priceController as int;
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Padding(padding: EdgeInsets.only(bottom: 30),
      child: Center(
        child: Text(" No. ",style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w600, fontSize: 16),),
      ),),

      Center(
        child: Text(" Items ",style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w600, fontSize: 16),),
      ),
      Center(
        child: Text(" Quantity ",style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w600, fontSize: 16),),
      ),
      Center(
        child: Text(" Price ",style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w600, fontSize: 16),),
      ),
    ]));
    for (int i = 0, j=0; i < globals.selectedItems.length; ++i, j = j+2) {
      rows.add(
          TableRow(children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text((i+1).toString(),style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 14),),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20),
            child: Center(child:  Text(globals.tableItems[globals.selectedItems[i]].value.toString(),style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 14),),),),
            Padding(padding: EdgeInsets.all(10),
            child: Center(
              child: Center(
                child: Container(
                  height: 30,
                  width: 50,
                  child: TextFormField(
                    controller: controllers[j],
                    // onChanged: (value){
                    //   setState(() {
                    //     controllers[j].text = value;
                    //   });
                    // },
                    style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 14),
                    // controller: textEditingControllers[index],
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 5),
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
              ),
            ),),
            Padding(padding: EdgeInsets.all(10),
            child: Center(child: Center(
              child: Container(
                height: 30,
                width: 50,
                child: TextFormField(
                  controller: controllers[j+1],
                  // onChanged: (value){
                  //   final controller = controllers[j+1];
                  //   setState(() {
                  //     controllers[j+1] = controller;
                  //   });
                  // },
                  style: TextStyle(fontFamily: 'jost', fontWeight: FontWeight.w400, fontSize: 14),
                  // controller: textEditingControllers[index],
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 5),
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
            )),),
          ]));
    }
    return Table(children: rows);
  }

  Future<void> generateInvoice() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult result = drawHeader(page, pageSize, grid);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Get the storage folder location using path_provider package.
    final Directory directory =
    await path_provider.getApplicationDocumentsDirectory();
    final String path = directory.path;
    final File file = File('$path/output.pdf');
    await file.writeAsBytes(bytes);
    //Launch the file (used open_file package)
    await open_file.OpenFile.open('$path/output.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader (PdfPage page, Size pageSize, PdfGrid grid) {


    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString('Rs.' + getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: 2058557939\r\n\r\nDate: ' +
        format.format(DateTime.now());
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address = '''Bill To: \r\n\r\n$customer, 
        \r\n\r\naddress \r\n\r\n8160006043''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));

    //Draw grand total.
    page.graphics.drawString('Grand Total',
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            quantityCellBounds.left,
            result.bounds.bottom + 10,
            quantityCellBounds.width,
            quantityCellBounds.height));
    page.graphics.drawString(getTotalAmount(grid).toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(
            totalPriceCellBounds.left,
            result.bounds.bottom + 10,
            totalPriceCellBounds.width,
            totalPriceCellBounds.height));
  }

  //Draw the invoice footer data.
  void drawFooter (PdfPage page, Size pageSize) async{
    String addressData;

    await FirebaseFirestore.instance.collection('customers').where(
        'customerName',
        isEqualTo: customer
    ).get().then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData = event.docs.single.data();//if it is a single document
        addressData = documentData['address'];
      }
    }).catchError((e) => print("error fetching data: $e"));


    // CollectionReference collectionReference = FirebaseFirestore.instance.collection('customers');
    // Future<QuerySnapshot> docs = collectionReference.where('customerName', isEqualTo: customer).get();

    // DocumentSnapshot document = await FirebaseFirestore.instance.collection('customers').doc(customer).get();
    // String address = document.data()['address'];
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    String footerContent =
    "$addressData\r\n\r\nAny Questions? support@geetaxmi-technologies.com";

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    int x,y,z;
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'No.';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Product Name';
    headerRow.cells[2].value = 'Price';
    headerRow.cells[3].value = 'Quantity';
    headerRow.cells[4].value = 'Total';
    //Add rows
    for(int i=0,j=0; i<globals.selectedItems.length; i++,j=j+2){
      x = int.parse(controllers[j].text);
      y = int.parse(controllers[j+1].text);
      z = x*y;
      addProducts(i+1, globals.tableItems[globals.selectedItems[i]].value.toString(), x, y, z, grid );
    }
    // addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void addProducts(int No, String productName, int price,
      int quantity, int total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = No;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    for (int i = 0; i < grid.rows.count; i++) {
      final String value = grid.rows[i].cells[grid.columns.count - 1].value;
      total += double.parse(value);
    }

    return total;
  }


  addData() async{
  var path,id;
  yourItemList.length = globals.selectedItems.length;
  for(int i=0,j=0; i < globals.selectedItems.length; i++,j=j+2 ){
    yourItemList.add({
      "name": globals.tableItems[globals.selectedItems.toList()[i]].value.toString(),
      "quantity": controllers.toList()[j].text,
      "price": controllers.toList()[j+1].text,
    });
    total = total + int.parse(controllers[j].text)*int.parse(controllers[j+1].text);
  }

  total = total/3;

  FirebaseFirestore.instance.collection('customers').where(
      'customerName',
      isEqualTo: customer
  ).get().then((event) {
    if (event.docs.isNotEmpty) {
      Map<String, dynamic> documentData = event.docs.single.data();//if it is a single document
      sales = documentData['sales'] + total;
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
          "sales": sales,
        });
      }),
    },
  );

  FirebaseFirestore.instance
      .collection('customers')
      .where("customerName", isEqualTo: customer)
      .get()
      .then(
        (QuerySnapshot snapshot) => {
      snapshot.docs.forEach((f) {
        path = f.reference.id;
        FirebaseFirestore.instance.collection('customers').doc(path).collection('bill').add({
          "bill" : FieldValue.arrayUnion(yourItemList),
          "total": total.toString(),
          "date": format.format(DateTime.now()).toString(),
        });
      }),
    },
  );

  // return  await FirebaseFirestore.instance.collection('customers').doc().collection('bill').doc().set({
  //   "bill" : FieldValue.arrayUnion(yourItemList),
  // }).then((onValue) {
  //   print('Created it in sub collection');
  // }).catchError((e) {
  //   print('======Error======== ' + e);
  // });
  }
  
  // getData() async{
  //   document = await FirebaseFirestore.instance.collection('customers').doc(customer).get();
  //   address = document.data()['address'];
  //   phone = document.data()['contactNumber'];
  // }
  
}
