import 'package:flutter/material.dart';

import '../../data/datasources/user_data_source.dart';
import '../../domain/entities/user.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  Future<List<User>> _getAllUsers() async {
    final dataSource = MockUserDataSource();
    return dataSource.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<User>>(
        future: _getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(userId: user.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
