part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class AppDatabaseInitialized extends UsersState {}

class AppDatabaseTableCreated extends UsersState {}

class AppDatabaseOpened extends UsersState {}

class AppDatabaseUserCreated extends UsersState {}

class AppDatabaseLoading extends UsersState {}

class AppDatabaseUsers extends UsersState {}

class AppSelectedUser extends UsersState {}
