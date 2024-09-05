import 'package:flutter/material.dart';

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

class ProductRegistrationScreen extends StatefulWidget {
  const ProductRegistrationScreen({super.key});

  @override
  _ProductRegistrationScreenState createState() =>
      _ProductRegistrationScreenState();
}

class _ProductRegistrationScreenState extends State<ProductRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();
  final TextEditingController price1Controller = TextEditingController();
  final TextEditingController price2Controller = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController additionalController = TextEditingController();

  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Nome', nameController),
            _buildTextField('Categoria', categoryController),
            _buildTextField('Subcategoria', subCategoryController),
            _buildTextField('Preço 1', price1Controller),
            _buildTextField('Preço 2', price2Controller),
            _buildTextField('Imagem', imageController),
            _buildTextField('Ingredientes', ingredientsController),
            //_buildTextField('Adicionais', additionalController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _registerProduct();
              },
              child: const Text('Cadastrar Produto'),
            ),
            const SizedBox(height: 20),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget _buildProductList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Produtos Cadastrados:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('Categoria: ${product.category}'),
            );
          },
        ),
      ],
    );
  }

  void _registerProduct() {
    final name = nameController.text;
    final category = categoryController.text;
    final hasSubCategory = subCategoryController.text.isNotEmpty;
    final subCategory = subCategoryController.text.isNotEmpty
        ? subCategoryController.text
        : null;
    final price1 = double.parse(price1Controller.text);
    final price2 = price2Controller.text.isNotEmpty
        ? double.parse(price2Controller.text)
        : null;
    final image = imageController.text.isNotEmpty ? imageController.text : null;
    final ingredients =
        ingredientsController.text.isNotEmpty ? imageController.text : null;
    final additional = additionalController.text.isNotEmpty
        ? _parseAdditional(additionalController.text)
        : null;

    final product = Product(
      name: name,
      category: category,
      hasSubCategory: hasSubCategory,
      subCategory: subCategory,
      price1: price1,
      price2: price2,
      image: image,
      ingredients: ingredients,
      additional: additional,
    );

    setState(() {
      products.add(product);
    });

    _clearFields();
  }

  Map<String, double> _parseAdditional(String additionalText) {
    Map<String, double> result = {};
    final items = additionalText.split(',');
    for (var item in items) {
      final parts = item.split(':');
      final name = parts[0].trim();
      final price = double.parse(parts[1].trim());
      result[name] = price;
    }
    return result;
  }

  void _clearFields() {
    nameController.clear();
    categoryController.clear();
    subCategoryController.clear();
    price1Controller.clear();
    price2Controller.clear();
    imageController.clear();
    ingredientsController.clear();
    additionalController.clear();
  }
}
