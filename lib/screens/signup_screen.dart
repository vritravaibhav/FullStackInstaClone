import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/Resources/auth_methods.dart';
import 'package:instagramclone/responsive/responsive_layout_screen.dart';
import 'package:instagramclone/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widget/text_field_input.dart';
import 'login_screens.dart';

// void selectimage() async {
//     Uint8List? v = await pickImage(ImageSource.gallery);
//     setState(() {
//       _image = v;
//     });
//   }
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String vaibhav =
      "https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  //lol
  void selectimage() async {
    Uint8List? v =  await pickImage(ImageSource.gallery);
    if (v != null) {
      setState(() {
        _image = v;
      });
    }
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    if (res != 'Success') {
      showSnackBar(res, context);
    }else{
       Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>const ResponsiveLayout(
          WebScreenLayout: WebScreenLayout(),
           MobileScreenLayout: MobileScreenLayout(),
        ),
        )
           );
        
    }
  
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
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
          //Circular widget to show our selected files
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(vaibhav),
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      selectimage();
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ))
            ],
          ),

          TextFieldInput(
              textEditingController: _usernameController,
              hintText: "Enter your username",
              textInputType: TextInputType.text),
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
          TextFieldInput(
              textEditingController: _emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress),
          SizedBox(
            height: 24,
          ),
          TextFieldInput(
              textEditingController: _bioController,
              hintText: "Enter your bio",
              textInputType: TextInputType.text),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap:// () {
            //  if (_image != null) {
                signUpUser,
          //    } else {
           //     showSnackBar("please upload picture", context);
           //   }
         //   },
            child: Container(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : const Text("Sign up"),
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
                child: const Text("Already have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              // SizedBox(width: 20,),
              GestureDetector(
                onTap: navigateToLogin,
                child: Container(
                  child: Text(
                    "Login",
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
