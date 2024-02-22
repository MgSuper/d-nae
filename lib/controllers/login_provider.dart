import 'package:deenae/models/auth/login_model.dart';
import 'package:deenae/models/auth/register_model.dart';
import 'package:deenae/services/auth_helper.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;

  set isObsecure(bool newObsecureState) {
    _isObsecure = newObsecureState;
    notifyListeners();
  }

  bool _processing = false;
  bool get processing => _processing;

  set processing(bool newProcessingState) {
    _processing = newProcessingState;
    notifyListeners();
  }

  bool _loginResBool = false;
  bool get loginResBool => _loginResBool;

  set loginResBool(bool newProcessingState) {
    _loginResBool = newProcessingState;
    notifyListeners();
  }

  bool _resBool = false;
  bool get resBool => _resBool;

  set resBool(bool newResState) {
    _resBool = newResState;
    notifyListeners();
  }

  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newProcessingState) {
    _loggedIn = newProcessingState;
    notifyListeners();
  }

  Future<bool> login(Login loginModel) async {
    debugPrint('Start login');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    processing = true;
    debugPrint('login info $login');
    bool response = await AuthHelper().login(loginModel);

    debugPrint('response $response');

    processing = false;
    loginResBool = response;

    loggedIn = prefs.getBool('isLoggedIn') ?? false;
    debugPrint('loginResBool $loginResBool');
    return loginResBool;
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('token');
    prefs.remove('userID');
    prefs.setBool('isLoggedIn', false);
    loggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<bool> register(Register regModel) async {
    resBool = await AuthHelper().register(regModel);
    return resBool;
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('isLoggedIn') ?? false;
  }
}
