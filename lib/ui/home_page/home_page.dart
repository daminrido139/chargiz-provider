import 'package:chargiz_provider/services/common_service.dart';
import 'package:chargiz_provider/ui/home_page/station_ports_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> stationIds = [];
  String? currentStation;

  @override
  void initState() {
    fetchStations();
    super.initState();
  }

  void fetchStations() async {
    stationIds = await CommonService.fetchStations();
    currentStation = stationIds[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return currentStation == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              actions: [
                SizedBox(width: 20),
                DropdownButton(
                    value: currentStation,
                    items: stationIds.map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text("Station $val"),
                      );
                    }).toList(),
                    onChanged: (v) {
                      currentStation = v;
                      setState(() {});
                    }),
                Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.refresh)),
                SizedBox(width: 10),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 14, bottom: 8),
                  child: Text(
                    "Available ports",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Expanded(
                  child: StationPortsBody(
                    key: Key(currentStation!),
                    stationId: currentStation!,
                  ),
                ),
              ],
            ),
          );
  }
}
