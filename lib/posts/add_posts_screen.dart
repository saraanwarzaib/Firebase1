import 'package:firebase/utilis/utilis.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase/widgets/round_Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/uploaded_image.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  TextEditingController postController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref("post");

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const BigText(
        text: "AddPOST",
        color: Colors.white,
        size: 16,
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: postController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Whats on your mind",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Button(
                width: size.width * 0.6,
                height: size.height * 0.07,
                title: "Add",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  // we take this id , that the chid and data id both are come same , in order that we easily delte and update the data
                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  databaseRef.child(id).set({
                    "title": postController.text.toString(),
                    // Through this id we can delete and update the data
                    "id": id,
                  }).then((value) {
                    Utils().toastMessage("Post added");

                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }),
            SizedBox(height:10),
            Button(width: 80, height:30, title:"Next",onTap: (){
              Get.to(const UploadImageScreen());}),
          ],
        ),
      ),
    );
  }
}
