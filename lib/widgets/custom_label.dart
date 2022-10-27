import 'package:flutter/material.dart';

//import '../pages/register_page.dart';

class Label extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final String ruta;
  final String titulo;
  final String subtitulo;
  const Label(
      {super.key,
      required this.ruta,
      required this.titulo,
      required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          this.subtitulo,
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w200),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Text(
            this.titulo,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, ruta);
          },
        )
      ],
    );
  }
}
