import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = FocusNode();
  List<ChatMessage> _messages = [];
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              // ignore: sort_child_properties_last
              child: const Text(
                "Te",
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Maury Rodriguez",
              style: TextStyle(color: Colors.black87, fontSize: 10),
            ),
          ],
        ),
        elevation: 1,
      ),
      body: Container(
        child: Column(children: [
          Flexible(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            color: Colors.white,
            // height: 50,
            child: _inputChat(),
          )
        ]),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: _textController,
              onFieldSubmitted: _handleSubmit,
              onChanged: (texto) {
                setState(() {
                  if (texto.trim().length > 0) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(hintText: "enviar mensaje"),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text.trim())
                        : null)
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(_textController.text.trim())
                              : null),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = new ChatMessage(
        uuid: "123",
        texto: texto,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // ignore: todo
    //TODO OFF DEL SOCKET
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
