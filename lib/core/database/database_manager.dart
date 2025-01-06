
import 'package:mysql1/mysql1.dart';

class DatabaseManager{
  final _settings=ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    password: '123',
    db: 'opticalshop',
  );
  Future<MySqlConnection?> createConnection() async {
    try{
      return await MySqlConnection.connect(_settings);

    }catch (e){
      print('Error: $e');
    }
  }


}