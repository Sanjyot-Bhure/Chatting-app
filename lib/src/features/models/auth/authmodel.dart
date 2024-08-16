class UserModel {
  String? name;
  String? email;
  String? image;
  String? id;
  String? about;
  String? createdAt;
  bool? isOnline;
  String? lastActive;
  String? pushToken;
  // final List<String> groupId;
  UserModel({
    this.name,
    this.email,
    this.image,
    this.about,
    this.id,
    this.createdAt,
    this.isOnline,
    this.lastActive,
    this.pushToken,
    // required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
      'about': about,
      'createdAt': createdAt,
      'isOnline': isOnline,
      'lastActive': lastActive,
      'pushToken': pushToken,
      // 'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      // id: map['id'] != null ? map['id'] as String : null,
      id: documentId,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      lastActive:
          map['lastActive'] != null ? map['lastActive'] as String : null,
      pushToken: map['pushToken'] != null ? map['pushToken'] as String : null,
      // groupId: List<String>.from(map['groupId']),
    );
  }
}

// class MyModel {
//   final String id;
//   final String name;
//   // Add more fields as needed

//   MyModel({required this.id, required this.name});

//   factory MyModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return MyModel(
//       id: snapshot.id,
//       name: snapshot.get('name'),
//       // Add more fields as needed
//     );
//   }
// }

// Stream<List<MyModel>> getNestedCollection(String parentId) {
//   // print(parentId);
//   return FirebaseFirestore.instance
//       .collection('USERS')
//       .doc(parentId)
//       .collection('my-user')
//       .snapshots()
//       .map((snapshot) {
//     return snapshot.docs.map((doc) => MyModel.fromSnapshot(doc)).toList();
//   });
// }

// class UserChat {
//   final String id;
//   final String photoUrl;
//   final String nickname;
//   final String aboutMe;

//   const UserChat(
//       {required this.id,
//       required this.photoUrl,
//       required this.nickname,
//       required this.aboutMe});

//   Map<String, String> toJson() {
//     return {
//       FirestoreConstants.nickname: nickname,
//       FirestoreConstants.aboutMe: aboutMe,
//       FirestoreConstants.photoUrl: photoUrl,
//     };
//   }

//   factory UserChat.fromDocument(DocumentSnapshot doc) {
//     String aboutMe = "";
//     String photoUrl = "";
//     String nickname = "";
//     try {
//       aboutMe = doc.get(FirestoreConstants.aboutMe);
//     } catch (e) {}
//     try {
//       photoUrl = doc.get(FirestoreConstants.photoUrl);
//     } catch (e) {}
//     try {
//       nickname = doc.get(FirestoreConstants.nickname);
//     } catch (e) {}
//     return UserChat(
//       id: doc.id,
//       photoUrl: photoUrl,
//       nickname: nickname,
//       aboutMe: aboutMe,
//     );
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
