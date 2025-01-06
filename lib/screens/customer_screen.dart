import 'package:flutter/material.dart';
import 'package:optician_app/data/model/CustomerData.dart';
import 'package:optician_app/screens/widgets/m_dataTable.dart';
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
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1
            )
          )
        )
      ),
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
                                      icon: Icon(Icons.edit), onPressed: () {
                                      showDialog(context: context, builder: (context) {
                                        return Column(
                                          children: [
                                            TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                  hintText: 'Id',
                                                  alignLabelWithHint: true
                                              ),
                                            )
                                          ],
                                        );
                                      },);
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

  void _showDialog(CustomerData data){
    showDialog(context: context, builder: (context) {
      return Column(
        children: [
          TextField(
            enabled: false,
            decoration: InputDecoration(
              hintText: 'Id',
              alignLabelWithHint: true
            ),
          )
        ],
      );
    },);
  }
}
