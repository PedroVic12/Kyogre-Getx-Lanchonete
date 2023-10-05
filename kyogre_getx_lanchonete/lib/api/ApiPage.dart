import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/api/Raichu.dart';

class ExampleWidget extends StatelessWidget {
  final RaichuApi api = RaichuApi();

  Future<void> _performApiOperations() async {
    // Create
    await api.createData('/path', {'key': 'value'});

    // Read
    final data = await api.readData('/path');
    print('Data: $data');

    // Update
    await api.updateData('/path', {'key': 'newValue'});

    // Delete
    await api.deleteData('/path');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _performApiOperations,
      child: Text('Perform API Operations'),
    );
  }
}
