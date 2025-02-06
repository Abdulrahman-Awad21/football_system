import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/player_view_model.dart';
import '../models/player_model.dart';
import 'add_player_screen.dart';
import 'package:intl/intl.dart'; // Import intl package to handle cash values with symbols

class SectorDetailsScreen extends StatelessWidget {
  final String sectorName;

  SectorDetailsScreen({required this.sectorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$sectorName Players')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPlayerScreenForSector(sector: sectorName), // Navigate to AddPlayerScreenForSector
                      ),
                    );
                  },
                  child: Text('Add Player'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Scan Player Card functionality
                    print('Scan Player Card pressed');
                  },
                  child: Text('Scan Player Card'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Search Player functionality
                    print('Search Player pressed');
                  },
                  child: Text('Search Player'),
                ),
              ],
            ),
          ),
          Expanded(
            child: PlayerList(sectorName: sectorName),
          ),
          InvoiceSummary(sectorName: sectorName),
        ],
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final String sectorName;

  const PlayerList({Key? key, required this.sectorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, playerViewModel, child) {
        final players = playerViewModel.players
            .where((player) => (player.sector ?? '') == sectorName)
            .toList();

        return ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return ListTile(
              title: Text(player.name ?? "No Name Provided"),
              subtitle: Text(player.sector ?? "No Sector Provided"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // TODO: Implement Navigate to player profile screen
              },
            );
          },
        );
      },
    );
  }
}

class InvoiceSummary extends StatelessWidget {
  final String sectorName;

  const InvoiceSummary({Key? key, required this.sectorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, playerViewModel, child) {
        final players = playerViewModel.players
            .where((player) => (player.sector ?? '') == sectorName)
            .toList();

        // Calculate the total invoice for all players in the sector
        double totalInvoice = 0;
        for (var player in players) {
          //In order to calculate the invoice, we need to get the sector payment details and calculate the overdue date
          totalInvoice += 1500 ; // this value needs to be changed for the value on the database
        }

        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Number of Players: ${players.length}'),
              Text('Total Invoice: ${NumberFormat.currency(locale: 'en_US', symbol: '\$').format(totalInvoice)}'),
            ],
          ),
        );
      },
    );
  }
}

// New AddPlayerScreen for Sector Details Screen.
// Inheriting from the first add_player_screen
class AddPlayerScreenForSector extends StatelessWidget {
  final String sector;

  const AddPlayerScreenForSector({Key? key, required this.sector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Player to $sector')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddPlayerFormSector(sector: sector),
      ),
    );
  }
}

//A new implementation of AddPlayerForm, specialized for the sector
class AddPlayerFormSector extends StatefulWidget {
  final String sector;

  const AddPlayerFormSector({Key? key, required this.sector}) : super(key: key);
  @override
  _AddPlayerFormStateSector createState() => _AddPlayerFormStateSector();
}

class _AddPlayerFormStateSector extends State<AddPlayerFormSector> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  DateTime? _birthdate;
  String? _selectedSubsector;


  final List<String> _subsectors = ["A", "B"];

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
              if (_formKey.currentState!.validate()) {
                //Check if _birthdate is null
                if (_birthdate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a birthdate.')),
                  );
                  return;
                }
                final player = Player(
                  id: null,
                  name: _nameController.text,
                  sector: widget.sector,
                  subsector: _selectedSubsector,
                  birthdate: _birthdate!, // assert that _birthdate is not null
                  paymentStatus: false,
                  lastPaymentDate: DateTime.now(),
                  nextRenewalDate: DateTime.now(),
                  qrCode: 'qr_code_placeholder',
                );
                String playerId = await context.read<PlayerViewModel>().addPlayer(player);
                print("Added player with ID: $playerId");
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('There was a problem adding the player.')),
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