import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/player_view_model.dart';
import '../models/player_model.dart';
import 'package:intl/intl.dart';

class PlayerProfileScreen extends StatefulWidget {
  final String playerId;

  const PlayerProfileScreen({Key? key, required this.playerId}) : super(key: key);

  @override
  _PlayerProfileScreenState createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  Player? _player;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayer();
  }

  Future<void> _loadPlayer() async {
    setState(() {
      _isLoading = true;
    });
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    _player = await playerViewModel.getPlayer(widget.playerId); // Use getPlayer() from the PlayerViewModel
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player Profile')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _player == null
              ? Center(child: Text('Player not found'))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Photo
                      _player!.imageUrl != null
                          ? Image.network(
                              _player!.imageUrl!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.person, size: 80, color: Colors.white),
                            ),
                      SizedBox(height: 20),

                      // Player Name
                      Text(
                        _player!.name ?? 'N/A',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      // Player ID
                      Text(
                        'ID: ${_player!.id ?? 'N/A'}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 20),

                      // Details Section
                      _buildDetailRow('Age', _calculateAge(_player!.birthdate!).toString()),
                      _buildDetailRow('Birthdate', DateFormat('yyyy-MM-dd').format(_player!.birthdate!)),
                      _buildDetailRow('Last Payment Date', DateFormat('yyyy-MM-dd').format(_player!.lastPaymentDate!)),
                      _buildDetailRow('Next Renewal Date', DateFormat('yyyy-MM-dd').format(_player!.nextRenewalDate!)),
                      _buildDetailRow('Payment Status', _player!.paymentStatus! ? 'Paid' : 'Not Paid'),

                      SizedBox(height: 20),

                      // QR Code (Placeholder for Now)
                      Text('QR Code: ${_player!.qrCode ?? 'N/A'}'),

                      SizedBox(height: 20),

                      // Button to Navigate to Player ID Card (Placeholder)
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to Player ID Card Screen
                        },
                        child: Text('View Player ID Card'),
                      ),
                       SizedBox(height: 20),

                      Center(
                         child:Text('Player ID: ${widget.playerId}'),
                      )
                    ],
                  ),
                ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}