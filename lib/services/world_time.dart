import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI.
  String time; // The time in that location.
  String flag; // Url to an asset flag icon.
  String timezone; // Timezone location for API endpoint.
  bool isDayTime = true; // True if daytime; false otherwise.

  WorldTime({this.location, this.flag, this.timezone});

  Future<void> getTime() async {
    try {
      print(this.timezone);
      Response res =
          await get("http://worldclockapi.com/api/json/$timezone/now");
      Map data = jsonDecode(res.body);

      String datetime = data["currentDateTime"];
      String offset = data["utcOffset"].substring(0, 3);

      // Create DataTime object.
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property.
      isDayTime = now.hour > 3 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (err) {
      print('Caught error: $err');
      time = "Could not get time data";
    }
  }
}
