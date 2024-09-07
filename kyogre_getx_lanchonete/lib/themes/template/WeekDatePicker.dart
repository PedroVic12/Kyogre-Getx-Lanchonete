import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class WeekAvailabilityWidget extends StatefulWidget {
//   @override
//   _WeekAvailabilityWidgetState createState() => _WeekAvailabilityWidgetState();
// }

// class _WeekAvailabilityWidgetState extends State<WeekAvailabilityWidget> {
//   late DateRangePickerController _calendarController;
//   String _selectedDateMessage =
//       'Selecione uma data para ver os horários disponíveis.';

//   @override
//   void initState() {
//     super.initState();
//     _calendarController = DateRangePickerController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//         padding: const EdgeInsets.all(8),
//         child: SfDateRangePicker(
//           showTodayButton: true,
//           view: DateRangePickerView.month,
//           selectionMode: DateRangePickerSelectionMode.single,
//           allowViewNavigation: true,
//           controller: _calendarController,
//           onSelectionChanged: _onSelectionChanged,
//           monthViewSettings: DateRangePickerMonthViewSettings(
//             firstDayOfWeek: 1, // Segunda-feira
//             numberOfWeeksInView: 2,
//           ),
//           showActionButtons: false,
//           initialSelectedDate: _getStartOfWeek(DateTime.now()),
//           selectionColor: Colors.blue,
//           startRangeSelectionColor: Colors.blue,
//           endRangeSelectionColor: Colors.blue,
//           rangeSelectionColor: Colors.blue.withOpacity(0.3),
//         ),
//       ),
//       Center(
//         child: Text(_selectedDateMessage),
//       ),
//     ]);
//   }

//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     final selectedDate = args.value;
//     if (selectedDate != null) {
//       setState(() {
//         _selectedDateMessage = 'Data selecionada: ${selectedDate.toString()}';
//       });
//     } else {
//       setState(() {
//         _selectedDateMessage =
//             'Selecione uma data para ver os horários disponíveis.';
//       });
//     }
//   }

//   DateTime _getStartOfWeek(DateTime date) {
//     // Calcula o início da semana (segunda-feira)
//     final weekday = date.weekday;
//     final startOfWeek = date.subtract(Duration(days: weekday - 1));
//     return startOfWeek;
//   }
// }

class ShowCalendario extends StatefulWidget {
  const ShowCalendario({Key? key}) : super(key: key);

  @override
  _ShowCalendarioState createState() => _ShowCalendarioState();
}

class _ShowCalendarioState extends State<ShowCalendario> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              // Show the date picker
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: Colors.blue,
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      datePickerTheme: DatePickerThemeData(
                        backgroundColor: Colors.grey[800],
                        headerHelpStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        dayStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        weekdayStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                        headerBackgroundColor: Colors.blueGrey,
                        yearStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      textTheme: TextTheme(
                        bodyMedium: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: child!,
                  );
                },
              ).then((selectedDate) {
                if (selectedDate != null && selectedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                }
              });
            },
            child: const Text('Open Date Picker'),
          ),
          if (_selectedDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Data Selecionada: ${_formatDate(_selectedDate!)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final weekdays = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo'
    ];
    final formattedDate =
        '${weekdays[date.weekday - 1]}, ${date.day}/${date.month}/${date.year}';
    return formattedDate;
  }
}
