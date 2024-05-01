import 'package:flutter/material.dart';

import 'package:weather_api_app/homePage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  final textController = TextEditingController();
  String? CityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5842A9),
      body: Column(
        children: [
          SizedBox(height: 100), // Adjust the height as needed
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: textController,
              onChanged: (value) {},
              style: TextStyle(
                color: Colors.white,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search'.toUpperCase(),
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),

          MaterialButton(
            onPressed: () {
              setState(() {
                CityName = textController.text;
                homePage();
              });
            },
            color: Colors.deepPurpleAccent,
            child: const Text(
              "Show Weather",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
