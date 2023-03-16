import 'package:flutter/material.dart';
import 'package:instagramclone/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Icon(
            Icons.upload,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
