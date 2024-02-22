import 'package:deenae/views/shared/widgets/export.dart';
import 'package:flutter/services.dart' as the_bundle;
import 'package:http/http.dart' as http;

class Helper {
  static var client = http.Client();
  // this class is used to retrieve data from api
  Future<List<Coffee>> getMogokCoffees() async {
    // final data =
    //     await the_bundle.rootBundle.loadString('assets/jsons/m_coffee.json');
    var url = Uri.http(Config.apiUrl, Config.coffees);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final mCoffeeList = coffeeFromJson(response.body);
      var mogok = mCoffeeList.where((element) => element.category == 'Mogok');
      return mogok.toList();
    } else {
      throw Exception('Failed to get product list');
    }
  }

  Future<List<Coffee>> getShanCoffees() async {
    var url = Uri.http(Config.apiUrl, Config.coffees);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final sCoffeeList = coffeeFromJson(response.body);
      var shan = sCoffeeList.where((element) => element.category == 'Shan');
      return shan.toList();
    } else {
      throw Exception('Failed to get product list');
    }
  }

  Future<List<Coffee>> getKalawCoffees() async {
    var url = Uri.http(Config.apiUrl, Config.coffees);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final kCoffeeList = coffeeFromJson(response.body);
      var kalaw = kCoffeeList.where((element) => element.category == 'Kalaw');
      return kalaw.toList();
    } else {
      throw Exception('Failed to get product list');
    }
  }

  Future<List<Coffee>> search(String searchQuery) async {
    var url = Uri.http(Config.apiUrl, '${Config.search}$searchQuery');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final result = coffeeFromJson(response.body);
      return result;
    } else {
      throw Exception('No product');
    }
  }

  // Future<List<Coffee>> getKalawCoffees() async {
  //   final data = await the_bundle.rootBundle
  //       .loadString('assets/jsons/kalaw_coffee.json');
  //   final kCoffeeList = coffeeFromJson(data);
  //   return kCoffeeList;
  // }

  // Future<List<Coffee>> getShanCoffees() async {
  //   final data =
  //       await the_bundle.rootBundle.loadString('assets/jsons/shan_coffee.json');
  //   final sCoffeeList = coffeeFromJson(data);
  //   return sCoffeeList;
  // }

  // Future<Coffee> getMogokCoffee(String id) async {
  //   final data =
  //       await the_bundle.rootBundle.loadString('assets/jsons/m_coffee.json');
  //   final mCoffeeList = coffeeFromJson(data);
  //   final mCoffee = mCoffeeList.firstWhere((coffee) => coffee.id == id);
  //   return mCoffee;
  // }

  // Future<Coffee> getKalawCoffee(String id) async {
  //   final data = await the_bundle.rootBundle
  //       .loadString('assets/jsons/kalaw_coffee.json');
  //   final kCoffeeList = coffeeFromJson(data);
  //   final kCoffee = kCoffeeList.firstWhere((coffee) => coffee.id == id);
  //   return kCoffee;
  // }

  // Future<Coffee> getShanCoffee(String id) async {
  //   final data =
  //       await the_bundle.rootBundle.loadString('assets/jsons/shan_coffee.json');
  //   final sCoffeeList = coffeeFromJson(data);
  //   final sCoffee = sCoffeeList.firstWhere((coffee) => coffee.id == id);
  //   return sCoffee;
  // }
}
