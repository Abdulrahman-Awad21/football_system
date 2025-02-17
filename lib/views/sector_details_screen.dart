import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/player_view_model.dart';
import '../models/player_model.dart';
import 'add_player_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'player_profile_screen.dart';
import 'package:intl/intl.dart';

class SectorDetailsScreen extends StatefulWidget {
  final String sectorName;

  SectorDetailsScreen({required this.sectorName});

  @override
  _SectorDetailsScreenState createState() => _SectorDetailsScreenState();
}

class _SectorDetailsScreenState extends State<SectorDetailsScreen> {
  String? _searchQuery;
  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
        playerViewModel.fetchPlayersBySector(widget.sectorName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.sectorName} Players')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search Bar
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by name or ID',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Perform search (implementation details depend on your data structure)
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _scanQrCode(context);
                  },
                  icon: Icon(Icons.qr_code_scanner),
                  label: Text('Scan Player ID'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to AddPlayerScreen, pre-filling the sector
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPlayerScreen(initialSector: widget.sectorName),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Player'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<PlayerViewModel>(
              builder: (context, playerViewModel, child) {
                List<Player> players = playerViewModel.players
                    .where((player) => player.sector == widget.sectorName)
                    .toList();

                if (_searchQuery != null && _searchQuery!.isNotEmpty) {
                  players = players.where((player) =>
                      (player.name?.toLowerCase().contains(_searchQuery!.toLowerCase()) == true) ||
                      (player.id?.toLowerCase().contains(_searchQuery!.toLowerCase()) == true)
                  ).toList();

                }

                return ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    final now = DateTime.now();
                    final currentMonth = DateTime(now.year, now.month);
                    final lastPaymentMonth = DateTime(player.lastPaymentDate!.year, player.lastPaymentDate!.month);

                    final isPaidThisMonth = player.paymentStatus == true &&
                        lastPaymentMonth == currentMonth &&
                        player.nextRenewalDate!.isAfter(now);

                    return ListTile(
                      title: Text(player.name ?? "Name not provided"),
                      subtitle: Text(player.id ?? "ID not provided"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPaidThisMonth ? Icons.check_circle : Icons.cancel,
                            color: isPaidThisMonth ? Colors.green : Colors.red,
                          ),
                          SizedBox(width: 8), // Add some spacing
                          Text(
                            isPaidThisMonth ? 'Paid' : 'Not Paid',
                            style: TextStyle(
                              color: isPaidThisMonth ? Colors.green : Colors.red,
                            ),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayerProfileScreen(playerId: player.id!),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scanQrCode(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Scan QR Code"),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');
                    Navigator.pop(context, barcode.rawValue); // Return the scanned value
                    break; // exit to avoid multi adds
                  }
                }
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((scannedValue) async {
      if (scannedValue != null) {
        // Handle the scanned QR code value (e.g., search for the player)
        print('Scanned QR Code: $scannedValue');
        // Implement the logic to update player payment status if needed.
        // For example, you might want to navigate to a "Payment" screen
        // and then refresh the player list after the payment is updated.
        // context.read<PlayerViewModel>().markAttendance(scannedValue);
      }
    });
  }
}