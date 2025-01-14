import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:optician_app/data/model/CustomerData.dart';
import 'package:optician_app/screens/widgets/m_dataTable.dart';
import 'package:optician_app/screens/widgets/m_Dialog.dart';
import 'package:optician_app/screens/widgets/m_search_bar.dart';
import 'package:optician_app/screens/widgets/m_textfield.dart';
import 'package:optician_app/viewmodel/CustomerViewModel.dart';
import 'package:provider/provider.dart';

import '../core/database/database_manager.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerViewModel viewModel=context.read();
    viewModel.fetchCustomers();
    return MaterialApp(

      home: Scaffold(
        body: Consumer<CustomerViewModel>(
          builder: (_,value, child) {
            return value.isLoading?Center(
                child: CircularProgressIndicator()
            ):Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Gap(10.r),
                    mSearchBar(
                      onChanged: (v) =>value.searchCustomer(v) ,
                    ),
                    Gap(50.r),
                    FilledButton(

                        onPressed: () {
                          value.hints['FullName']={true:TextEditingController(text: '')};
                          value.hints['Contact No']={true:TextEditingController(text: '')};
                          value.hints['Email']={true:TextEditingController(text: '')};
                          value.hints['Address']={true:TextEditingController(text: '')};
                          value.hints['Created At']={false:TextEditingController(text: '')};
                          value.hints['Update At']={false:TextEditingController(text: '')};
                          showDialog(
                            context: context,
                            builder: (context) {
                              return mDialog(
                                context: context,
                                size: Size(500.r, 500.r),
                                hints: value.hints,
                                onPressed: () {
                                  value.insertCustomer();
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        }, child: Text('Add',)),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  children: [


                    mDataTable(columns: ['id','FullName','Address','ContactNumber','Email','Actions'],
                        rows: value.customers.asMap().entries.map(
                              (e) => DataRow(
                              cells: [
                                DataCell(Text('${e.value.id}')),
                                DataCell(Text('${e.value.fullName}')),
                                DataCell(Text('${e.value.address}')),
                                DataCell(Text('${e.value.contactNumber}')),
                                DataCell(Text('${e.value.email}')),
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
}

