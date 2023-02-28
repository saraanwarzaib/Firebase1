

import 'package:firebase/widgets/round_Button.dart';
import 'package:firebase/widgets/smalltextwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/posts/add_posts_screen.dart';
import 'package:firebase/utilis/utilis.dart';
import 'package:firebase/widgets/bigtextwidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../auth/uploaded_image.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth=FirebaseAuth.instance;
  final ref =FirebaseDatabase.instance.ref("post");
  final searchFilter=TextEditingController();
  final editController=TextEditingController();
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
        title:const  BigText(text:"POST",color: Colors.white,size:16,),
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
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: TextFormField(
               controller: searchFilter,
               decoration:const InputDecoration(
                 hintText:"Search here",
                 border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width:2 ))
               ) ,
               onChanged: (String value){
                 setState(() {

                 });
               },
             ),
           ),
           // Expanded(child: StreamBuilder(
           //   stream: ref.onValue,
           //   builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
           //     if(!snapshot.hasData){
           //       return CircularProgressIndicator();
           //     }
           //     else{
           //       Map<dynamic, dynamic> map= snapshot.data!.snapshot.value as dynamic;
           //       List<dynamic> list=[];
           //       list.clear();
           //       list=map.values.toList();
           //     return ListView.builder(
           //         itemCount:snapshot.data!.snapshot.children.length,
           //       itemBuilder: (BuildContext context, int index) {
           //           return ListTile(
           //             title: BigText(text:list[index]['title'] ,size:12 ,color:Colors.black),
           //             subtitle:BigText(text:list[index]['id'] ,size:12 ,color:Colors.black),
           //           );
           //       },);}
           //   },)),

           Expanded(
             child: FirebaseAnimatedList(
               query: ref,
               //
                 //defaultChild:const  BigText(text:"Hellow how are u" ,color:Colors.black ,size:12 ),

               itemBuilder: (context, snapshot, animation, index) {
                 // this title for searching
                 final title=snapshot.child("title").value.toString();
                 if(searchFilter.text.isEmpty){
                   return ListTile(title:BigText(text:snapshot.child("title").value.toString() ,color: Colors.black,size: 12,),
                       subtitle: BigText(text:snapshot.child("id").value.toString() ,color: Colors.black,size: 12,),
                     trailing: PopupMenuButton(
                       icon: Icon(Icons.more_vert),
                       itemBuilder: (BuildContext context)=>[
                         PopupMenuItem(
                           value: 1,
                           onTap: () async {
                             Navigator.pop(context);
                             print("Hellow HOW ARE U");
                             SchedulerBinding.instance.addPostFrameCallback((_)
                             {showMyDialog(title,snapshot.child("id").value.toString());});


                                // return to the previous screen


                           },
                           child: ListTile(
                             leading: Icon(Icons.edit),
                               title:BigText(text: "Edit",size:12 ,color:Colors.black,) ),
                         ),
                         PopupMenuItem(
                           value: 1,
                             onTap: ()async{
                             Navigator.pop(context);

                             ref.child(snapshot.child("id").value.toString()).remove();
                             SchedulerBinding.instance.addPostFrameCallback((_){
                               Get.to(const PostScreen());
                               });

                             },
                           child: ListTile(
                               leading: Icon(Icons.delete_outline),
                               title:BigText(text: "Delete",size:12 ,color:Colors.black,) ),
                         ),
                       ],)
                   );

                 } else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toLowerCase())){
                   return ListTile(title:BigText(text:snapshot.child("title").value.toString() ,color: Colors.black,size: 12,),
                       subtitle: BigText(text:snapshot.child("id").value.toString() ,color: Colors.black,size: 12,));

                 }
                 else{
                   return Container();
                 }

               }),
           ),


         ],
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
                ref.child(id).update(
                  {
                    "title": editController.text.toLowerCase(),
                  }).then((value) => 
                    Utils().toastMessage("post updated"),


                ).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                }
                );
                Get.to(PostScreen());
              } , child: const Smalltext(text:"Update" ,size:12 ,color:Colors.blue,)

              ),

            ],
          );
        } );

  }
}

