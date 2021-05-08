
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:store_management/Menu/globals.dart' as globals;

import 'Inventory.dart';
class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  TextEditingController _nameController,_quantityController,_priceController;
  bool measure = false;
  var textValue = 'Measure is OFF';
  String imagePath, fileName;
  File file, imageFile, _image;
  String url;
  DocumentReference itemsRef = FirebaseFirestore.instance.collection('items').doc();

  List<File> _images;
  // DatabaseReference _reference;

  // Future chooseFile() async {
  //   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
  //     setState(() {
  //       _image = image;
  //     });
  //   });
  // }
  // Future uploadFile() async {
  //   Reference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('items/${Path.basename(_image?.path)}}');
  //   UploadTask uploadTask = storageReference.putFile(_image);
  //   await uploadTask;
  //   print('File Uploaded');
  //   storageReference.getDownloadURL().then((fileURL) {
  //     setState(() {
  //       _uploadedFileURL = fileURL;
  //     });
  //   });
  // }
  //
  void clearSelection() {
    setState(() {
      _image = null;
      url = null;
    });
  }
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  @override
  void initState(){
    _nameController = TextEditingController();
    // _measureController = TextEditingController();
    _quantityController = TextEditingController();
    _priceController = TextEditingController();
    // _reference = FirebaseDatabase.instance.reference().child('Items');
    super.initState();

  }
   uploadImage() async{
    fileName = _nameController.text;
    Reference reference =  FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_image);
    await uploadTask;
    await reference.getDownloadURL().then((fileURL){
      url = fileURL;
    });
    return url;
    // Reference ref = FirebaseStorage.instance.ref().child(fileName);
    // UploadTask task = ref.putFile(imageFile);
    // TaskSnapshot snapshot = await task;
    //
    // return await snapshot.ref.getDownloadURL();
  }

  // Future<void> getURL(List<File> _images, DocumentReference ref) async {
  //   _images.forEach((image) async {
  //     String imageURL = await uploadImage(image);
  //     ref.update({"imageURL": FieldValue.arrayUnion([imageURL])});
  //   });
  // }

  // Future<File> getImage() async{
  //   return await ImagePicker.pickImage(source: ImageSource.gallery);
  // }
  // static Future<String> fetchImage()async{
  //
  // }
  // Future<void> uploadingBool(measure) async {
  //   await FirebaseFirestore.instance.collection("items").add({
  //     'measure': measure,
  //   });
  // }


  // void addItem(){
  //   String itemname = _nameController.text;
  //   String measure = _measureController.text;
  //   String quantity = _quantityController.text;
  //   String price = _priceController.text;
  //   Map<String, String> item = {
  //     'itemname':itemname,
  //     'measure':measure,
  //     'quantity':quantity,
  //     'price':price,
  //   };
  //   _reference.push().set(item).then((value){
  //     Navigator.pop(context);
  //   });
  // }
  void toggleSwitch(bool value) {

    if(measure == false)
    {
      setState(() {
        measure = true;
        textValue = 'Measure is ON';
      });
      print('Measure is ON');
    }
    else
    {
      setState(() {
        measure = false;
        textValue = 'Measure is OFF';
      });
      print('Measure is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Text("Add Items in your Inventory", style: TextStyle(
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
            child : InkWell(
               onTap: () {
                 _showPicker(context);
                 // file = await getImage();
                 // imagePath = await uploadImage(file);
                 // setState(() {});
               },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.transparent,
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              // child: CircleAvatar(
              //   radius: 50.0,
              //   backgroundImage: (imagePath == null) ? AssetImage('assets/manage.png') : NetworkImage(imagePath),
              //   backgroundColor: Colors.transparent,
              // ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  // Switch(
                  //   onChanged: toggleSwitch,
                  //   value: measure,
                  //   activeColor: Colors.blue,
                  //   activeTrackColor: Colors.yellow,
                  //   inactiveThumbColor: Colors.redAccent,
                  //   inactiveTrackColor: Colors.orange,
                  // ),
                  Text('Measure', style: TextStyle(fontSize: 16, fontFamily: 'jost', fontWeight: FontWeight.w500, color: Colors.black),),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  CustomSwitch(
                    value: measure,
                    onChanged: (value) {
                      print("VALUE : $value");
                      setState(() {
                        measure = value;
                      });
                    },
                    activeColor: Colors.redAccent,
                  ),
                  // FlutterSwitch(
                  //   value: measure,
                  //   onToggle: toggleSwitch,
                  //   height: 20.0,
                  //   width: 40.0,
                  //   padding: 4.0,
                  //   toggleSize: 15.0,
                  //   borderRadius: 10.0,
                  //   inactiveColor: Colors.blueGrey,
                  //   activeColor: Colors.redAccent,
                  // ),
                ]),
          ),
          Padding(padding: EdgeInsets.all(10)),
              makeInput1(label: "Item Name     "),
          // Padding(
          //   padding: EdgeInsets.all(5),
          // ),
          //     makeInput2(label: "Item Measure"),





        Padding(
            padding: EdgeInsets.all(5),
          ),

          makeInput3(label: "Item Quantity"),
          Padding(
            padding: EdgeInsets.all(5),
          ),
              makeInput4(label: "Item Price      "),

          Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 130, right: 130),
                  child: InkWell(
                    onTap: () async{

                      if (_nameController.text.isNotEmpty &&
                          _quantityController.text.isNotEmpty && _priceController.text.isNotEmpty ) {
                        await uploadImage();
                        FirebaseFirestore.instance
                            .collection('items')
                            .add({
                          "itemname": _nameController.text,
                          "quantity": _quantityController.text,
                          "price": _priceController.text,
                          'measure': measure,
                          'url': url,
                        })
                            .then((result) => {
                            _nameController.clear(),
                          _quantityController.clear(),
                          _priceController.clear(),
                        })
                            .catchError((err) => print(err));

                      }
                      clearSelection();

                      // uploadFile();
                      // clearSelection();

                      Fluttertoast.showToast(
                        msg: "Item Added Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Color.fromRGBO(0, 0, 38, 1),
                        textColor: Colors.white,
                        fontSize: 15.0,
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>  Inventory()));
                    },
                    child: Container(
                      height: 50,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 70, 1),
                        border: new Border.all(color: Colors.black, width: 2.0),
                        borderRadius: new BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text("Add",textAlign: TextAlign.center, style: TextStyle(
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
  Widget makeInput1({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          padding: EdgeInsets.only( left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  controller: _nameController,
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
  // Widget makeInput2({label, obscureText = false}) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.only(left: 20, right: 20),
  //         child: Text(label, style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w500,
  //           color: Colors.black, fontFamily: 'jost',
  //         ),),
  //       ),
  //
  //
  //       Padding(
  //         padding: EdgeInsets.only( left: 20, right: 20),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               height: 30,
  //               width: 180,
  //               child: TextFormField(
  //                 controller: _measureController,
  //                 obscureText: obscureText,
  //                 maxLines: 1,
  //                 decoration: InputDecoration(
  //                   filled: true,
  //                   fillColor: Colors.white,
  //                   contentPadding: EdgeInsets.all(8),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.black),
  //                     borderRadius: BorderRadius.circular(5),
  //                   ),
  //                   border: OutlineInputBorder(
  //                       borderSide: BorderSide(color: Colors.black),
  //                       borderRadius: BorderRadius.circular(5)
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget makeInput3({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                  obscureText: obscureText,
                  enabled: globals.stockLimit,
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
  Widget makeInput4({label, obscureText = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  obscureText: obscureText,
                  enabled: globals.stockLimit,
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
