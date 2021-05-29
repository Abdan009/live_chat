part of 'services.dart';

class DetailChatServices {
  static CollectionReference _detailChatServices =
      FirebaseFirestore.instance.collection('chat');
  static Future<void> updateChat(DetailChat detailChat, String idChat) async {
    try {
      await _detailChatServices
          .doc(idChat)
          .collection('detailChat')
          .doc(detailChat.id)
          .set(
            detailChat.toJson(),
          );
    } on FirebaseException catch (e) {
      print('Terjadi error : ' + e.message);
    }
  }

  static List<DetailChat> _getChatDetailColl(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) => DetailChat.fromSnapshot(e)).toList();
  }

  static Stream<List<DetailChat>> getChatDetailColl(String idChat) {
    return _detailChatServices
        .doc(idChat)
        .collection('detailChat')
        .snapshots()
        .map(_getChatDetailColl);
  }
}
