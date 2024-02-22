import 'package:deenae/views/shared/widgets/export_packages.dart';

class FavouritesProvider extends ChangeNotifier {
  final _favBox = Hive.box('fav_box');
  List<dynamic> _ids = [];
  List<dynamic> _favourites = [];
  List<dynamic> _allFavs = [];

  List<dynamic> get allFavs => _allFavs;

  set allFavs(List<dynamic> newAllFavs) {
    _allFavs = newAllFavs;
    notifyListeners();
  }

  List<dynamic> get ids => _ids;
  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favourites => _favourites;
  set favourites(List<dynamic> newFavourites) {
    _favourites = newFavourites;
    notifyListeners();
  }

  getFav() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        'key': key,
        'id': item['id'],
      };
    }).toList();

    _favourites = favData.toList();
    _ids = _favourites.map((item) => item['id']).toList();
    // notifyListeners();
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
  }

  getAllFavs() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        'key': key,
        'id': item['id'],
        'name': item['name'],
        'price': item['price'],
        'category': item['category'],
        'imageUrl': item['imageUrl']
      };
    }).toList();
    _allFavs = favData.reversed.toList();
  }

  deleteFav(int key) async {
    await _favBox.delete(key);
  }
}
