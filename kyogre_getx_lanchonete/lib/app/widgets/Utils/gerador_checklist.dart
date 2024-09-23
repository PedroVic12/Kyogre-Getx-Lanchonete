import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

final gemini = Gemini.instance;

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // JSON com as tarefas fornecidas
  List<Map<String, dynamic>> tasks = [
    {
      "Prioridade": "Alta",
      "Tarefa": "Dash + Leilão de vendas (React, Ionic, Laravel)",
      "Categoria": "MVP",
      "Prazo": "2024-09-23T03:00:00.000Z",
      "Status": false,
      "Complexidade": 0
    },
    {
      "Prioridade": "Alta",
      "Tarefa": "Crud Flutter + SQLite | MongoDB | Firestore",
      "Categoria": "Estudos",
      "Prazo": "2024-09-23T03:00:00.000Z",
      "Status": false,
      "Complexidade": 0
    },
    {
      "Prioridade": "Alta",
      "Tarefa": "3 Landing Pages Templates (Google Analytics, Maps, etc)",
      "Categoria": "MVP",
      "Prazo": "2024-09-23T03:00:00.000Z",
      "Status": false,
      "Complexidade": 0
    },
    {
      "Prioridade": "Alta",
      "Tarefa":
          "Chatbot Delivery Ruby App + Gestão pedidos + Cardapio cliente customizavel + Banco de dados para cada cliente",
      "Categoria": "MVP",
      "Prazo": "2024-09-23T03:00:00.000Z",
      "Status": false,
      "Complexidade": 0
    },
    {
      "Prioridade": "Média",
      "Tarefa": "Gerador Checklist Flutter + Gemini + JSON",
      "Categoria": "Tech & Programação",
      "Prazo": "2024-09-23T03:00:00.000Z",
      "Status": false,
      "Complexidade": 0
    },
    {
      "Prioridade": "Média",
      "Tarefa": "C3PO Voice Assistant HTML Flask Python",
      "Categoria": "Tech & Programação",
      "Prazo": "2024-09-23T03:00:00.000Z",
      "Status": false,
      "Complexidade": 0
    },
    {
      "Prioridade": "Alta",
      "Tarefa": "Rede social Flutter + Crud Usuarios",
      "Categoria": "MVP",
      "Prazo": "2024-09-24T03:00:00.000Z",
      "Status": false,
      "Complexidade": 1
    },
    {
      "Prioridade": "Média",
      "Tarefa": "PandaPower - Artigo 2 - Leitura Tese, notebook, CA aplicado",
      "Categoria": "Faculdade",
      "Prazo": "2024-09-25T03:00:00.000Z",
      "Status": false,
      "Complexidade": 2
    },
    {
      "Prioridade": "Média",
      "Tarefa": "Arduino, Python, Pandapower",
      "Categoria": "Tech & Programação",
      "Prazo": "2024-09-25T03:00:00.000Z",
      "Status": true,
      "Complexidade": 2
    },
    {
      "Prioridade": "Alta",
      "Tarefa": "APP Garçom, Cardápio Interativo, PDV Flutter",
      "Categoria": "MVP",
      "Prazo": "2024-09-26T03:00:00.000Z",
      "Status": false,
      "Complexidade": 3
    },
    {
      "Prioridade": "Média",
      "Tarefa": "Chatbot Agendamento com serviços google",
      "Categoria": "MVP",
      "Prazo": "2024-09-26T03:00:00.000Z",
      "Status": true,
      "Complexidade": 3
    },
    {
      "Prioridade": "Alta",
      "Tarefa":
          "Apresentação RCE Evolution (3 vídeos semanais) + PDF formatado",
      "Categoria": "Faculdade",
      "Prazo": "2024-10-14T03:00:00.000Z",
      "Status": false,
      "Complexidade": 21
    },
    {
      "Prioridade": "Alta",
      "Tarefa":
          "Chatbot Groundon Delivery inteligente. \"Qual a promoção do Big Mac Hoje?\" Vai na base de dados, com o ID do produto, pega as informaçoes e manda no cardapio digiatal www.cardapio.com/ItemPage?id=ProdutoEscolhido",
      "Categoria": "MVP",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "10 Leis Circuitos",
      "Categoria": "Estudos",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "Eletromagnetismo (Lista e provas antigas)",
      "Categoria": "Estudos",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "Animações Flutter",
      "Categoria": "Estudos",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "FIFA DATASET",
      "Categoria": "Estudos",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "PREMIER LEAGUE DATASET",
      "Categoria": "Estudos",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa":
          "CIRCUITOS ELETRICOS CC - Exercicios + provas + minicruso com teoria e experimento",
      "Categoria": "Faculdade",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "Django Rayquaza + CRUD e Laravel + Crud e Filament Crud",
      "Categoria": "MVP",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "Hand Gesture PyAutoGUI Big Linux",
      "Categoria": "Tech & Programação",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Baixa",
      "Tarefa": "Dashbaord em Python e Laravel Filament",
      "Categoria": "MVP",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Média",
      "Tarefa": "IA Generativa  (Sistemas Agentes)",
      "Categoria": "Tech & Programação",
      "Prazo": "Sem prazo",
      "Status": true,
      "Complexidade": "Sem prazo definido"
    },
    {
      "Prioridade": "Alta",
      "Tarefa":
          "Dashboard Marketing: Previsão de vendas em python, camapnhas de marketing com landing pages, Top 1 na busca do google sem trafego paga, Clientes no raio de amostra usando google maps (comprovando o metodo)",
      "Categoria": "MVP",
      "Prazo": "2024-09-26T03:00:00.000Z",
      "Status": false,
      "Complexidade": 3
    },
    {
      "Prioridade": "",
      "Tarefa": "YOLO COMPUTER VISION SOCCER",
      "Categoria": "Tech & Programação",
      "Prazo": "Sem prazo",
      "Status": false,
      "Complexidade": "Sem prazo definido"
    }
  ];

  // Estado para controlar a conclusão das tarefas
  Map<int, bool> taskCompletion = {};
  Map<int, String> taskDescriptions = {}; // Para armazenar descrições geradas

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Inicializando o estado das tarefas como não completas (false)
    for (var i = 0; i < tasks.length; i++) {
      taskCompletion[i] = tasks[i]["Status"];
      taskDescriptions[i] = "Carregando descrição...";
      fetchTaskDescription(i, tasks[i]["Tarefa"]);
    }
  }

  // Função para enviar tarefa para o Gemini e receber uma sugestão
  Future<void> fetchTaskDescription(int taskIndex, String taskName) async {
    try {
      // Enviando o nome da tarefa para o Gemini
      final response = await gemini.chat([
        Content(parts: [
          Parts(
              text:
                  "Faça uma descrição simples de ate no maximo 50 palavras  de como iniciar a tarefa ${taskName} de a resposta em frase unica")
        ], role: 'user'),
      ]);

      // Verificando se houve resposta
      final botMessage =
          response?.output ?? 'Não foi possível obter uma sugestão';

      // Limitando a descrição a 50 palavras
      final limitedDescription =
          botMessage.split(' ').take(100).join(' ') + '...';

      // Atualizando o estado com a descrição recebida
      setState(() {
        taskDescriptions[taskIndex] = limitedDescription;
      });
    } catch (error) {
      print('Erro ao obter descrição: $error');
      setState(() {
        taskDescriptions[taskIndex] = 'Erro ao obter descrição da tarefa';
      });
    }
  }

  // Função para gerar a lista de tarefas para cada categoria com descrição
  List<Widget> _buildChecklist(String category) {
    List<Map<String, dynamic>> filteredTasks = tasks
        .asMap()
        .entries
        .where((entry) => entry.value['Categoria'] == category)
        .map((entry) => {
              "index": entry.key,
              "tarefa": entry.value['Tarefa'],
              "status": entry.value['Status'],
              "prioridade": entry.value['Prioridade'],
              "descricao":
                  taskDescriptions[entry.key] ?? "Descrição não disponível"
            })
        .toList();

    return filteredTasks.map((task) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: CheckboxListTile(
              title: Text(
                task['tarefa'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: task['prioridade'] == "Alta"
                        ? Colors.red
                        : Colors.black),
              ),
              subtitle: CustomText(
                text: task['descricao'],
              ),
              value: taskCompletion[task['index']],
              onChanged: (bool? value) {
                setState(() {
                  taskCompletion[task['index']] = value!;
                });
              },
            ),
          ),
          Divider(), // Separador visual entre tarefas
        ],
      );
    }).toList();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas com Descrições Geradas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'MVP'),
            Tab(text: 'Estudos'),
            Tab(text: 'Tech & Programação'),
            Tab(text: 'Faculdade'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Checklist para MVP
          ListView(
            children: _buildChecklist('MVP'),
          ),
          // Checklist para Estudos
          ListView(
            children: _buildChecklist('Estudos'),
          ),
          // Checklist para Tech & Programação
          ListView(
            children: _buildChecklist('Tech & Programação'),
          ),
          // Checklist para Faculdade
          ListView(
            children: _buildChecklist('Faculdade'),
          ),
        ],
      ),
    );
  }
}
