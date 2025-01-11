import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:optician_app/core/utils.dart';
import 'package:optician_app/data/model/CustomerData.dart';
import 'package:optician_app/screens/widgets/m_dataTable.dart';
import 'package:optician_app/screens/widgets/m_Dialog.dart';
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
                Gap(10.r),
                Row(
                  children: [
                    Gap(10.r),
                    FilledButton(

                        onPressed: () {
                          // value.hints['FullName']={true:TextEditingController(text: '')};
                          // value.hints['Contact No']={true:TextEditingController(text: '')};
                          // value.hints['Email']={true:TextEditingController(text: '')};
                          // value.hints['Address']={true:TextEditingController(text: '')};
                          // value.hints['Created At']={false:TextEditingController(text: '')};
                          // value.hints['Update At']={false:TextEditingController(text: '')};
                          showDialog(
                            context: context,
                            builder: (context) {
                              return mDialog(
                                context: context,
                                size: Size(500.r, 500.r),
                                hints: value.hints,
                                onPressed: () {
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


                    mDataTable(columns: value.columns.map((e) => Utils.convertToUpperCase(input: e),).toList(),
                        rows: value.rows.map((f) => DataRow(

                            cells: f.entries.map((e) {
                              if(e.value!='edit') {
                                return DataCell(Text(e.value.toString()));
                              }else{
                                return DataCell(
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        value.populateModal(f);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return mDialog(
                                              context: context,
                                              size: Size(500.r, 500.r),
                                              hints: value.hints,
                                              onPressed: () {
                                                // value.updateCustomer(e.value.id);
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        );
                                        // _showDialog(e.value,value);
                                      },
                                    )
                                );
                              }
                            },
                            ).toList()
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

