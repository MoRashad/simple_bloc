import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/users/cubit/users_cubit.dart';
import 'package:simple_bloc/users/user_items.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Users'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: UsersCubit.get(context).usernameController,
                  decoration: InputDecoration(
                    suffix: TextButton(
                      onPressed: () {
                        UsersCubit.get(context).insertUserData();
                      },
                      child: Text(UsersCubit.get(context).selectedUser.isEmpty
                          ? 'save'
                          : 'update'),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      UsersCubit.get(context).getUsersData();
                    },
                    child: ListView.separated(
                      itemCount: UsersCubit.get(context).users.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return UserItems(
                          item: UsersCubit.get(context).users[index],
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
