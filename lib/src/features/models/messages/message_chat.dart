import '../../../enum/message_enum/message_enum.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;

  Message({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      repliedMessage: map['repliedMessage'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
    );
  }
}










// 






























// import 'package:cloud_firestore/cloud_firestore.dart';
 

// class MessageChat {
//   final String idFrom;
//   final String idTo;
//   final String timestamp;
//   final String content;
//   final int type;

//   const MessageChat({
//     required this.idFrom,
//     required this.idTo,
//     required this.timestamp,
//     required this.content,
//     required this.type,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       FirestoreConstants.idFrom: idFrom,
//       FirestoreConstants.idTo: idTo,
//       FirestoreConstants.timestamp: timestamp,
//       FirestoreConstants.content: content,
//       FirestoreConstants.type: type,
//     };
//   }

//   factory MessageChat.fromDocument(DocumentSnapshot doc) {
//     String idFrom = doc.get(FirestoreConstants.idFrom);
//     String idTo = doc.get(FirestoreConstants.idTo);
//     String timestamp = doc.get(FirestoreConstants.timestamp);
//     String content = doc.get(FirestoreConstants.content);
//     int type = doc.get(FirestoreConstants.type);
//     return MessageChat(
//         idFrom: idFrom,
//         idTo: idTo,
//         timestamp: timestamp,
//         content: content,
//         type: type);
//   }
// }

// class FirestoreConstants {
//   static const pathUserCollection = "users";
//   static const pathMessageCollection = "messages";
//   static const nickname = "nickname";
//   static const aboutMe = "aboutMe";
//   static const photoUrl = "photoUrl";
//   static const id = "id";
//   static const chattingWith = "chattingWith";
//   static const idFrom = "idFrom";
//   static const idTo = "idTo";
//   static const timestamp = "timestamp";
//   static const content = "content";
//   static const type = "type";
// }
