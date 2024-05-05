import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_filters/data_filters.dart';

class DataFiltered extends StatefulWidget {
  const DataFiltered({super.key});

  @override
  State<DataFiltered> createState() => _DataFilteredState();
}

class _DataFilteredState extends State<DataFiltered> {
  @override
  List<List> data = [
    ['red', 'dog', 'small', 'bark', 'pet'],
    ['green', 'cat', 'medium', 'meow', 'stray'],
    ['blue', 'fish', 'large', 'swim', 'pet'],
    ['red', 'cat', 'small', 'meow', 'stray'],
    ['yellow', 'dog', 'large', 'bark', 'pet'],
    ['green', 'fish', 'medium', 'swim', 'pet'],
    ['blue', 'dog', 'medium', 'bark', 'pet'],
    ['red', 'fish', 'large', 'swim', 'pet'],
    ['yellow', 'cat', 'small', 'meow', 'pet'],
    ['green', 'dog', 'small', 'bark', 'pet'],
    ['blue', 'cat', 'large', 'meow', 'pet'],
    ['red', 'fish', 'medium', 'swim', 'stray'],
    ['yellow', 'dog', 'medium', 'bark', 'pet'],
    ['green', 'fish', 'large', 'swim', 'stray'],
    ['blue', 'cat', 'small', 'meow', 'pet'],
    ['red', 'dog', 'small', 'bark', 'stray'],
    ['yellow', 'cat', 'medium', 'meow', 'pet'],
    ['green', 'fish', 'small', 'swim', 'stray'],
    ['blue', 'dog', 'large', 'bark', 'pet'],
    ['pink', 'cat', 'medium', 'meow', 'pet'],
  ];

  List<String> titles = ['Color', 'Animal', 'Size', 'Sound', 'Type'];

  List<int>? filterIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animals App'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Filters',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          ///
          /// This widget builds filters
          DataFilters(
            data: data,

            /// pass your filter title here
            filterTitle: titles,

            /// enable animation
            showAnimation: true,

            /// get list of index of selected filter
            recent_selected_data_index: (List<int>? index) {
              setState(() {
                filterIndex = index;
              });
            },

            /// styling
            style: FilterStyle(
              buttonColor: Colors.green,
              buttonColorText: Colors.white,
              filterBorderColor: Colors.grey,
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Result / Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          /// Display your data
          ///
          ///
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, i) {
                /// filterIndex must be null initially
                if (filterIndex == null || filterIndex!.contains(i)) {
                  var produto = data[i];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          /// Display your data here
                          CupertinoListTile(
                            title: Text(
                              'Data ${i + 1}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Wrap(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var j = 0; j < data[i].length; j++)
                                Card(
                                  child: Text(
                                    '${titles[j]} :\t ${data[i][j]}\t\t\t\t\t\t',
                                  ),
                                ),

                              //DataTable

                              DataTable(
                                columns: titles
                                    .map((e) => DataColumn(label: Text(e)))
                                    .toList(),
                                rows: data
                                    .map((e) => DataRow(
                                        cells: e
                                            .map((e) =>
                                                DataCell(Text(e.toString())))
                                            .toList()))
                                    .toList(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
