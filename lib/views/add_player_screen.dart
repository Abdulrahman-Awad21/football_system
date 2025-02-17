import 'dart:io'; // Import dart:io for File
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view_models/player_view_model.dart';
import '../models/player_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker

class AddPlayerScreen extends StatelessWidget {
  final String? initialSector;

  const AddPlayerScreen({super.key, this.initialSector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddPlayerForm(
          initialSector: initialSector,
        ),
      ),
    );
  }
}

class AddPlayerForm extends StatefulWidget {
  final String? initialSector;

  const AddPlayerForm({super.key, this.initialSector});

  @override
  _AddPlayerFormState createState() => _AddPlayerFormState();
}

class _AddPlayerFormState extends State<AddPlayerForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  DateTime? _birthdate;
  String? _selectedSector;
  String? _selectedSubsector;
  File? _image; // Store the selected image as a File

  final Map<String, String> _sectors = {
    "Taqadum Nasheen": "Taqadum Nasheen",
    "Taqadum Braeem": "Taqadum Braeem",
    "Smoha Braeem": "Smoha Braeem",
    "Academy": "Academy",
  };

  final List<String> _subsectors = ["A", "B"];

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialSector != null) {
      _selectedSector = widget.initialSector;
    }
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
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
          SizedBox(height: 10),

          // Birthdate
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: 'Birthdate',
                    hintText: 'Select Birthdate',
                  ),
                  enabled: false,
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _birthdate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _birthdate = pickedDate;
                      _birthdateController.text =
                          DateFormat('yyyy-MM-dd').format(_birthdate!);
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 10),

          // Photo
          Row(
            children: [
              Expanded(
                child: _image == null
                    ? Text('No photo selected')
                    : Image.file(
                        _image!,
                        height: 100,
                      ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),

          // Sector
          Text("Select Sector", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(border: OutlineInputBorder()),
            value: _selectedSector,
            items: _sectors.keys.map((String sector) {
              return DropdownMenuItem<String>(
                value: sector,
                child: Text(sector),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSector = newValue;
              });
            },
            validator: (value) => value == null ? 'Please select a sector' : null,
          ),
          SizedBox(height: 10),

          // Subsector (Optional)
          Text("Select Subsector (Optional)", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(border: OutlineInputBorder()),
            value: _selectedSubsector,
            items: _subsectors.map((String subsector) {
              return DropdownMenuItem<String>(
                value: subsector,
                child: Text("Sector $subsector"),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSubsector = newValue;
              });
            },
          ),
          SizedBox(height: 20),

          // Add Player Button
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() && _selectedSector != null) {
                final player = Player(
                  id: null,
                  name: _nameController.text,
                  sector: _selectedSector!,
                  subsector: _selectedSubsector,
                  birthdate: _birthdate!,
                  paymentStatus: false,
                  lastPaymentDate: DateTime.now(),
                  nextRenewalDate: DateTime.now(),
                  qrCode: 'qr_code_placeholder',
                );
                String playerId = await context.read<PlayerViewModel>().addPlayer(player,_image);
                print("Added player with ID: $playerId");
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a sector.')),
                );
              }
            },
            child: Text('Add Player'),
          ),
        ],
      ),
    );
  }
}