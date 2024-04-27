import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controllers/homecontroller.dart';

import '../constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height /2,
                      child: const Card(
                        elevation: 2,
                        color: Colors.white,
                      ),
                    )),
              Positioned(
                  top: 30,
                  left: 10,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20 ,
                    height: MediaQuery.of(context).size.height /2,
                    child: Card(
                      elevation: 0,
                      color: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.
                        only(topRight: Radius.circular(40),
                        topLeft:Radius.circular(20) ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: const BorderRadius.
                          only(topRight: Radius.circular(40),
                              topLeft:Radius.circular(20) ),
                        ),
                        child:GetBuilder<HomeController>(builder: (controller){
                          return controller.imagepath == null?
                          Image.network(AppImages.taskImage):
                          Image.file(File(controller.imagepath!));
                        },),
                      ),
                    ),
                  )),

              ],
            ),
            Positioned(
              bottom: 90,
              child: GetBuilder<HomeController>(
                builder: (controller){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                       controller.chooseImage(context);
                  }, child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.camera_alt,
                            color: Colors.white,),
                        ),
                      ),
                      Text("${controller.texts[controller.counter]}",style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                      const Text("شكرا شركة ترسية بالتوفيق",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("${controller.counter+1}/3",style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      MaterialButton(onPressed: (){
                        controller.next();
                        },
                        color:controller.counter ==2
                            ?Colors.blue: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:controller.counter == 2
                            ?const Text('أظهر عدد اولي',
                            style: TextStyle(
                                color: Colors.white
                            ) ):
                        const Text("Next",style: TextStyle(
                            color: Colors.white
                        ),),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
