import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PlacesApiGoogleSearch extends StatefulWidget {
  const PlacesApiGoogleSearch({super.key});

  @override
  State<PlacesApiGoogleSearch> createState() => _PlacesApiGoogleState();
}

class _PlacesApiGoogleState extends State<PlacesApiGoogleSearch> {
  String tokenForSession = "37465";

  var uuid = Uuid();

  List<dynamic> listForPlaces = [];

  final TextEditingController _controller = TextEditingController();

  void makeSuggestion(String input) async {
    String googlePlacesApiKey = "AIzaSyAwFpJJAkHm1bnXhixHC8_jK9laBs5Dkeg";
    String groundURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        '$groundURL?input=$input&key=$googlePlacesApiKey&sessiontoken=$tokenForSession';

    var responseResult = await http.get(Uri.parse(request));

    var resultData = responseResult.body.toString();

    print('result data');
    print(resultData);

    if (responseResult.statusCode == 200) {
      setState(() {
        listForPlaces =
            jsonDecode(responseResult.body.toString())['predictions'];
      });
    } else {
      throw Exception('Showing data failed, Try Again');
    }
  }

 
//  Todo: Suggestion untuk hanya daerah batam saja.
  // void makeSuggestionBatamOnly(String input) async {
  //   String googlePlacesApiKey = "AIzaSyAwFpJJAkHm1bnXhixHC8_jK9laBs5Dkeg";
  //   String groundURL =
  //       "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  //   // Koordinat Batam (latitude, longitude)
  //   double latitude = 1.2841;
  //   double longitude = 104.0087;
  //   // Radius pencarian dalam meter (misalnya 10 km)
  //   int radius = 10000; // 10 km

  //   // Membuat URL dengan parameter location dan radius
  //   String request =
  //       '$groundURL?input=$input&key=$googlePlacesApiKey&sessiontoken=$tokenForSession&location=$latitude,$longitude&radius=$radius';

  //   var responseResult = await http.get(Uri.parse(request));

  //   var resultData = responseResult.body.toString();

  //   print('result data');
  //   print(resultData);

  //   if (responseResult.statusCode == 200) {
  //     setState(() {
  //       listForPlaces =
  //           jsonDecode(responseResult.body.toString())['predictions'];
  //     });
  //   } else {
  //     throw Exception('Showing data failed, Try Again');
  //   }
  // }

  void onModify() {
    if (tokenForSession == null) {
      setState(() {
        tokenForSession = uuid.v4();
      });
    }

    makeSuggestion(_controller.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onModify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange,
            Colors.teal,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Places Api Google Maps Search"),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Search here ",
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listForPlaces.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        List<Location> Locations = await locationFromAddress(
                            listForPlaces[index]['description']);
                        print(Locations.last.latitude);
                        print(Locations.last.longitude);
                      },
                      title: Text(listForPlaces[index]['description']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
