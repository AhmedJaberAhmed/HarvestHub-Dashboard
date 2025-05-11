import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageField extends StatefulWidget {
  const ImageField({super.key, required this.onFileChanged});
  final ValueChanged<File?> onFileChanged;


  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  bool isLoading = false;
  File? fileImage;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          try {
            await pickImage();
          } catch (e) {}
          isLoading = false;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey)),
                  child: fileImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(fileImage!))
                      : Icon(
                          color: Color(0xFF3FBC45),
                          Icons.image_outlined,
                          size: 180,
                        )),
              Visibility(
                visible: fileImage!=null,
                child: IconButton(onPressed: (){
                  fileImage=null;
                  widget.onFileChanged(null);

                  setState(() {

                  });
                }, icon:Icon(color: Colors.red,Icons.cleaning_services_rounded)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
     final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    fileImage = File(image!.path);
    widget.onFileChanged(fileImage!);
  }
}
