import 'package:firebase/conctants/conestants/constants.dart';

class Message{
  final String message;

  Message(this.message);

  factory Message.fromJson(json) {
    return Message(json[kmessage],);
  }
//

}