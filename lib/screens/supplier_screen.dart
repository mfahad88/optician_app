import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:optician_app/screens/widgets/m_Dialog.dart';
import 'package:optician_app/screens/widgets/m_dataTable.dart';
import 'package:optician_app/viewmodel/SupplierVIewModel.dart';
import 'package:provider/provider.dart';

import '../viewmodel/CustomerViewModel.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SupplierViewModel viewModel=context.read();
    viewModel.fetchSuppliers();
    return MaterialApp(

      home: Scaffold(
        body: Consumer<SupplierViewModel>(
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
                                  //value.insertCustomer();
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


                    mDataTable(columns: value.columns,
                        rows: value.suppliers.asMap().entries.map(
                              (e) => DataRow(
                              cells: [
                                DataCell(Text('${e.value.id}')),
                                DataCell(Text('${e.value.name}')),
                                DataCell(Text('${e.value.contact_number}')),
                                DataCell(Text('${e.value.email}')),
                                DataCell(Text('${e.value.address}')),
                                DataCell(Text('${e.value.services_provided}')),


                                DataCell(
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        value.hints['Id']={false:TextEditingController(text: e.value.id.toString())};
                                        value.hints['Name']={true:TextEditingController(text: e.value.name)};
                                        value.hints['Contact No']={true:TextEditingController(text: e.value.contact_number)};
                                        value.hints['Email']={true:TextEditingController(text: e.value.email)};
                                        value.hints['Address']={true:TextEditingController(text: e.value.address)};
                                        value.hints['Services Provided']={true:TextEditingController(text: e.value.services_provided)};

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return mDialog(
                                              context: context,
                                              size: Size(500.r, 500.r),
                                              hints: value.hints,
                                              onPressed: () {
                                                value.updateSupplier(e.value.id);
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
