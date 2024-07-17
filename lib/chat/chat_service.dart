import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatService extends ChangeNotifier {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  // GET users stream except blocked Users
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
    final currentUser = _firebaseAuth.currentUser;

    return _firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUsers")
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUsersIds = snapshot.docs.map((doc) => doc.id).toList();

      final usersSnapshot = await _firestore.collection("Users").get();

      return usersSnapshot.docs
          .where((doc) =>
              doc.data()['email'] != currentUser.email &&
              !blockedUsersIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  // send message
  Future<void> sendMessage(String recieverID, String message) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String? currentUserEmail = _firebaseAuth.currentUser!.email;

    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail.toString(),
        recieverID: recieverID,
        message: message,
        timestamp: timestamp);

    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, recieverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // report user
  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = _firebaseAuth.currentUser;
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp()
    };

    await _firestore.collection("Reports").add(report);
  }

  // block user
  Future<void> blockUser(String userId) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});
    notifyListeners();
  }

  // unblock user
  Future<void> unblockUser(String blockUserId) async {
    final currentUser = _firebaseAuth.currentUser;
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockUserId)
        .delete();
  }

  // get blocked user stream
   Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
    return _firestore
        .collection("Users")
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(
        blockedUserIds.map(
          (id) => _firestore.collection('Users').doc(id).get(),
        ),
      );

      return userDocs
          .where((doc) => doc.exists && doc.data() != null) // Ensure document exists and data is not null
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    }).handleError((error) {
      print("Error fetching blocked users: $error");
      return [];
    });
  }
}
