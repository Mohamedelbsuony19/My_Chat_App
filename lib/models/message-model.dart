class messageModel {
  final String? message;
  final String? id;
  int? type;
  messageModel(this.message, this.id, this.type);
  factory messageModel.fromJson(jsonData) {
    return messageModel(jsonData['message'], jsonData['id'], jsonData['type']);
  }
}
