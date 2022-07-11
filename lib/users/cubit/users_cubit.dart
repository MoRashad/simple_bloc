import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  static UsersCubit get(context) => BlocProvider.of<UsersCubit>(context);
  late Database database;

  void initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'users.db');
    debugPrint('App Database Initialized');
    openAppDatabase(path: path);
    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({required String path}) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)',
        );

        debugPrint('table created');
      },
      onOpen: (Database db) {
        debugPrint('database opened');
        database = db;
        getUsersData();
      },
    );
  }

  TextEditingController usernameController = TextEditingController();

  void insertUserData() {
    if (selectedUser.isNotEmpty) {
      updateUserData();
      return;
    }
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO users(name) VALUES("${usernameController.text}")');
    }).then((value) {
      debugPrint('User Data Inserted');

      usernameController.clear();
      getUsersData();

      emit(AppDatabaseUserCreated());
    });
  }

  List<Map> users = [];

  getUsersData() {
    emit(AppDatabaseLoading());

    database.rawQuery('SELECT * FROM users').then((value) {
      debugPrint('userdata fetched');
      users = value;
      debugPrint(users.toString());
      emit(AppDatabaseUsers());
    });
  }

  Map selectedUser = {};

  void selectedUserToUpdate({required Map user}) {
    selectedUser = user;

    usernameController.text = selectedUser['name'];

    emit(AppSelectedUser());
  }

  updateUserData() async {
    database.rawUpdate(
        'UPDATE users SET name = ? WHERE id = ${selectedUser['id']}',
        [(usernameController.text)]).then((value) {
      selectedUser = {};
      usernameController.clear();
      debugPrint('user data updated');
      getUsersData();
    });
  }
}
