import 'dart:typed_data';
import 'package:ar_visionary_explora/main/home/apiConsumer/api_consumer.dart';
import 'package:ar_visionary_explora/main/home/screeen/home.dart';
import 'package:ar_visionary_explora/utils/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:lottie/lottie.dart';

class ItemUploadScreen extends StatefulWidget {
  const ItemUploadScreen({super.key});

  @override
  State<ItemUploadScreen> createState() => _ItemUploadScreenState();
}

class _ItemUploadScreenState extends State<ItemUploadScreen> {
  Uint8List? imageFileUint8List;

  TextEditingController sellerNameTextEditingController =
      TextEditingController();
  TextEditingController sellerPhoneTextEditingController =
      TextEditingController();
  TextEditingController itemNameTextEditingController = TextEditingController();
  TextEditingController itemDescriptionTextEditingController =
      TextEditingController();
  TextEditingController itemPriceTextEditingController =
      TextEditingController();

  bool isUploading = false;
  String downloadUrlOfUploadedImage = "";

  //upload form screen
  Widget uploadFormScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Upload new Item",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
                onPressed: () {
                  //validate upload fields
                  if (isUploading != true) {
                    // false
                    validateUploadFormAndUploadItemInfo();
                  }
                },
                icon: const Icon(Icons.cloud_upload),
                color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        children: [
          isUploading == true
              ? const LinearProgressIndicator(
                  color: Colors.purpleAccent,
                )
              : Container(),

          //image
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
                child: imageFileUint8List != null
                    ? Image.memory(
                        imageFileUint8List!,
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      )),
          ),

          const Divider(
            color: Colors.black,
            thickness: 2,
          ),

          //seller name

          ListTile(
            leading: const Icon(
              Icons.person_pin_rounded,
              color: Colors.black,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: sellerNameTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "seller name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: sellerPhoneTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "seller phone",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.black,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: itemNameTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "item name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.black,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.grey,
                ),
                controller: itemDescriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: "item description",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.price_change,
              color: Colors.black,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  controller: itemPriceTextEditingController,
                  decoration: const InputDecoration(
                    hintText: "item Price",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  )),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  validateUploadFormAndUploadItemInfo() async {
    print("Conditions met. Uploading...");
    if (imageFileUint8List != null) {
      if (sellerNameTextEditingController.text.isNotEmpty &&
          sellerPhoneTextEditingController.text.isNotEmpty &&
          itemNameTextEditingController.text.isNotEmpty &&
          itemPriceTextEditingController.text.isNotEmpty) {
        print("Conditions met. Uploading...");
        setState(() {
          isUploading = true;
        });
        //upload image to firebase storage
        String imageUniqueName =
            DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference firebaseStorageRef = fStorage
            .FirebaseStorage.instance
            .ref()
            .child("ItemsImages")
            .child(imageUniqueName);

        fStorage.UploadTask uploadTaskImageFile =
            firebaseStorageRef.putData(imageFileUint8List!);

        fStorage.TaskSnapshot taskSnapshot =
            await uploadTaskImageFile.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((imageDownloadUrl) {
          downloadUrlOfUploadedImage = imageDownloadUrl;
        });

        //save item info to firestore database
        saveItemInfoToFireStore();
      } else {
        print("Validation failed. Please complete all fields.");
        Fluttertoast.showToast(
            msg: "Please complete upload form. Every field is mandatory");
      }
    } else {
      print("Validation failed. Image file is null.");
      Fluttertoast.showToast(msg: "Please select image file");
    }
  }

  saveItemInfoToFireStore() {
    String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseFirestore.instance.collection("items").doc(itemUniqueId).set({
      "itemID": itemUniqueId,
      "itemName": itemNameTextEditingController.text,
      "itemDescription": itemDescriptionTextEditingController.text,
      "itemImage": downloadUrlOfUploadedImage,
      "sellerName": sellerNameTextEditingController.text,
      "sellerPhone": sellerPhoneTextEditingController.text,
      "itemPrice": itemPriceTextEditingController.text,
      "publishedDate": DateTime.now(),
      "status": "available",
    });

    Fluttertoast.showToast(msg: "your new item upload successfully");
    setState(() {
      isUploading = false;
      imageFileUint8List = null;
    });

    Navigator.push(context, MaterialPageRoute(builder: (c) => const Home()));
  }

  // default screen
  Widget defaultScreen() {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Upload New Item",
          style: TextStyle(
            color: Color.fromARGB(255, 217, 129, 85),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //add lotie cameraAnimation json file
            Lottie.asset(
              "assets/lottie/cameraAnimation.json",
              width: 400,
              height: 200,
            ),

            // const Icon(
            //   Icons.add_photo_alternate,
            //   color: Colors.black54,
            //   size: 200,
            // ),
            ElevatedButton(
              onPressed: () {
                showDialogBox();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text(
                "Scan New Item",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (e) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Item Image",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureImageWithPhoneCamera();
              },
              child: const Text(
                "Capture Image with Camera",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                chooseImageFromPhoneGallery();
              },
              child: const Text(
                "Choose image from Gallary",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  captureImageWithPhoneCamera() async {
    Navigator.pop(context);

    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();
        // remove background from image
        // make image transparent
        imageFileUint8List =
            await ApiConsumer().removeImageBackgroundApi(imagePath);

        setState(() {
          imageFileUint8List;
        });
      }
    } catch (errorMsg) {
      print(
        errorMsg.toString(),
      );
      setState(() {
        imageFileUint8List == null;
      });
    }
  }

  chooseImageFromPhoneGallery() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove background from image
        // make image transparent
        imageFileUint8List =
            await ApiConsumer().removeImageBackgroundApi(imagePath);

        setState(() {
          imageFileUint8List;
        });
      }
    } catch (errorMsg) {
      print(
        errorMsg.toString(),
      );
      setState(() {
        imageFileUint8List == null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageFileUint8List == null ? defaultScreen() : uploadFormScreen();
  }
}
