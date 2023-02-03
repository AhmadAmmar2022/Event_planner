import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'searchService.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var queryResultSet = [];
  var tempSearhStore = [];
  initialSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearhStore = [];
      });
    }
    var capitalizedValu =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.length == 0 && value.length == 1) {
      SearchServie().searchByName(value).then((QuerySnapshot docs) {
        for(int i=0;i<docs.size  ;++i){
               queryResultSet.add(docs);
        }
      });
    }
    else { 
      tempSearhStore=[];
      queryResultSet.forEach((element) {  
        if(element['name'].startWith(capitalizedValu)){
          setState(() {
            tempSearhStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(onChanged: (val) {
            initialSearch(val);
          }),
    
          SizedBox(height: 50,),
    
          GridView.count(
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 4,
            mainAxisSpacing: 5,
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
               children:tempSearhStore.map((e) {
                  return buildresulet(e);
                }).toList()
               
            
            )
        
        ],
      ),
    );
  }
  Widget buildresulet(data){
    return Card(
      shape: RoundedRectangleBorder(),
      child: Center(
        child: Text(data['name']),
      ),
    );
  }
}
