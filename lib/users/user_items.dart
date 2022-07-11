import 'package:flutter/material.dart';
import 'package:simple_bloc/users/cubit/users_cubit.dart';

class UserItems extends StatelessWidget {
  const UserItems({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Map item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UsersCubit.get(context).selectedUserToUpdate(user: item);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.teal,
              child: Text(
                '${item['id']}',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                '${item['name']}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
