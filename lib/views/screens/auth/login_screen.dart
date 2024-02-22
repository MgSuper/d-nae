import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/models/auth/login_model.dart';
import 'package:deenae/views/screens/auth/register_screen.dart';
import 'package:deenae/views/shared/widgets/custom_textfield.dart';
import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool validation = false;

  void formValidation() {
    if (emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
              text: 'Welcome!',
              style: appstyle(30, Colors.white, FontWeight.w600),
            ),
            ReusableText(
              text: 'Fill your details to login into your account',
              style: appstyle(14, Colors.white, FontWeight.normal),
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              keyboard: TextInputType.emailAddress,
              hintText: 'Email',
              controller: emailCtrl,
              validator: (email) {
                if (email!.isEmpty && !email.contains('@')) {
                  return 'Please provide valid email';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
              hintText: 'Password',
              controller: passwordCtrl,
              obscureText: authNotifier.isObsecure,
              suffixIcon: GestureDetector(
                onTap: () {
                  authNotifier.isObsecure = !authNotifier.isObsecure;
                },
                child: authNotifier.isObsecure
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              ),
              validator: (password) {
                if (password!.isEmpty && password.length <= 6) {
                  return 'Password too weak';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: ReusableText(
                  text: 'Register',
                  style: appstyle(14, Colors.white, FontWeight.normal),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () {
                formValidation();
                if (validation) {
                  debugPrint('emailCtrl.text ${emailCtrl.text}');
                  debugPrint('passwordCtrl.text ${passwordCtrl.text}');
                  Login login =
                      Login(email: emailCtrl.text, password: passwordCtrl.text);
                  authNotifier.login(login).then((res) => {
                        debugPrint('Failed to login $res'),
                        if (res == true)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            ),
                          }
                        else
                          {debugPrint('Failed to login')}
                      });
                  debugPrint('form validated');
                } else {
                  debugPrint('form invalidated');
                }
              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Center(
                  child: ReusableText(
                    text: 'L O G I N',
                    style: appstyle(18, Colors.black, FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
