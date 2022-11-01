//import 'dart:math';
//import 'dart:ui';

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_input.dart';
import '../widgets/custom_label.dart';
import '../widgets/custom_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    titulo: 'Menssenger',
                  ),
                  _Form(),
                  Label(
                    ruta: "register",
                    subtitulo: "No Tienes una cuenta?",
                    titulo: "Registrate ahora",
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
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
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
            //text: 'Ingrese',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk!) {
                      Navigator.pushReplacementNamed(context, "usario");
                    } else {
                      // ignore: use_build_context_synchronously
                      mostrarAlerta(context, "Login Incorrecto",
                          "Revise sus credenciales nuevamente");
                    }
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
