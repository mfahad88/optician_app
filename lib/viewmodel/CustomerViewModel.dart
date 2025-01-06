import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:optician_app/core/database/database_manager.dart';

import '../data/model/CustomerData.dart';

class CustomerViewModel extends ChangeNotifier{

  List<CustomerData> customers=List.empty(growable: true);
  bool isLoading=false;
  CustomerViewModel(){

  }

  void fetchCustomers() async{
    try{
      final _conn=await DatabaseManager().createConnection();
      isLoading=true;
      Results? result= await _conn?.query('Select * from customers');
      result?.forEach((data) {
        print(data);
        customers.add(CustomerData(data['id'], data['full_name'], data['contact_number'],'No address', data['created_at'], data['updated_at']));
      },);
    }catch(e){
      print('Error: $e');
    }finally{

      isLoading=false;
      notifyListeners();
    }

  }
}