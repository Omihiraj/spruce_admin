import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:clean_admin/components/constants.dart';
import 'package:clean_admin/services/fire_services.dart';

import 'package:clean_admin/models/location_add.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String? file;
  bool uploadComplete = false;
  String? urlDownload;
  UploadTask? task;
  final serviceName = TextEditingController();
  final defaultPrice = TextEditingController();
  final lName = TextEditingController();
  final altName = TextEditingController();
  final latName = TextEditingController();
  final price = TextEditingController();
  List<LocationAdd> locationData = [];

  Uint8List webImage = Uint8List(8);
  @override
  void dispose() {
    lName.dispose();
    altName.dispose();
    latName.dispose();
    price.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Add Service",
          style: TextStyle(
              color: secondaryColor,
              fontSize: headlineText,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 50),
            child: InkWell(
                onTap: () {
                  FireService.addServive(
                      context: context,
                      locationData: locationData,
                      serviceName: serviceName.text.trim(),
                      price: int.parse(defaultPrice.text.trim()),
                      img: urlDownload!);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Text("Add Service",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.add_circle_outline_rounded,
                            color: Colors.white)
                      ],
                    ))),
          ),
        ],
        elevation: 0,
        backgroundColor: bgColor,
      ),
      body: Container(
        child: ListView(
          controller: ScrollController(),
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: serviceName,
                            decoration: InputDecoration(
                                label: const Text("Service Name"),
                                fillColor: Colors.amber,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight / 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: defaultPrice,
                            decoration: InputDecoration(
                                label: const Text("Default Price"),
                                fillColor: Colors.amber,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: screenWidth / 5,
                    ),
                    Column(
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: uploadComplete ? primaryColor : Colors.grey,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                selectFile();
                              },
                              child: Container(
                                height: 200,
                                width: 200,
                                child: file != null
                                    ? Image.memory(
                                        webImage,
                                        width: 200,
                                        height: 200,
                                      )
                                    : Center(
                                        child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.image_outlined),
                                          Text("Choose Image")
                                        ],
                                      )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: uploadComplete
                                          ? primaryColor
                                          : secondaryColor),
                                  onPressed: uploadFile,
                                  child: const Text("Upload")),
                              const SizedBox(
                                width: 10,
                              ),
                              uploadComplete
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight / 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: const [
                    Text(
                      "Location Details",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: screenHeight / 2,
                      margin: const EdgeInsets.only(top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: lName,
                                  decoration: InputDecoration(
                                      label: const Text("Location Name"),
                                      fillColor: Colors.amber,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: altName,
                                  decoration: InputDecoration(
                                      label: const Text("Altitiude"),
                                      fillColor: Colors.amber,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: latName,
                                  decoration: InputDecoration(
                                      label: const Text("Latitude"),
                                      fillColor: Colors.amber,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 25,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: price,
                                  decoration: InputDecoration(
                                      label: const Text("Price"),
                                      fillColor: Colors.amber,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              // SizedBox(
                              //   width: screenWidth / 3,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    locationData.add(LocationAdd(
                                        locationName: lName.text,
                                        altitude: altName.text,
                                        latitude: latName.text,
                                        price: price.text));
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: secondaryColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Add",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.add_circle_outline_rounded,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 2,
                      width: 500,
                      child: ListView.builder(
                          itemCount: locationData.length,
                          itemBuilder: (context, index) {
                            var item = locationData[index];
                            return SizedBox(
                              width: 500,
                              height: 50,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.locationName),
                                    Text(item.altitude),
                                    Text(item.latitude),
                                    Text(item.price),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            locationData.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(Icons.delete))
                                  ]),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: screenHeight / 10,
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    try {
      if (kIsWeb) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          file = image.name;
        });
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future uploadFile() async {
    if (file == null) return;
    final time = DateTime.now();

    final destination = "$time-$file";

    task = FireService.uploadImage(destination, webImage);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    setState(() {
      urlDownload = url;
      uploadComplete = true;
    });
  }
}
