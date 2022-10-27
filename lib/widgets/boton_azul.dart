import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const BotonAzul({
    Key? key,
    required this.text,
    required this.onPressed,
    //required Null Function() onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ElevatedButton.styleFrom(elevation: 2, shape: const StadiumBorder()),
      onPressed: this.onPressed, //
      // onpressed(),
      child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
              child: Text(
            this.text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ))),
    );
  }
}
