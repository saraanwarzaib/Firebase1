import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utilis/utilis.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase/widgets/round_Button.dart';
import 'package:flutter/material.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  bool loading = false;
  TextEditingController postController = TextEditingController();
  final fireStore=FirebaseFirestore.instance.collection("User");

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const BigText(
            text: "AddFireStoreData",
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
                   loading=true;
                     });
                   String id= DateTime.now().millisecondsSinceEpoch.toString();
                   fireStore.doc(id).set({
                     "title":postController.text.toString(),
                     "id":id,
                   }).then((value) {
                     setState(() {
                       loading=false;
                     });
                     Utils().toastMessage("post added sucessfully");
                   }).onError((error, stackTrace) {
                     setState(() {
                       loading=false;
                     });
                     Utils().toastMessage(error.toString());


                   });

                }),
          ],
        ),
      ),
    );
  }
}