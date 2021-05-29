part of 'models.dart';

class DetailChat {
  final String id, sendId, message;
  final DateTime timeCreate;
  DetailChat({
    this.id,
    @required this.sendId,
    @required this.message,
    this.timeCreate,
  });

  factory DetailChat.fromSnapshot(DocumentSnapshot snapshot) {
    return DetailChat(
      id: snapshot.id,
      sendId: snapshot['sendId'],
      message: snapshot['message'],
      timeCreate: snapshot['timeCreate'].toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sendId': this.sendId,
      'message': this.message,
      'timeCreate': this.timeCreate,
    };
  }
}
