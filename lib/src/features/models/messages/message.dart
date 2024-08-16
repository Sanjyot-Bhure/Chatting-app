
class Message {
  String? idFrom;
  String? idTo;
  String? message;
  String? timestamp;
  int? type;
  Message({
    required this.idFrom,
    required this.idTo,
    required this.message,
    required this.type,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() => {
        'idFrom': 'idFrom',
        'idTo': 'idTo',
        'message': 'message',
        'timestamp': 'timestamp',
        'type': 'type',
      };
      
}
