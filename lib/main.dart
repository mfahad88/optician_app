import 'package:flutter/material.dart';
import 'package:optician_app/core/database/database_manager.dart';
import 'package:optician_app/screens/customer_screen.dart';
import 'package:optician_app/viewmodel/CustomerViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CustomerViewModel(),)
        ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedScreen;

  @override
  Widget build(BuildContext context) {

      Size size=MediaQuery.of(context).size;
    List<String> menus=['Home','Customers','Products','Sales','Reports','Inventory','Prescriptions','Vendors'];
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1)
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(menus[index]),
                    onTap: () => setState(() => selectedScreen=menus[index].toLowerCase()),
                  ),
                  itemCount: menus.length,
                ),
              ),
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Expanded(
                flex:4,
                child:
                selectedScreen=='customers'.toLowerCase()?CustomerScreen():Text('Screen under development')
            )
          ],
        ),
      ),
    );
  }
}
