import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class BrandService{
  Firestore firestore = Firestore.instance;
  String ref = 'brands';

  void createBrand(String name){
    var id = Uuid();
    String brandId = id.v1();

    firestore.collection(ref).document(brandId).setData({'brand': name});
  }

  Future<List<DocumentSnapshot>>getBrands() =>
    firestore.collection(ref).getDocuments().then((snaps){
      print(snaps.documents.length);
      return snaps.documents;
    });


  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      firestore.collection(ref).where('brand', isEqualTo: suggestion).getDocuments().then((snap){
        return snap.documents;
      });
}