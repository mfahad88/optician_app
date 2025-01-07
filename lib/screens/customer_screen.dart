import 'package:flutter/material.dart';
import 'package:optician_app/data/model/CustomerData.dart';
import 'package:optician_app/screens/widgets/m_dataTable.dart';
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
                                      icon: Icon(Icons.edit), onPressed: () async {
                                      _showDialog(e.value,value);
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

  void _showDialog(CustomerData data, CustomerViewModel value){
    Size size= MediaQuery.of(context).size;
    value.controllerId.text=data.id.toString();
    showDialog(context: context, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0)
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.3,
            maxHeight: size.height * 0.5
          ),
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              mTextField(label: 'Id', controller: value.controllerId)
            ],
          ),
        ),
      );

    },);
  }
}
