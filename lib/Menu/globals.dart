library my_prj.globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool stockLimit = true, creditLimit = true;
TextEditingController stockController, priceController, depositController, outstandingAmt;
var item, cName, cid, sales, deposit;
List<int> selectedItems = [];
List<DropdownMenuItem> tableItems = [];