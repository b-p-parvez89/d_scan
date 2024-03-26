import 'package:d_scan/utils/colors/homepage_color.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _data = [
    'Apple',
    'Banana',
    'Orange',
    'Pineapple',
    'Grapes',
    'Watermelon',
    'Mango',
  ];

  List<String> _searchResults = [];
  bool _showFilteredData = false;

  @override
  void initState() {
    super.initState();
    _searchResults.addAll(_data);
  }

  void _updateSearchResults(String searchText) {
    setState(() {
      _searchResults = _data
          .where((element) =>
              element.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      _showFilteredData = searchText.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.bgColor,
      appBar: AppBar(
        backgroundColor: HomeColors.appBarbgColor,
        title: TextField(
          onChanged: (value) {
            _updateSearchResults(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _showFilteredData
          ? ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _searchResults[index],
                    style: TextStyle(color: HomeColors.white),
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
