import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../services/crud.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late File selectedImage;
  final picker = ImagePicker();
  Crud crud = new Crud();

  bool isLoading = false;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      Reference fireBaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('blog_image')
          .child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = fireBaseStorageRef.putFile(selectedImage);

      var downloadURL = await (await task).ref.getDownloadURL();
      print(downloadURL);
    } else {
      print('no image');
    }
  }

/*
  Future<void> uploadBlog() async {
    setState(() {
      isLoading = true;
    });
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('blogImage');

    final UploadTask task = firebaseStorageRef.putFile(selectedImage);
    var imageUrl;
    await task.whenComplete(() async {
      try {
        imageUrl = await firebaseStorageRef.getDownloadURL();
      } catch (onError) {
        print("error");
      }
      print(imageUrl);
    });
    Map<String, dynamic> blogData = {
      "imgUrl": imageUrl,
      "author": authorTextEditingController.text,
      "title": titleTextEditingController.text,
      "desc": descTextEditingController.text
    };
    crud.addData(blogData).then((value) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    });
  }
*/
  TextEditingController titleTextEditingController =
      new TextEditingController();
  TextEditingController descTextEditingController = new TextEditingController();
  TextEditingController authorTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Adam's Blog",
              style: TextStyle(fontSize: 18),
            ),
            Text("Blog", style: TextStyle(fontSize: 22, color: Colors.blue))
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: isLoading
          ? Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 16),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              height: 150,
                              width: double.infinity,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                            )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: <Widget>[
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(hintText: "Author Name"),
                      ),
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(hintText: "Title"),
                      ),
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(hintText: "Description"),
                      ),
                    ]),
                  )
                ],
              ),
            ),
    );
  }
}

/*
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Blog"),
        actions: [
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Container(
                            height: 150,
                            margin: EdgeInsets.symmetric(vertical: 24),
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: Image.file(
                                selectedImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(hintText: "enter title"),
                      ),
                      TextField(
                        controller: descTextEditingController,
                        decoration: InputDecoration(hintText: "enter desc"),
                      ),
                      TextField(
                        controller: authorTextEditingController,
                        decoration:
                            InputDecoration(hintText: "enter author name"),
                      ),
                    ],
                  )),
            ),
    );
  }
}
*/
