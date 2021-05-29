part of 'models.dart';

class Chat {
  final String id, lastMessage;
  final List<String> members;
  final Users user;
  final DateTime timeCreate, timeUpdate;
  Chat({
    this.id,
    @required this.members,
    this.user,
    @required this.lastMessage,
    this.timeCreate,
    this.timeUpdate,
  });

  factory Chat.fromSnapshot(DocumentSnapshot snapshot) {
    return Chat(
      id: snapshot.id,
      members:
          (snapshot['members'] as Iterable).map((e) => e.toString()).toList(),
      lastMessage: snapshot['lastMessage'],
      timeCreate: snapshot['timeCreate'].toDate(),
      timeUpdate: snapshot['timeUpdate'].toDate(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'members': this.members,
      'lastMessage': this.lastMessage,
      'timeCreate': this.timeCreate ?? DateTime.now(),
      'timeUpdate': DateTime.now()
    };
  }

  Chat copyWith({
    String lastMessage,
    List<String> members,
    Users user,
    DateTime timeUpdate,
  }) {
    return Chat(
      id: this.id,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      timeCreate: timeCreate ?? this.timeCreate,
      timeUpdate: timeUpdate ?? this.timeUpdate,
    );
  }
}
