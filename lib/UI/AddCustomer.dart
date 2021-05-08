import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_management/Menu/Settings.dart';
import 'package:store_management/UI/Customers.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController _nameController,_emailController,_numberController,_addressController;
  String imagePath, url;
  File file, imageFile, _image;
  var sales = 0 , deposit = 0;


  @override
  void initState(){
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _numberController = TextEditingController();
    _addressController = TextEditingController();
    // _reference = FirebaseDatabase.instance.reference().child('Items');
    super.initState();

  }

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

  uploadImage() async{
    String fileName = _nameController.text;
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

  // fetchImage() async{
  //
  // }

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
            child: Text("Create Customers", style: TextStyle(
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
          makeInput4(label: "Address      "),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 130, right: 130),
                  child: InkWell(
                    onTap: ()async{
                      if (_nameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty && _numberController.text.isNotEmpty && _addressController.text.isNotEmpty) {
                        await uploadImage();
                        FirebaseFirestore.instance
                            .collection('customers')
                            .add({
                          "customerName": _nameController.text,
                          "emailID": _emailController.text,
                          "contactNumber": _numberController.text,
                          "address": _addressController.text,
                          'customerURL': url,
                          "sales" : sales,
                          "deposit": deposit,

                        })
                            .then((result) => {
                          _nameController.clear(),
                          _emailController.clear(),
                          _numberController.clear(),
                          _addressController.clear()
                        })
                            .catchError((err) => print(err));
                      }
                      clearSelection();
                      Fluttertoast.showToast(
                        msg: "Customer Created Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Color.fromRGBO(0, 0, 38, 1),
                        textColor: Colors.white,
                        fontSize: 15.0,
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>  Customers()));
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
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 30,
                width: 180,
                child: TextFormField(
                  obscureText: obscureText,
                  controller: _nameController,
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
  Widget makeInput2({label, obscureText = false}) {
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
                  obscureText: obscureText,
                  controller: _emailController,
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
                  keyboardType: TextInputType.phone,
                  obscureText: obscureText,
                  controller: _numberController,
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
                  obscureText: obscureText,
                  controller: _addressController,
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
