import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String? texto;
  final String? uuid;
  final AnimationController animationController;

  const ChatMessage(
      {super.key, this.texto, this.uuid, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
            child: this.uuid == "123" ? _myMessage() : _notMyMessage()),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(right: 5, bottom: 5, left: 50),
          child: Text(
            this.texto!,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Color(0xff4D9EF6),
              borderRadius: BorderRadius.circular(20)),
        ));
  }

  Widget _notMyMessage() {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(right: 5, bottom: 5, left: 50),
          child: Text(
            this.texto!,
            style: TextStyle(color: Colors.black),
          ),
          decoration: BoxDecoration(
              color: Color(0xffE4E5E8),
              borderRadius: BorderRadius.circular(20)),
        ));
  }
}
