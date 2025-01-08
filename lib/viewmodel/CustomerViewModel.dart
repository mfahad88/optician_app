import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:optician_app/core/database/database_manager.dart';

import '../data/model/CustomerData.dart';

class CustomerViewModel extends ChangeNotifier{

  List<CustomerData> customers=List.empty(growable: true);
  bool isLoading=false;
  TextEditingController controllerId=TextEditingController(text: '-1');
  TextEditingController controllerFname=TextEditingController(text: '');
  TextEditingController controllerContactNo=TextEditingController(text: '');
  TextEditingController controllerEmail=TextEditingController(text: '');
  TextEditingController controllerAddress=TextEditingController(text: '');
  TextEditingController controllerCreatedAt=TextEditingController(text: '');
  TextEditingController controllerUpdatedAt=TextEditingController(text: '');
  CustomerViewModel(){

  }


 /* TextEditingController get controllerId => _controllerId;

  set controllerId(TextEditingController value) {
    _controllerId = value;
    notifyListeners();
  }*/

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

  Future<void> updateCustomer() async {
   try{
     final _conn=await DatabaseManager().createConnection();
     Results? result= await _conn?.query('UPDATE customers SET full_name = ?,contact_number = ?,email = ?,address = ? WHERE id = ?',
       [controllerFname.text,controllerContactNo.text,controllerEmail.text,controllerAddress.text,controllerId.text]
     );
     fetchCustomers();
   }catch (e){
     print('Update Customer: $e');
   }finally{
     notifyListeners();
   }
  }
}