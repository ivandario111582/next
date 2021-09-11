//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:next_project/model/MenuModel.dart';
//import 'package:next_project/services/UrlServices.dart';
 //CONSULTA DE MENU DINAMICO
class MenuService {
  /*
  static Future<List<MenuModel>> getMenu() async {
    try {
      final urlMenu=UrlServices.urlMenu;
      final response =
          await http.get(urlMenu);
      if (response.statusCode == 200) {
        List<MenuModel> list = parseMenu(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    } 
  }
 
  // Parse the JSON response and return list of Album Objects //
  static List<MenuModel> parseMenu(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<MenuModel>((json) => MenuModel.fromJson(json)).toList();
  }*/

}