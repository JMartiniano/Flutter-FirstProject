// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando Transferência"),
      ),
      body: Column(
        children: <Widget>[
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: "Numero da conta",
            dica: "0000",
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: "Valor",
            dica: "0.00",
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () {
              _criarTransferencia();
            },
            child: Text('Criar'),
          ),
        ],
      ),
    );
  }
}

void _criarTransferencia() {
  final int conta = int.tryParse(_controladorCampoNumeroConta.text);
  final double valor = double.tryParse(_controladorCampoValor.text);

  if (conta != null && valor != null) {
    final transTeste = Transferencia(valor, conta);
    debugPrint('$transTeste');
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CardTransferencia(
              Transferencia('Valor da transferência 3', 'Conta usada')),
          CardTransferencia(
              Transferencia('Valor da transferência 2', 'Conta usada')),
          CardTransferencia(
              Transferencia('Valor da transferência 1', 'Conta usada')),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
    );
  }
}

class CardTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  CardTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.conta.toString()),
      ),
    );
  }
}

class Transferencia {
  final String valor;
  final String conta;

  Transferencia(this.valor, this.conta);
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor({
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
