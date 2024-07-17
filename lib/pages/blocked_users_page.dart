import 'package:chatapp/auth/auth_service.dart';
import 'package:chatapp/chat/chat_service.dart';
import 'package:chatapp/components/user_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String userId = authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BLOCKED USERS",
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: chatService.getBlockedUsersStream(userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                child: Text("Error loading..."),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text("No blocked users..."),
              );
            }

            final blockedUsers = snapshot.data ?? [];
            if (blockedUsers.isEmpty) {
              return const Center(
                child: Text("No blocked users..."),
              );
            }

            return ListView.builder(
              itemCount: blockedUsers.length,
              itemBuilder: (context, index) {
                final user = blockedUsers[index];
                return UserTile(
                  text: user['email'] ?? 'Unknown',
                  onTap: () => _showUnblockBox(context, user['uid'] ?? ''),
                );
              },
            );
          }),
    );
  }

  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Unblock User'),
              content:
                  const Text('Are you sure you want to unblock this user?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    chatService.unblockUser(userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User unblocked!")));
                  },
                  child: const Text("Unblock"),
                ),
              ],
            ));
  }
}
