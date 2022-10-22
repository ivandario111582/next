import 'package:flutter/material.dart';
import 'package:next_project/model/estadoDocumento.dart';
import 'package:next_project/utils/utils.dart';
import 'package:next_project/widgets/widgets.dart';
import 'package:next_project/providers/providers.dart';

class JustificationScreen extends StatefulWidget {
  final Map<String, dynamic> receivedMap;
  JustificationScreen({required this.receivedMap});
  @override
  _JustificationScreenState createState() => _JustificationScreenState();
}

class _JustificationScreenState extends State<JustificationScreen> {
  final estadoDocumentoProvider = new EstadoDocumentoProvider();

  String selectValue = 'Local cerrado';
  List<DropdownMenuItem<String>> lista = [];
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 10), onPrimary: Colors.green);
  @override
  void initState() {
    super.initState();
    getOpcionesDropdwon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyleApp.getAppBarSimple(context),
        body: PageBackground(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              crearOrganization(context),
              SizedBox(height: 10),
              _crearEtiqueta(),
              SizedBox(height: 5),
              clientHeader(
                  context,
                  widget.receivedMap["codCliente"],
                  widget.receivedMap["razonSocial"],
                  widget.receivedMap["ruc"],
                  widget.receivedMap["direccion"]),
              SizedBox(height: 5),
              _crearDropdown(),
              SizedBox(height: 5),
              _textFieldarea(),
              SizedBox(height: 5),
              _buttonSend()
            ],
          ),
        ));
  }

  Widget _crearEtiqueta() {
    return Container(
        padding: EdgeInsets.all(5.0),
        width: 100,
        decoration: new BoxDecoration(
          color: Color(Constants.colorGreyInf),
        ),
        child: Row(children: <Widget>[
          Text(' Justificar Pedido ', style: TextStyle(color: Colors.white)),
        ]));
  }

  Widget _crearDropdown() {
    return Row(
      children: <Widget>[
        //Icon(Icons.select_all),
        SizedBox(width: 30.0),
        DropdownButton(
          value: selectValue,
          items: lista,
          style: StyleApp.getStyleTitle(14),
          onChanged: (opt) {
            setState(() {
              selectValue = opt.toString();
            });
          },
        )
      ],
    );
  }

  void getOpcionesDropdwon() async {
    List<EstadoDocumento> _estadoDocumentos =
        await estadoDocumentoProvider.getListEstadoDocumento(context,'1/NRV');
    _estadoDocumentos.forEach((poder) {
      if (poder.nomEstado.toString().trim() != '') {
        lista.add(DropdownMenuItem(
          child: Text(poder.nomEstado.toString().trim()),
          value: poder.nomEstado.toString().trim(),
        ));
      }
    });
    setState(() {
      lista = lista;
    });
  }

  Widget _textFieldarea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
          maxLines: 4,
          keyboardType: TextInputType.text,
          decoration: InputDecoration()),
    );
  }

  Widget _buttonSend() {
    return ElevatedButton(
      style:    ElevatedButton.styleFrom(
                primary: Color(Constants.colorOrange),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      onPressed: () {},
      child: const Text('Enviar'),
    );
  }
}
