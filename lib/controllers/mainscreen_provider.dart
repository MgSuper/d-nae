import 'package:deenae/views/shared/widgets/export_packages.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners(); // to notify all the listeners of the state changes, useful when want to update the UI
  }
}
