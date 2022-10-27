//import 'dart:math';
//import 'dart:ui';

import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_input.dart';
import '../widgets/custom_label.dart';
import '../widgets/custom_logo.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    titulo: 'Registro',
                  ),
                  _Form(),
                  Label(
                    ruta: "login",
                    subtitulo: 'Tienes una  cuenta ?',
                    titulo: "Ingresa con tu cuenta",
                  ),
                  const Text(
                    "Acepta terminos y condiciones",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  // _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nombCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.perm_identity,
              placeholder: "nombre",
              keyboard: TextInputType.text,
              textController: nombCtrl),
          CustomInput(
              icon: Icons.email_outlined,
              placeholder: "correo",
              keyboard: TextInputType.emailAddress,
              textController: emailCtrl),

          //ispassword: true),
          CustomInput(
              icon: Icons.lock_outline,
              placeholder: "password",
              //keyboard: TextInputType.passCtrl,
              textController: passCtrl,
              isPassword: true),
          BotonAzul(
            text: "ingrese",
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          )
          // CustomInput(),

          //const TextField(),
          //const TextField(),
          //  SizedBox(
          // height: 10,
          // ),
        ],
      ),
    );
  }
}
