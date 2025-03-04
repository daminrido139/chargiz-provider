import 'package:chargiz_provider/services/common_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MakePortBusyConfirmDailog extends StatefulWidget {
  final String stationId;
  final String portId;
  const MakePortBusyConfirmDailog(
      {super.key, required this.stationId, required this.portId});

  @override
  State<MakePortBusyConfirmDailog> createState() =>
      _MakePortBusyConfirmDailogState();
}

class _MakePortBusyConfirmDailogState extends State<MakePortBusyConfirmDailog> {
  Duration _selectedDuration = const Duration(minutes: 30);

  final Map<Duration, String> _durations = {
    Duration(minutes: 15): '15 mins',
    Duration(minutes: 30): '30 mins',
    Duration(minutes: 45): '45 mins',
    Duration(minutes: 60): '60 mins',
    Duration(hours: 2): '2 hours',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 15),
          child: Text("Do you want to make this port busy?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 15, bottom: 10),
          child: Text(
            "Estimated time?",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Center(
          child: SegmentedButton<Duration>(
              showSelectedIcon: false,
              segments: _durations.entries
                  .map((entry) => ButtonSegment<Duration>(
                        value: entry.key,
                        label: Text(
                          entry.value,
                          style: TextStyle(fontSize: 13),
                        ),
                      ))
                  .toList(),
              selected: {_selectedDuration},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedDuration = newSelection.first;
                });
              }),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No", style: TextStyle(fontSize: 18)),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  await CommonService.makePortBusy(
                      widget.stationId,
                      widget.portId,
                      Timestamp.fromDate(
                          DateTime.now().add(_selectedDuration)));
                  Navigator.pop(context);
                },
                child: Text("Yes", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
