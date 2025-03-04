import 'package:chargiz_provider/services/common_service.dart';
import 'package:chargiz_provider/widgets/station_port_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StationPortsBody extends StatelessWidget {
  final String stationId;
  const StationPortsBody({
    super.key,
    required this.stationId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: CommonService.streamStationPorts(stationId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final ports = snapshot.data!.docs;
          return ListView.builder(
            itemCount: ports.length,
            itemBuilder: (context, index) {
              final data = ports[index].data();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: StationPortTile(
                  stationId: stationId,
                  id: ports[index].id,
                  isBusy: data["is_busy"],
                  name: data["name"],
                  estimatedTime: data["estimated_time"],
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
