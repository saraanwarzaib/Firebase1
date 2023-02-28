import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/firestore/add_firestore_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/widgets/smalltextwidget.dart';
import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/posts/add_posts_screen.dart';
import 'package:firebase/utilis/utilis.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../posts/post_screen.dart';
class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {

  final auth=FirebaseAuth.instance;
  final editController=TextEditingController();
  final loading=false;
  final fireStore=FirebaseFirestore.instance.collection("User").snapshots();
  CollectionReference   ref =FirebaseFirestore.instance.collection("User");

  @override
  void initState(){
    super.initState();
    //ref.onValue.listen((event) { });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:const  BigText(text:"Firestore",color: Colors.white,size:16,),
        centerTitle:true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Get.to(const LoginScreen());

            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
              if (kDebugMode) {
                print("error message ===== $error");
              }
            });

          }, icon: const Icon(Icons.logout_outlined)),
          const  SizedBox(width: 20,),
        ],),
      body: Column(
        children: [
          const SizedBox(height: 30,),
       
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else{
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        return  ListTile(
                          trailing: PopupMenuButton(
                            icon:Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context)=>[
                              PopupMenuItem(
                              value:1,
                                  onTap: ()async {
                                    ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                                      "title":"Hellow sikanar",
                                    }).then((value) => {
                                      Utils().toastMessage("upaded scuessfully"),
                                    }).onError((error, stackTrace) => {
                                      Utils().toastMessage(error.toString()),
                                    });

                                  },
                                  child: ListTile(
                                leading: Icon(Icons.edit),
                                title: BigText(text: "Edit",size: 20,color: Colors.black),
                              )),
                              PopupMenuItem(
                                  value:1,
                                  onTap: ()async {
                                    ref.doc(snapshot.data!.docs[index]['id'].toString()).delete().then((value) => {
                                      Utils().toastMessage("upaded scuessfully"),
                                    }).onError((error, stackTrace) => {
                                      Utils().toastMessage(error.toString()),
                                    });

                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.delete_outline),
                                    title: BigText(text: "Delete",size: 20,color: Colors.black),
                                  ))
                            ]),




                          title: BigText(text:snapshot.data!.docs[index]['title'].toString() ,color:Colors.black ,size: 15),
                          subtitle: BigText(text:snapshot.data!.docs[index]['id'].toString() ,color:Colors.black ,size: 15),
                        );
                      })),
                );
              }




              // if(!snapshot.hasData){
              //   return CircularProgressIndicator();
              // }
              // else{
              //   Map<dynamic, dynamic> map= snapshot.data!.snapshot.value as dynamic;
              //   List<dynamic> list=[];
              //   list.clear();
              //   list=map.values.toList();
              // return ListView.builder(
              //     itemCount:snapshot.data!.snapshot.children.length,
              //   itemBuilder: (BuildContext context, int index) {
              //       return ListTile(
              //         title: BigText(text:list[index]['title'] ,size:12 ,color:Colors.black),
              //         subtitle:BigText(text:list[index]['id'] ,size:12 ,color:Colors.black),
              //       );
              //   },);}
            },),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddFirestoreDataScreen());
        },
        child:const Icon(Icons.add),

      ),

    );
  }
  Future<void>  showMyDialog(String title,String id ) async {
    editController.text=title;
    await showDialog(context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title:const BigText(text:"Update" ,color: Colors.black,size:12 ,),
            content:Container(
              child: TextFormField(
                controller: editController,
                decoration: const InputDecoration(
                  hintText: "Edit here",
                ),
              ),
            ) ,
            actions: [
              TextButton(onPressed:(){
                Navigator.pop(context);
              } , child: const Smalltext(text:"Cancel" ,size:12 ,color:Colors.blue,)),
              TextButton(onPressed:(){
                Navigator.pop(context);

              } , child: const Smalltext(text:"Update" ,size:12 ,color:Colors.blue,)

              ),

            ],
          );
        } );

  }

}
