import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoteController extends GetxController { 
  
  var _titre = "";
  var _description = "";
  var _startdate = "";
  var _enddate = "";
  var _endhour = "";

  String get titre => _titre;
  String get description => _description;
  String get startdate => _startdate;
  String get enddate => _enddate;
  String get endhour => _endhour;

  changeTitreController(value) { _titre = value; print(_titre);}
  changeDescriptionController(value) { _description = value; print(value);}
  changeStartDateController(value) {_startdate = value;}
  changeEndDateController(value) {_enddate = value; }
  changeEndHourController(value) {_endhour = value;}

  




  



}