import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _packSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get packSizes => _packSizes;

  set packSizes(List<dynamic> newPackSizes) {
    _packSizes = newPackSizes;
    notifyListeners();
  }

  // function is called with an index, it will toggle the selection
  // of the item and leave the selection of the other items as they were.
  // This will allow for multiple items to be selected at once.

  void toggleCheck(int index) {
    for (int i = 0; i < _packSizes.length; i++) {
      if (i == index) {
        _packSizes[i]['isSelected'] = !_packSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = sizes;
    notifyListeners();
  }

  late Future<List<Coffee>> mCoffees;
  late Future<List<Coffee>> kCoffees;
  late Future<List<Coffee>> sCoffees;
  late Future<Coffee> cof;

  void getMogokCoffes() {
    mCoffees = Helper().getMogokCoffees();
  }

  void getKalawCoffes() {
    kCoffees = Helper().getKalawCoffees();
  }

  void getShanCoffes() {
    sCoffees = Helper().getShanCoffees();
  }

  // void getCof(String category, String id) {
  //   if (category == 'Mogok') {
  //     cof = Helper().getMogokCoffee(id);
  //   } else if (category == 'Kalaw') {
  //     cof = Helper().getKalawCoffee(id);
  //   } else {
  //     cof = Helper().getShanCoffee(id);
  //   }
  // }
}
