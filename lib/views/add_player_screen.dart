import 'package:flutter/material.dart';
import '../view_models/player_view_model.dart';
import '../models/player_model.dart';
import 'package:provider/provider.dart';

class AddPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddPlayerForm(),
      ),
    );
  }
}

class AddPlayerForm extends StatefulWidget {
  @override
  _AddPlayerFormState createState() => _AddPlayerFormState();
}

class _AddPlayerFormState extends State<AddPlayerForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sectorController = TextEditingController();
  final _subsectorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _sectorController,
            decoration: InputDecoration(labelText: 'Sector'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a sector';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _subsectorController,
            decoration: InputDecoration(labelText: 'Subsector (if applicable)'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final player = Player(
                  id: DateTime.now().toString(),
                  name: _nameController.text,
                  sector: _sectorController.text,
                  subsector: _subsectorController.text.isEmpty ? null : _subsectorController.text,
                  birthdate: DateTime.now(), // Replace with actual birthdate input
                  paymentStatus: false,
                  lastPaymentDate: DateTime.now(),
                  nextRenewalDate: DateTime.now(),
                  qrCode: 'qr_code_placeholder', // Replace with actual QR code generation
                );
                context.read<PlayerViewModel>().addPlayer(player);
                Navigator.pop(context);
              }
            },
            child: Text('Add Player'),
          ),
        ],
      ),
    );
  }
}