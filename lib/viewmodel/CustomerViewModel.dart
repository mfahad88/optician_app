import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:optician_app/core/database/database_manager.dart';
import 'package:optician_app/core/utils.dart';

import '../data/model/CustomerData.dart';

class CustomerViewModel extends ChangeNotifier{

  List<CustomerData> customers=List.empty(growable: true);
  bool isLoading=false;
  List<String> columns=[];
  List<String> updatable_field=[];
  List<String> insertable_field=[];
  List<String> selectable_field=[];

  List<Map<String,String>> rows=[];
/*  final Map<String,Map<bool,TextEditingController>> hints={
    'FullName':{true:TextEditingController()},
    'Contact No':{true:TextEditingController()},
    'Email':{true:TextEditingController()},
    'Address':{true:TextEditingController()},
    'Created At':{false:TextEditingController()},
    'Update At':{false:TextEditingController()},

  };*/
  Map<String,Map<bool,TextEditingController>> hints={};


  void fetchCustomers() async{
    try{
      final _conn=await DatabaseManager().createConnection();
      isLoading=true;
      Results? result= await _conn?.query('Select * from customers');
      columns.clear();
      rows.clear;
      updatable_field=result!.first.fields['updatable_field'].toString().split(',');
      insertable_field=result.first.fields['insertable_field'].toString().split(',');
      selectable_field=result.first.fields['selectable_field'].toString().split(',');


      result.first.fields.keys.toList().forEach((element) {
        updatable_field.forEach((element1) {
          if(element==element1){
            hints[Utils.convertToUpperCase(input: element)]={true:TextEditingController()};
          }else{
            hints[Utils.convertToUpperCase(input: element)] = {false: TextEditingController()};
          }
        },);
        selectable_field.forEach((element1) {
          if(element==element1){
            columns.add(element);
          }
        },);
      },);


      result.forEach((data) {
        Map<String,String> row= {};

        data.fields.forEach((key, value) {
          selectable_field.forEach((element) {
            if(key==element){
              row[Utils.convertToUpperCase(input: key)]=value.toString();
            }
          },);
        },);
        rows.add(row);
      },);
    }catch(e){
      print('Error: $e');
    }finally{

      isLoading=false;
      notifyListeners();
    }

  }

  void populateModal(Map<String,String> f) {
   /* hints.entries.forEach((element) {
      f.entries.forEach((element1) {
        if(element.key==element1.key){
          updatable_field.forEach((el) {
            if(Utils.convertToUpperCase(input: el)==element1.key){
              hints[element1.key]={true:TextEditingController(text: element1.value)};
            }else{
              hints[element1.key]={false:TextEditingController(text: element1.value)};
            }
          },);

        }

      },);
    },);*/
    notifyListeners();
  }

  /*Future<void> updateCustomer(int? id) async {
   try{
     final _conn=await DatabaseManager().createConnection();
     Results? result= await _conn?.query('UPDATE customers SET full_name = ?,contact_number = ?,email = ?,address = ? WHERE id = ?',
       [hints['FullName']?.entries.first.value.text,hints['Contact No']?.entries.first.value.text,hints['Email']?.entries.first.value.text,hints['Address']?.entries.first.value.text,id]
     );
     fetchCustomers();
   }catch (e){
     print('Update Customer: $e');
   }finally{
     notifyListeners();
   }
  }*/
}