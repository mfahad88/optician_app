import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:optician_app/data/model/SupplierData.dart';

import '../core/database/database_manager.dart';

class SupplierViewModel extends ChangeNotifier{
  List<String> columns =['Id','Name','Contact No','Email', 'Address', 'Services Provided','Actions'];
  List<SupplierData> suppliers=List.empty(growable: true);
  bool isLoading=true;
  final Map<String,Map<bool,TextEditingController>> hints={
    'Id':{false:TextEditingController()},
    'Name':{true:TextEditingController()},
    'Contact No':{true:TextEditingController()},
    'Email':{true:TextEditingController()},
    'Address':{true:TextEditingController()},
    'Services Provided':{true:TextEditingController()},
  };

  void fetchSuppliers() async{
    try{
      final _conn=await DatabaseManager().createConnection();
      isLoading=true;
      Results? result= await _conn?.query('Select * from vendors');
      suppliers.clear();
      result?.forEach((data) {
        // print(data);
        suppliers.add(SupplierData(
          id: data['id'],
          address: data['address'],
          contact_number: data['contact_number'],
          email: data['email'],
          name: data['name'],
          services_provided: data['services_provided']
        ));
      },);
    }catch(e){
      print('Error: $e');
    }finally{

      isLoading=false;
      notifyListeners();
    }

  }

  Future<void> updateSupplier(int? id) async {
    try{
      final _conn=await DatabaseManager().createConnection();
      Results? result= await _conn?.query('UPDATE vendors SET name =?,contact_number = ?,email = ?,address = ?,services_provided = ? WHERE id  = ?',
          [hints['Name']?.entries.first.value.text,hints['Contact No']?.entries.first.value.text,hints['Email']?.entries.first.value.text,hints['Address']?.entries.first.value.text,hints['Services Provided']?.entries.first.value.text,id]
      );
      fetchSuppliers();
    }catch (e){
      print('Update Customer: $e');
    }finally{
      notifyListeners();
    }
  }
}