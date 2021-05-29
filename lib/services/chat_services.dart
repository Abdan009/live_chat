part of 'services.dart';

class ChatServices {
  static CollectionReference _chatServices =
      FirebaseFirestore.instance.collection('chat');
  static Future<void> updateChat(Chat chat) async {
    try {
      await _chatServices.doc(chat.id).set(
            chat.toJson(),
          );
    } on FirebaseException catch (e) {
      print('Terjadi error : ' + e.message);
    }
  }

  static List<Chat> _getChatColl(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) => Chat.fromSnapshot(e)).toList();
  }

  static Stream<List<Chat>> getChatColl() {
    return _chatServices.snapshots().map(_getChatColl);
  }
}
