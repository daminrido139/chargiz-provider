import 'package:chargiz_provider/services/common_service.dart';
import 'package:flutter/material.dart';

class MakePortFreeConfirmDialog extends StatelessWidget {
  final String stationId;
  final String portId;
  const MakePortFreeConfirmDialog(
      {super.key, required this.stationId, required this.portId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text("Do you want to complete this port?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 20),
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
                  CommonService.makePortAvailable(
                    stationId,
                    portId,
                  );
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
