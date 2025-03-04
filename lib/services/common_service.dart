import 'package:cloud_firestore/cloud_firestore.dart';

class CommonService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchStations() async {
    return (await _firestore.collection('stations').orderBy("created_on").get())
        .docs;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> streamStationPorts(
    String stationId,
  ) {
    return _firestore
        .collection('stations')
        .doc(stationId)
        .collection("ports")
        .orderBy("created_on")
        .snapshots();
  }

  static Future<void> makePortAvailable(String stationId, String portId) async {
    _firestore
        .collection('stations')
        .doc(stationId)
        .collection("ports")
        .doc(portId)
        .set(
      {"estimated_time": null},
      SetOptions(merge: true),
    );
    _firestore.collection('stations').doc(stationId).set(
      {"last_updated": Timestamp.now()},
      SetOptions(merge: true),
    );
  }

  static Future<void> makePortBusy(
      String stationId, String portId, Timestamp estimatedTime) async {
    _firestore
        .collection('stations')
        .doc(stationId)
        .collection("ports")
        .doc(portId)
        .set(
      {"estimated_time": estimatedTime},
      SetOptions(merge: true),
    );
    _firestore.collection('stations').doc(stationId).set(
      {"last_updated": Timestamp.now()},
      SetOptions(merge: true),
    );
  }

  static String foramtTimeLeft(Timestamp timestamp) {
    DateTime targetTime = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = targetTime.difference(now);

    if (difference.isNegative) {
      return "Time's up";
    }

    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return "$hours hr $minutes mins";
    } else if (hours > 0) {
      return "$hours hr";
    } else {
      return "$minutes mins";
    }
  }
}
