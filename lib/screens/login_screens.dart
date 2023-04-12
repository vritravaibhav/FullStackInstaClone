import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/Resources/auth_methods.dart';
//import 'package:instagramclone/screens/home_screens.dart';
import 'package:instagramclone/screens/signup_screen.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/utils/utils.dart';
import 'package:instagramclone/widget/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>const ResponsiveLayout(
          WebScreenLayout: WebScreenLayout(),
           MobileScreenLayout: MobileScreenLayout(),
        ),
        )
           );
    } else {
      showSnackBar(res, context);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          //text field for input and all things
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress),
          SizedBox(
            height: 24,
          ),
          TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Enter your password",
              ispass: true,
              textInputType: TextInputType.text),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: loginUser,
            child: Container(
              child: const Text("Log in"),
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  )),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text("Dont have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              // SizedBox(width: 20,),
              GestureDetector(
                onTap: navigateToSignUp,
                child: Container(
                  child: Text(
                    "Sign up.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              )
            ],
          )
        ]),
      )),
    );
  }
}
