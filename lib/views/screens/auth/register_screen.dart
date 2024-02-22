import 'package:deenae/controllers/login_provider.dart';
import 'package:deenae/models/auth/register_model.dart';
import 'package:deenae/views/screens/auth/login_screen.dart';
import 'package:deenae/views/shared/appstyles.dart';
import 'package:deenae/views/shared/widgets/custom_textfield.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';
import 'package:deenae/views/shared/widgets/reusable_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController usernameCtrl = TextEditingController();

  bool validation = false;

  void formValidation() {
    if (emailCtrl.text.isNotEmpty &&
        passwordCtrl.text.isNotEmpty &&
        usernameCtrl.text.isNotEmpty) {
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
        decoration: BoxDecoration(
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
              text: 'Fill your details to register for an account',
              style: appstyle(14, Colors.white, FontWeight.normal),
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              hintText: 'Username',
              controller: usernameCtrl,
              validator: (name) {
                if (name!.isEmpty) {
                  return 'Please provide valid username';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15.h,
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
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: ReusableText(
                  text: 'Login',
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
                  Register model = Register(
                    username: usernameCtrl.text,
                    email: emailCtrl.text,
                    password: passwordCtrl.text,
                  );
                  authNotifier.register(model).then((res) => {
                        if (res)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                          }
                        else
                          {debugPrint('Faild to register')}
                      });
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
                    text: 'R E G I S T E R',
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
