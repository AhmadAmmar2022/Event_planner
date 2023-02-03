import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServie {
  searchByName(String searchFild) {
    return FirebaseFirestore.instance
        .collection('PackageServices')
        .where("name", isEqualTo: searchFild.substring(0, 1).toUpperCase()).get()
        ;
  }
}
