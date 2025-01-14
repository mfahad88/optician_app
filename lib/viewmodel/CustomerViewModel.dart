import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:optician_app/core/database/database_manager.dart';

import '../data/model/CustomerData.dart';

class CustomerViewModel extends ChangeNotifier{

  List<CustomerData> customers=List.empty(growable: true);
  bool isLoading=true;

  final Map<String,Map<bool,TextEditingController>> hints={
    'FullName':{true:TextEditingController()},
    'Contact No':{true:TextEditingController()},
    'Email':{true:TextEditingController()},
    'Address':{true:TextEditingController()},
    'Created At':{false:TextEditingController()},
    'Update At':{false:TextEditingController()},

  };


  void fetchCustomers() async{
    try{
      final _conn=await DatabaseManager().createConnection();
      isLoading=true;
      Results? result= await _conn?.query('Select * from customers');
      customers.clear();
      result?.forEach((data) {
        // print(data);
        customers.add(CustomerData(data['id'], data['full_name'], data['contact_number'],data['address'],data['email'], data['created_at'], data['updated_at']));
      },);
    }catch(e){
      print('Error: $e');
    }finally{

      isLoading=false;
      notifyListeners();
    }

  }

  Future<void> insertCustomer() async {
    try{
      final _conn=await DatabaseManager().createConnection();
      Results? result= await _conn?.query('INSERT INTO customers (full_name,contact_number,email,address) VALUES (?,?,?,?)',[hints['FullName']?.values.first.text,hints['Contact No']?.values.first.text,hints['Email']?.values.first.text,hints['Address']?.values.first.text]);
      print('Result: $result');
      fetchCustomers();
    }catch (e){
      print('Insert Customer: $e');
    }finally{
      notifyListeners();
    }
  }

  Future<void> updateCustomer(int? id) async {
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
  }

  void searchCustomer(String v) {
    if(v.isNotEmpty){
      customers=customers.where((element) => element.toString().toLowerCase().contains(v.toLowerCase()),).toList();
      notifyListeners();
    }else{
      fetchCustomers();
    }
  }
}