
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../pickimage.dart';
class HomeController extends GetxController{


  int counter = 0 ;
  List<String> texts = [
    "البداية",
    "الثانية",
    "النهاية"
  ];

   next(){
    if(counter == 2){
      primaryNumberDailog();
    }else{
      counter++;
    }
    update();
   }

   // check number is primary or not
  bool isPrime(int n) {
    if (n <= 1) {
      return false;
    }
    if (n <= 3) {
      return true;
    }
    if (n % 2 == 0 || n % 3 == 0) {
      return false;
    }
    int i = 5;
    while (i * i <= n) {
      if (n % i == 0 || n % (i + 2) == 0) {
        return false;
      }
      i += 6;
    }
    return true;
  }
// get random number
  int getRandomPrime(int limit) {
    List<int> primes = [];
    for (int i = 0; i <= limit; i++) {
      if (isPrime(i)) {
        primes.add(i);
      }
    }
    if (primes.isEmpty) {
      return -1; // no primary number found in the range
    }

    final random = Random();
    return primes[random.nextInt(primes.length)];
  }


  primaryNumberDailog(){
     int primaryNumber = getRandomPrime(1000);
     if(primaryNumber == -1){

     }else{
       Get.defaultDialog(
           title:'${primaryNumber}',
           middleText: "عدد اولي "
       );
     }
  }

//pickimage

File? image ;
   String? imagepath;
chooseImage(context){
     showDialog(context: context,
         builder: (context){
         return AlertDialog(
             title: const Center(child: Text('Choose Image')),
           content: Container(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               TextButton(onPressed: ()async{
               image =await ChooseImage().getImage(true) as File?;
               saveImage(image!.path.toString());
               update();
               },
                   child: const Text("Camera")),
               TextButton(onPressed: ()async{
               image= await ChooseImage().getImage(false) as File?;
               saveImage(image!.path.toString());
               update();

               },
                   child: const Text("Gallary"))
             ],
           ),
           )
         );
     }
     );
     update();
   }

   saveImage(String imagepath)async{
   SharedPreferences sharedPreferences =
   await SharedPreferences.getInstance();
   sharedPreferences.setString("image", imagepath);
   getImage();
   }

   getImage()async{
     SharedPreferences sharedPreferences =
     await SharedPreferences.getInstance();
     imagepath = sharedPreferences.getString("image");
     update();
   }

   @override
  void onInit() {
    // TODO: implement onInit
     getImage();
    super.onInit();
  }

}