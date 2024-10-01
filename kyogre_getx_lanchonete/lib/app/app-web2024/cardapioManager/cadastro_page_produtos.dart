import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _adicionaisController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _image != null) {
      var uri = Uri.parse('http://seu_servidor_django/api/produto_cardapio/');
      var request = http.MultipartRequest('POST', uri)
        ..fields['nome'] = _nomeController.text
        ..fields['preco'] = _precoController.text
        ..fields['descricao'] = _descricaoController.text
        ..fields['adicionais'] = _adicionaisController.text
        ..files.add(await http.MultipartFile.fromPath('imagem', _image!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto cadastrado com sucesso!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar produto.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produto')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preços (separe por vírgula)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os preços';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _adicionaisController,
                decoration: InputDecoration(labelText: 'Adicionais (separe por vírgula)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Selecionar Imagem'),
              ),
              if (_image != null) ...[
                SizedBox(height: 16),
                Image.file(_image!, height: 200),
              ],
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Cadastrar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}