import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'model/weather.dart';
void main() {
  runApp(
      GetMaterialApp(
        theme:  ThemeData(
        ),
        debugShowCheckedModeBanner: false,
        home: MyBottomNavigationBar(),
      )
  );
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}
class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int index = 0;
  final Tab = [
    Tab1(),
    Tab2(),
    Tab3()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text('Word Clock'),
        centerTitle:true,
      ),
      body:SafeArea(child: Tab[index]) ,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem( label: 'Tab 1', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label:'Tab 2',icon: Icon(Icons.home)),
          BottomNavigationBarItem( label: 'Tab 3', icon: Icon(Icons.home)),
        ],
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;

        }),
      ),

    );
  }
}


class Tab1 extends StatefulWidget {
  const Tab1({super.key});
  @override
  State<Tab1> createState() => _Tab1State();
}
class MyBackGroundColor extends GetxController{
  RxString defaultImage = ''.obs;
  void chonAnh(String color){
    defaultImage = color.obs;
  }
}
class _Tab1State extends State<Tab1> {

  final bgCl = Get.put(MyBackGroundColor());
  DateTime ?currentTime;

  @override
  void initState() {
    currentTime = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer(new Duration(seconds: 1), () {
      setState(() {
        currentTime = DateTime.now();
      });
    });
    return Container(
        decoration: bgCl.defaultImage != '' ? BoxDecoration(
            image: DecorationImage(
                image: FileImage(File(bgCl.defaultImage.toString()))
            )
        ) : BoxDecoration(),
        child: Center(child: Text('${currentTime?.hour}:${currentTime?.minute}:${currentTime?.second}',style: TextStyle(fontFamily: 'Regular',fontSize: 30),))
    );
  }
}




class Tab2 extends StatefulWidget {
  const Tab2({super.key});
  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {


  @override
  Widget build(BuildContext context) {
    final MyBackGroundColor bgcl = Get.find();
    List<Weather>list = [
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
      Weather('Ha Noi', '10:40:2', '09/09:2023', 'Dat', '123'),
    ];
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(File(bgcl.defaultImage.toString()))
          )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return listItem(list[index]);
        },
      ),
    );
  }
}
Widget listItem(  Weather weather){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text('${weather.city}'),
            Text('${weather.title}'),
            Text('${weather.subTitle}'),
          ],
        ),
        Column(
          children: [
            Text('${weather.day}'),
            Text('${weather.time}'),

          ],
        ),
      ],

    ),
  );
}
class Tab3 extends StatefulWidget {
  const Tab3({super.key});
  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {

  late  int index;
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    index = 0 ;
  }
  @override
  Widget build(BuildContext context) {
    final MyBackGroundColor bgCl = Get.find();


    return  Scaffold(
        body: Container(
            padding: EdgeInsets.only(top:20, left:20, right:20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        print(image?.path);
                        bgCl.defaultImage(image?.path);
                      });
                    },
                    child: Text("Pick Image")
                ),

                image == null?Container():
                Image.file(File(image!.path))
              ],)
        )
    );
  }
}








