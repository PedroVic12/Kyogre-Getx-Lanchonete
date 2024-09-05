// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

// import '../../../views/Pages/DashBoard/Pedido/CardPedido.dart';
// import '../../../views/Pages/DashBoard/Pedido/FilaDeliveryController.dart';
// import '../../../views/Pages/DashBoard/Pedido/PedidoController.dart';
// import 'NightWolfAppBar.dart';

// class DashBoardKanban extends StatelessWidget {
//   final KanbanController _kanbanController = Get.put(KanbanController());

//   final List<Color> coresColunas = [
//     Colors.red,
//     Colors.orange.shade300,
//     Colors.green,
//   ];

//   DashBoardKanban({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const NightWolfAppBar(),
//         body: SizedBox(
//           height: 1200,
//           child: Row(
//             children: [
//               _buildKanbanColumn('Pedidos em Produção',
//                   _kanbanController.columns['analise']!, coresColunas[0], 0),
//               _buildKanbanColumn('Pedidos para entrega',
//                   _kanbanController.columns['entrega']!, coresColunas[1], 1),
//               _buildKanbanColumn('Pedidos finalizados',
//                   _kanbanController.columns['concluidos']!, coresColunas[2], 2),
//             ],
//           ),
//         ));
//   }

//   Widget _buildKanbanColumn(
//       String title, List<ItemTrabalho> tasks, Color color, int index) {
//     return KanbanColumn(
//       title: title,
//       tasks: tasks,
//       color: color,
//       index: index,
//     );
//   }
// }

// //! Coluna
// class KanbanColumn extends StatefulWidget {
//   final String title;
//   final List<ItemTrabalho> tasks;
//   final Color color;
//   final int index;

//   const KanbanColumn({
//     super.key,
//     required this.title,
//     required this.tasks,
//     required this.color,
//     required this.index,
//   });

//   @override
//   State<KanbanColumn> createState() => _KanbanColumnState();
// }

// class _KanbanColumnState extends State<KanbanColumn> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   final PedidoController pedidoController = Get.find<PedidoController>();
//   final FilaDeliveryController filaDeliveryController =
//       Get.find<FilaDeliveryController>();

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(KanbanController()); // Obtenha o controlador

//     final TodosPedidos =
//         filaDeliveryController.FILA_PEDIDOS.value.todosPedidos();
//     print('Todos Pedidos: $TodosPedidos');
//     final totalPedidos =
//         filaDeliveryController.FILA_PEDIDOS.value.tamanhoFila();

//     return Expanded(
//       child: Container(
//         color: widget.color,
//         child: DragTarget(
//           builder: (context, candidateData, rejectedData) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CustomText(
//                       text: '${widget.title} -  ${widget.index}',
//                       weight: FontWeight.bold,
//                       size: 24),
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                 ),
//                 const SizedBox(height: 10.0),

//                 const CardPedido(
//                   status_pedido: "PRODUÇÃO",
//                 ),

//                 // Lista de itens de trabalho
//                 const Divider(),
//                 Obx(() => Column(
//                       children: controller
//                           .columns[controller.columnKeys[widget.index]]!
//                           .map((item) => CardItemDeTrabalho(
//                                 titulo: item.title,
//                                 coluna: widget.index,
//                               ))
//                           .toList(),
//                     )),
//               ],
//             );
//           },
//           onAcceptWithDetails: (Map data) {
//             final colunaOrigem = controller.columnKeys[data['column']];
//             final itemTitulo = data['title'];

//             print('\nColuna: $colunaOrigem');
//             print('Item: $itemTitulo');

//             final itemIndex = controller.columns[colunaOrigem]!
//                 .indexWhere((item) => item.title == itemTitulo);

//             if (itemIndex != -1) {
//               final item =
//                   controller.columns[colunaOrigem]!.removeAt(itemIndex);
//               controller.columns[controller.columnKeys[widget.index]]!
//                   .add(item);
//             }

//             print('Coluna Destino: ${controller.columnKeys[widget.index]}');
//           },
//         ),
//       ),
//     );
//   }
// }

// //!Controller
// class KanbanController extends GetxController {
//   Map<String, RxList<ItemTrabalho>> columns = {};

//   List<String> columnKeys =
//       []; // Mantenha as chaves das colunas para referência

//   @override
//   void onInit() {
//     super.onInit();

//     //Arrays de trabalho
//     columns['analise'] = <ItemTrabalho>[].obs;
//     columns['entrega'] = <ItemTrabalho>[].obs;
//     columns['concluidos'] = <ItemTrabalho>[].obs;

//     // Adicionar as chaves das colunas
//     columnKeys.addAll(columns.keys);

//     // Adicionar itens às colunas
//     columns['analise']!.add(ItemTrabalho(title: 'APP KYOGRE UI'));
//     columns['analise']!.add(ItemTrabalho(title: 'CAMORIM PROJECTS'));
//     columns['concluidos']!.add(ItemTrabalho(title: 'Machine Learning Python'));
//   }

//   void adicionarTarefa(int coluna, ItemTrabalho item) {
//     final columnKey = columnKeys[coluna];
//     columns[columnKey]!.add(item);
//   }

//   void removerItem(int coluna, String titulo) {
//     final columnKey = columnKeys[coluna];
//     final itemIndex =
//         columns[columnKey]!.indexWhere((item) => item.title == titulo);
//     if (itemIndex != -1) {
//       columns[columnKey]!.removeAt(itemIndex);
//     }
//   }

//   void trocarItem(String origem, String destino, String itemTitle) {
//     final origemColuna = columns[origem];
//     final destinoColuna = columns[destino];

//     final itemIndex =
//         origemColuna?.indexWhere((item) => item.title == itemTitle);

//     if (itemIndex != -1) {
//       final item = origemColuna?.removeAt(itemIndex!);
//       destinoColuna!.add(item!);
//     }
//   }
// }

// //!Models

// class Task {
//   String title;

//   Task({required this.title});
// }

// class ColunaKanban {
//   final String title;
//   final List<Task> tasks;

//   ColunaKanban({
//     required this.title,
//     required this.tasks,
//   });
// }

// class ItemTrabalho {
//   final String title;
//   late String description;
//   late String time;
//   late String tipe;

//   ItemTrabalho(
//       {required this.title,
//       this.description = '',
//       this.time = '',
//       this.tipe = ''});
// }

// class CardItemDeTrabalho extends StatelessWidget {
//   final controller = Get.find<KanbanController>(); // Obtenha o controlador

//   final String titulo;
//   final int coluna;
//   CardItemDeTrabalho({
//     super.key,
//     required this.titulo,
//     required this.coluna,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Draggable<Map>(
//       // Os dados são o valor que este Draggable armazena.
//       data: {
//         'column': coluna,
//         'title': titulo
//       }, // Identificação do item sendo arrastado
//       feedback: const Card(
//           color: Colors.greenAccent,
//           child: Padding(
//             padding: EdgeInsets.all(48.0),
//             child: Column(
//               children: [
//                 Text('movendo...'),
//                 Icon(
//                   Icons.directions_run,
//                   size: 32,
//                 ),
//               ],
//             ),
//           )),
//       childWhenDragging: Container(
//         height: 100.0,
//         width: 100.0,
//         color: Colors.red,
//         child: const Center(),
//       ),

//       child: Container(
//         child: Card(
//             color: Colors.lightGreenAccent,
//             child: CupertinoListTile(
//                 leading: CircleAvatar(
//                   child: CustomText(
//                     text: coluna.toString(),
//                     color: Colors.white,
//                   ),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(
//                     Icons.delete,
//                     size: 20,
//                   ),
//                   onPressed: () {
//                     controller.removerItem(coluna, titulo);
//                   },
//                 ),
//                 title: CustomText(
//                   text: titulo,
//                   size: 12,
//                   weight: FontWeight.bold,
//                 ))),
//       ),
//     );
//   }
// }
