import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'WeekDatePicker.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productDescription;
  final double productPrice;
  final bool isSelected;

  final VoidCallback
      onTap; // Adicione uma função para ser chamada quando o card for tocado

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Adicione a funcionalidade de toque
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.blueGrey.shade200,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  productImage,
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      productDescription,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${productPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Horario {
  final String hora;
  final bool isDisponivel;

  Horario({required this.hora, required this.isDisponivel});
}

class AgendamentoController extends GetxController {
  var diaSelecionado = ''.obs;
  var nomePet = ''.obs;
  var horarioSelecionado = <String>[].obs; // Pode ser uma lista de horários
  var servicosSelecionados = <String>[].obs; // Lista de serviços selecionados

  final horarios = <String, List<Horario>>{
    "Segunda": [
      Horario(hora: '09:00', isDisponivel: false),
      Horario(hora: '10:00', isDisponivel: true),
      Horario(hora: '11:00', isDisponivel: false),
      Horario(hora: '12:00', isDisponivel: false),
      Horario(hora: '11:00', isDisponivel: false),
      Horario(hora: '15:00', isDisponivel: true),
    ],
    "Terça": [
      Horario(hora: '09:00', isDisponivel: false),
      Horario(hora: '10:00', isDisponivel: true),
      Horario(hora: '11:00', isDisponivel: false),
      Horario(hora: '12:00', isDisponivel: false),
      Horario(hora: '15:00', isDisponivel: true),
    ],
    "Quarta": [
      Horario(hora: '09:00', isDisponivel: false),
      Horario(hora: '10:00', isDisponivel: true),
      Horario(hora: '11:00', isDisponivel: false),
      Horario(hora: '12:00', isDisponivel: false),
      Horario(hora: '14:00', isDisponivel: true),
      Horario(hora: '16:00', isDisponivel: false),
    ],
    "Quinta": [
      Horario(hora: '09:00', isDisponivel: false),
      Horario(hora: '10:00', isDisponivel: true),
      Horario(hora: '11:00', isDisponivel: false),
      Horario(hora: '12:00', isDisponivel: false),
      Horario(hora: '14:00', isDisponivel: true),
      Horario(hora: '15:00', isDisponivel: false),
    ],
    "Sexta": [
      Horario(hora: '09:00', isDisponivel: false),
      Horario(hora: '10:00', isDisponivel: true),
      Horario(hora: '11:00', isDisponivel: false),
      Horario(hora: '12:00', isDisponivel: false),
      Horario(hora: '15:00', isDisponivel: false),
    ],
    // Adicione mais dias e horários conforme necessário
  }.obs;

  double get total {
    // Exemplo de cálculo total com base em preços fictícios
    double precoServico = 50.0; // Preço por serviço selecionado
    return servicosSelecionados.length * precoServico;
  }

  void selecionarDia(String dia) {
    diaSelecionado.value = dia;
  }

  void selecionarHorario(String horario) {
    if (horarioSelecionado.contains(horario)) {
      horarioSelecionado.remove(horario);
    } else {
      horarioSelecionado.add(horario);
    }
  }

  void selecionarServico(String servico) {
    if (servicosSelecionados.contains(servico)) {
      servicosSelecionados.remove(servico);
    } else {
      servicosSelecionados.add(servico);
    }
  }
}

class AgendamentoPage extends StatefulWidget {
  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final AgendamentoController controller = Get.put(AgendamentoController());
  String selectedProduct = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de Horário'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ShowCalendario(),
          // Container(
          //   child: WeekAvailabilityWidget(),
          //   height: 400,
          // ),
          _buildDiaDaSemanaSelection(),
          const SizedBox(height: 16.0),
          _buildNomePetField(),
          const SizedBox(height: 16.0),
          _buildProductCarousel(),
          const SizedBox(height: 16.0),
          Obx(() {
            if (controller.diaSelecionado.value.isEmpty) {
              return const Center(
                  child: Text('Selecione um dia para ver os horários'));
            }

            final horarios =
                controller.horarios[controller.diaSelecionado.value] ?? [];
            return SizedBox(
              height: 60, // Define a altura fixa para a linha de botões
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: horarios
                    .map((horario) => _buildHorarioButton(horario))
                    .toList(),
              ),
            );
          }),
          const SizedBox(height: 16.0),
          cardResumoAgendamento(),
          ElevatedButton(
            onPressed: () {
              if (controller.diaSelecionado.value.isNotEmpty &&
                  controller.nomePet.value.isNotEmpty &&
                  controller.horarioSelecionado.value.isNotEmpty) {
                Get.snackbar(
                  'Agendamento confirmado',
                  'Seu agendamento foi marcado para ${controller.horarioSelecionado.value} no dia ${controller.diaSelecionado.value} para o pet ${controller.nomePet.value}.',
                  backgroundColor: Colors.green,
                );
              } else {
                Get.snackbar(
                  'Preencha todos os campos',
                  'Por favor, selecione um dia, informe o nome do pet e escolha um horário antes de confirmar o agendamento.',
                  backgroundColor: Colors.red,
                );
              }
            },
            child: const Text('Confirmar Agendamento'),
          ),
        ],
      ),
    );
  }

  Widget _buildDiaDaSemanaSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...[
          "Segunda",
          "Terça",
          "Quarta",
          "Quinta",
          "Sexta"
        ] // Adicione mais dias conforme necessário
            .map((dia) => ElevatedButton(
                  onPressed: () => controller.selecionarDia(dia),
                  child: Text(dia),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: controller.diaSelecionado.value == dia
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildNomePetField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Nome do Pet',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          controller.nomePet.value = value;
        },
      ),
    );
  }

  Widget _buildHorarioButton(Horario horario) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ElevatedButton(
        onPressed: horario.isDisponivel
            ? () => controller.selecionarHorario(horario.hora)
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: controller.horarioSelecionado.contains(horario.hora)
              ? Colors.deepOrange // Cor quando o horário está selecionado
              : horario.isDisponivel
                  ? Colors.green
                  : Colors.grey,
        ),
        child: Text(horario.hora),
      ),
    );
  }

  Widget _buildProductCarousel() {
    return InkWell(
      onTap: () {
        print("Item selecionado");
      },
      child: Container(
        height: 220, // Define a altura fixa para o carousel
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ProductCard(
              productName: 'Corte de Cabelo',
              productImage:
                  'https://blog.oceane.com.br/wp-content/uploads/2024/02/undercut.jpg',
              productDescription: 'Maquina, Tesoura e Relaxamento',
              productPrice: 50.0,
              isSelected: selectedProduct == 'Corte de Cabelo',
              onTap: () {
                setState(() {
                  selectedProduct = 'Corte de Cabelo';
                });
              },
            ),
            ProductCard(
              productName: 'Progressiva e Hidratação',
              productImage:
                  'https://www.loreal-paris.com.br/-/media/project/loreal/brand-sites/oap/americas/br/artigos-2024/cabelo/hair-care/escova-progressiva/escova-progressiva.jpg',
              productDescription: 'Marroquina com formol',
              productPrice: 120.0,
              isSelected: selectedProduct == 'Progressiva e Hidratação',
              onTap: () {
                setState(() {
                  selectedProduct = 'Progressiva e Hidratação';
                });
              },
            ),
            ProductCard(
              productName: 'Massagem, Manicure e Pedicure',
              productImage:
                  'https://toppng.com/uploads/preview/beauty-parlour-manicure-nail-pedicure-imagens-de-manicure-em-11563128589cnhkxmkhjj.png',
              productDescription:
                  'Pé e Mão  com esfoliação e massagem relaxante',
              productPrice: 10.0,
              isSelected: selectedProduct == 'Massagem, Manicure e Pedicure',
              onTap: () {
                setState(() {
                  selectedProduct = 'Massagem, Manicure e Pedicure';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardResumoAgendamento() {
    return Obx(() {
      final servicos = controller.servicosSelecionados.toList().join(', ');
      final total = controller.total;

      print("Serviços: $servicos ($selectedProduct) e Total= $total");

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nome do Pet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      controller.nomePet.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dia Selecionado',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      controller.diaSelecionado.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Horários Selecionados',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      controller.horarioSelecionado.join(', '),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Serviços Selecionados',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      selectedProduct!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total a Comprar:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
