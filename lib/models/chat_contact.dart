class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSend;
  final String lastMessage;

  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSend,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSend': timeSend.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      contactId: map['contactId'] as String,
      timeSend: DateTime.fromMillisecondsSinceEpoch(map['timeSend'] as int),
      lastMessage: map['lastMessage'] as String,
    );
  }
}
