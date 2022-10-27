import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  //const CustomInput({Key? key}) : super(key: key);
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboard;
  final bool isPassword;

  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.keyboard = TextInputType.text,
      this.isPassword = false});
  //bool? ispassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboard,
        obscureText: this.isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeholder),
      ),
    );
  }
}
