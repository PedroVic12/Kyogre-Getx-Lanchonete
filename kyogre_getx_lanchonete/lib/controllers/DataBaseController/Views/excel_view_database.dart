import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/Views/cadatro_cardapio._db.dart';

import '../db/cadastro_page_mongo.dart';

abstract class MenuRepository {
  Future<List<Product>> readMenuData();
}

class Product {
  final String name;
  final String category;
  final bool hasSubCategory;
  final String? subCategory;
  final double price1;
  final double? price2;
  final String? image;
  final String? ingredients;
  final Map<String, double>? additional;

  Product({
    required this.name,
    required this.category,
    required this.hasSubCategory,
    this.subCategory,
    required this.price1,
    this.price2,
    this.image,
    this.ingredients,
    this.additional,
  });
}

class ExcelMenuRepository extends MenuRepository {
  final String filePath;

  ExcelMenuRepository(this.filePath);

  @override
  Future<List<Product>> readMenuData() async {
    ByteData data = await rootBundle.load(filePath);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    print("Arquivo carregado");

    var sheet = excel.tables.keys.first;
    var table = excel.tables[sheet];
    var rows = table?.rows;

    for (var table in excel.tables.keys) {
      print(excel.tables[table]!.maxColumns);
      print(excel.tables[table]!.maxRows);
      for (var row in excel.tables[table]!.rows) {
        print('$row');
      }
    }
    List<Product> products = [];

    if (rows != null) {
      for (var row in rows) {
        products.add(Product(
          name: row[0].toString() ?? '',
          category: row[1].toString() ?? '',
          hasSubCategory: row[2]?.toString() == 'sim',
          subCategory: row[3].toString(),
          price1: double.parse(row[4].toString().replaceAll('R\$', '').trim()),
          price2:
              double.tryParse(row[5].toString().replaceAll('R\$', '').trim()),
          image: row[6].toString(),
          ingredients: row[7].toString(),
          additional: _parseAdditional(row[8]),
        ));
      }
    }

    return products;
  }

  static Map<String, double>? _parseAdditional(dynamic value) {
    if (value == null) return null;
    var additional = value.toString().split('R\$');
    Map<String, double> result = {};
    for (var i = 0; i < additional.length; i += 2) {
      result[additional[i].trim()] = double.parse(additional[i + 1].trim());
    }
    return result;
  }
}

// ignore: must_be_immutable
class ExcelReaderView extends StatelessWidget {
  final MenuRepository menuRepository = ExcelMenuRepository(
      '/home/pedrov/Documentos/GitHub/Kyogre-Getx-Lanchonete/kyogre_getx_lanchonete/lib/repository/citta/cardapio_template.xlsx');
  final List<String> columns = [
    'Nome',
    'Categoria',
    'Subcategoria',
    'Preço 1',
    'Preço 2',
    'Imagem',
    'Ingredientes',
    'Adicionais',
  ];
  String selectedColumn = 'Categoria';

  ExcelReaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Dados do Excel 2'),
      ),
      body: Center(
        child: ListView(
          children: [
            DropdownButton<String>(
              value: selectedColumn,
              onChanged: (value) {
                selectedColumn = value!;
                // Chamar método de atualização da lista baseado na nova coluna selecionada
              },
              items: columns.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(ProductRegistrationScreen());
                  },
                  child: Text("Pagina de cadastro")),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(DataBasePage());
                  },
                  child: Text("Mongo cadastro")),
            ),
          ],
        ),
      ),
    );
  }

  bool _filterByColumn(Product product) {
    switch (selectedColumn) {
      case 'Nome':
        return true; // Não aplicando filtro, todos os nomes são válidos
      case 'Categoria':
        return product.category == 'Tapioca';
      case 'Subcategoria':
        return product.hasSubCategory && product.subCategory != null;
      case 'Preço 1':
        return product.price1 > 20; // Exemplo de filtro
      case 'Preço 2':
        return product.price2 != null &&
            product.price2! > 0; // Exemplo de filtro
      case 'Imagem':
        return product.image != null && product.image!.isNotEmpty;
      case 'Ingredientes':
        return product.ingredients != null && product.ingredients!.isNotEmpty;
      case 'Adicionais':
        return product.additional != null && product.additional!.isNotEmpty;
      default:
        return true;
    }
  }
}
