import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/utils/utils.dart';
import '../widgets/textfield_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Flexible(flex: 2, child: Container()),
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 50,
          ),
          const SizedBox(
            height: 64,
          ),
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdbAPdbKWCW8JZRhrUGNhu0iPGABj_qkZEsxazxMk&s"),
                    ),
              Positioned(
                  bottom: -2,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter your username',
            textEditingController: _usernameController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter your email',
            textEditingController: _emailController,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter your password',
            textEditingController: _passwordController,
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter your bio',
            textEditingController: _bioController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () async {
              String res = await AuthMethods().signUpUser(
                email: _emailController.text,
                password: _passwordController.text,
                username: _usernameController.text,
                bio: _bioController.text,
                 file:_image!,
              );
              debugPrint("tapping signup button $res");
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                color: blueColor,
              ),
              child: const Text("Sign up"),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(flex: 2, child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: const Text("Don't have an account?"),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Sign up.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    )));
  }
}
