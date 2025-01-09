import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:optician_app/data/model/CustomerData.dart';
import 'package:optician_app/screens/widgets/m_dataTable.dart';
import 'package:optician_app/screens/widgets/m_Dialog.dart';
import 'package:optician_app/screens/widgets/m_textfield.dart';
import 'package:optician_app/viewmodel/CustomerViewModel.dart';
import 'package:provider/provider.dart';

import '../core/database/database_manager.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    CustomerViewModel viewModel=context.read();
    viewModel.fetchCustomers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: Consumer<CustomerViewModel>(
          builder: (_,value, child) {
            return value.isLoading?Center(
                child: CircularProgressIndicator()
            ):ListView(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [

                    mDataTable(columns: ['id','FullName','Address','ContactNumber','Actions'],
                        rows: value.customers.asMap().entries.map(
                              (e) => DataRow(
                              cells: [
                                DataCell(Text('${e.value.id}')),
                                DataCell(Text('${e.value.fullName}')),
                                DataCell(Text('${e.value.address}')),
                                DataCell(Text('${e.value.contactNumber}')),
                                // DataCell(Text('${e.value.createdDate}')),
                                // DataCell(Text('${e.value.updatedDate}')),
                                DataCell(
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        value.hints['FullName']={true:TextEditingController(text: e.value.fullName)};
                                        value.hints['Contact No']={true:TextEditingController(text: e.value.contactNumber)};
                                        value.hints['Email']={true:TextEditingController(text: e.value.email)};
                                        value.hints['Address']={true:TextEditingController(text: e.value.address)};
                                        value.hints['Created At']={false:TextEditingController(text: e.value.createdDate.toString())};
                                        value.hints['Update At']={false:TextEditingController(text: e.value.updatedDate.toString())};
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return mDialog(
                                                  context: context,
                                                  size: Size(500.r, 500.r),
                                                  hints: value.hints,
                                                onPressed: () {
                                                  value.updateCustomer(e.value.id);
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            },
                                        );
                                        // _showDialog(e.value,value);
                                      },
                                    )
                                )
                              ]
                          ),
                        ).toList()
                    )
                  ],
                ),
              ],
            );
          },

        ),
      ),
    );
  }

 /* void _showDialog(CustomerData data, CustomerViewModel value){
    Size size= MediaQuery.of(context).size;
    value.controllerId.text=data.id.toString();
    value.controllerFname.text=data.fullName.toString();
    value.controllerAddress.text=data.address.toString();
    value.controllerEmail.text=data.email.toString();
    value.controllerContactNo.text = data.contactNumber.toString();
    value.controllerCreatedAt.text = data.createdDate.toString();
    value.controllerUpdatedAt.text = data.updatedDate.toString();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return Dialog(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0.r)
          ),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 500.r,
                maxHeight: 500.r
            ),
            padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 20.r),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: Icon(Icons.close,size: 16.r,),
                    ),
                  ),
                ),
                Gap(20.r),
                mTextField(label: 'Id',
                  controller: value.controllerId,
                  enabled: false,),
                Gap(8.0.r),
                mTextField(label: 'FullName', controller: value.controllerFname),
                Gap(8.0.r),
                mTextField(label: 'Contact Number', controller: value.controllerContactNo),
                Gap(8.0.r),
                mTextField(label: 'Email', controller: value.controllerEmail),
                Gap(8.0.r),
                mTextField(label: 'Address', controller: value.controllerAddress),
                Gap(8.0.r),
                mTextField(label: 'Created At', controller: value.controllerCreatedAt,enabled: false,),
                Gap(8.0.r),
                mTextField(label: 'Updated At', controller: value.controllerUpdatedAt,enabled: false,),
                Gap(10.0.r),
                FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)
                        )
                    ),
                    onPressed: () {
                      value.updateCustomer();

                      Navigator.pop(context);

                    },
                    child: Text('Save',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white
                      ),)
                )
              ],
            ),
          ),
        );

      },);
  }*/
}
