import 'package:chargiz_provider/services/common_service.dart';
import 'package:chargiz_provider/ui/home_page/station_ports_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> stationIds = [];
  String? currentStation;

  @override
  void initState() {
    fetchStations();
    super.initState();
  }

  void fetchStations() async {
    stationIds = await CommonService.fetchStations();
    currentStation = stationIds[0].id;
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
                    items: stationIds
                        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
                      return DropdownMenuItem(
                        value: doc.id,
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            "${doc.data()["name"]}",
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
