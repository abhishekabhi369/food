import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food/models/categories.dart';
import 'package:food/models/food_modle.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModel> categorieslist = [];
  late CategoriesModel categoriesmodle;

  Future<void> getcategories() async {
    List<CategoriesModel> newcategorieslist = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foods').get();
    querySnapshot.docs.forEach((element) {
      categoriesmodle = CategoriesModel(
          image: element.get('image'), name: element.get('name'));
      print(categoriesmodle.name);
      print(categoriesmodle.image);
      newcategorieslist.add(categoriesmodle);
      categorieslist = newcategorieslist;
    });
  }

  get throwlist {
    return categorieslist;
  }

///////////////////////////////////////////////////////////////////////////////////
  List<FoodModle> foodModleList = [];
  late FoodModle foodModle;

  Future<void> getfoodlist() async {
    List<FoodModle> newFoodmodleList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foods').get();
    //  var data = querySnapshot.metadata as Map;

    querySnapshot.docs.forEach((element) {
      foodModle = FoodModle(
        image: element.get('image'),
        name: element.get('name'),
        price: element.get('price'),
      );

      print(foodModle.name);
      print(foodModle.image);
      newFoodmodleList.add(foodModle);
      foodModleList = newFoodmodleList;
    });
    print(foodModleList);
  }

  get throwFoodModleList {
    return foodModleList;
  }
}
