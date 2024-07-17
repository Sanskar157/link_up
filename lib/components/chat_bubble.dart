import 'package:chatapp/chat/chat_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  // show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.surface,
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  _reportMessage(context, messageId, userId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('block'),
                onTap: () {
                  _blockMessage(context, userId);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ));
        });
  }

  // report message
  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Report Message"),
              content:
                  const Text("Are you sure you want to report this message?"),
              actions: [
                //cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                //report button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ChatService().reportUser(messageId, userId);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Message Reported")));
                  },
                  child: const Text('Report'),
                ),
              ],
            ));
  }

  // block user
  void _blockMessage(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Block Message"),
              content:
                  const Text("Are you sure you want to block this message?"),
              actions: [
                //cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                //report button
                TextButton(
                  onPressed: () {
                    ChatService().blockUser(userId);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User Blocked!")));
                  },
                  child: const Text('Block'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: isCurrentUser
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey.shade500,
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
