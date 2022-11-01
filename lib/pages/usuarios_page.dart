import 'package:chat/models/usuarios.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuario = [
    Usuario(uid: "1", nombre: "Maury", email: "test1@gmail.com", online: false),
    Usuario(uid: "2", nombre: "Juan", email: "test2@gmail.com", online: true),
    Usuario(uid: "3", nombre: "Pedro", email: "test3@gmail.com", online: true),
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            usuario.nombre, textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
            // textAlign: TextAlign.center,
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              ),
              onPressed: () {
                //  TODO //desconectar del socket
                AuthService.deleteToken();
                Navigator.pushReplacementNamed(context, "login");
              }),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              //child: Icon(
              //Icons.offline_bolt,
              //color: Colors.red,
              // ),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuario,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue,
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuarioTile(usuario[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuario.length);
  }

  ListTile _usuarioTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuario() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
