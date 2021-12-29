
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  ImagePicker imagePicker = ImagePicker();
  File? dosya;
  List<File>? dosyalar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Pick Image'),
              onPressed: (){
                showModalBottomSheet(context: context, builder: (context)=>Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(onTap: (){
                      pickImage(ImageSource.gallery);
                    },title: const Text('Galeriden Seç'),),
                    ListTile(onTap: (){
                      pickImage(ImageSource.camera);
                    },title: const Text('Kameradan Çek'),),
                    ListTile(onTap: ()async{
                      var photos = await imagePicker.pickMultiImage(maxWidth: 100,maxHeight: 100,imageQuality: 80);
                      for(var i =0; i<photos!.length;i++){
                        dosyalar!.add(File(photos[i].path));
                      }
                      setState(() {});
                      Navigator.pop(context);
                    },title: const Text('Fotoğraflar Seç'),),
                  ],
                ));
              },
            ),
            if (dosyalar!.isEmpty) Container() else Container(
              height: 200,
              child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemCount: dosyalar!.length,itemBuilder: (context,index){
                return Image.file(dosyalar![index],width: 100,height: 100,);
              }),
            ),
            if (dosya != null) Image.file(dosya!,width: 100,height: 100,) else Container()
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async{
    var photo = await imagePicker.pickImage(source: source);
    setState(() {
      dosya = File(photo!.path);
    });
    Navigator.pop(context);
  }
}

