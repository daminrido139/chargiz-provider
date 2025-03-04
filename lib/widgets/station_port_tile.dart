import 'package:chargiz_provider/services/common_service.dart';
import 'package:chargiz_provider/widgets/make_port_busy_confirm_dailog.dart';
import 'package:chargiz_provider/widgets/make_port_free_confirm_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StationPortTile extends StatelessWidget {
  final String id;
  final String stationId;
  final String name;
  final Timestamp? estimatedTime;
  const StationPortTile({
    super.key,
    required this.id,
    required this.name,
    required this.estimatedTime,
    required this.stationId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(name),
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.grey.shade900,
            context: context,
            builder: (context) {
              if (estimatedTime != null) {
                return MakePortFreeConfirmDialog(
                    stationId: stationId, portId: id);
              }
              return MakePortBusyConfirmDailog(
                  stationId: stationId, portId: id);
            });
      },
      subtitle: (estimatedTime != null)
          ? Text(
              "Available in ${CommonService.foramtTimeLeft(estimatedTime!)}",
              style: TextStyle(color: Colors.red),
            )
          : Text(
              "Available now",
              style: TextStyle(color: Colors.green),
            ),
    );
  }
}
