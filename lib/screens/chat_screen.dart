import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message-model.dart';
import '../helper/shared/provider/theme-provider.dart';
import '../widgets/chat_buble.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/image_buble.dart';
import 'package:provider/provider.dart';

class chatScreen extends StatelessWidget {
  static const String routeName = 'chatScreen';

  final ScrollController _controller = ScrollController();
  File? imageFile;
  String imageUrl = "";
  CollectionReference? messages;
  String? argEmail;
  String? contentMessage;

  chatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var themeprvider = Provider.of<themeProvider>(context);
    messages = FirebaseFirestore.instance.collection('messages');
    TextEditingController controller = TextEditingController();
    argEmail = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
        stream: messages?.orderBy('creatAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<messageModel> messgesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messgesList.add(messageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: themeprvider.isLight
                  ? const Color(0xFFCFCACE)
                  : const Color(0xFF183032),
              appBar: AppBar(
                title: const Text('Chat App'),
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: themeprvider.isLight
                    ? const Color(0xFF008069)
                    : const Color(0xFF1F2C34),
                actions: [
                  Image.asset(
                    'assets/images/icon.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  IconButton(
                      onPressed: () {
                        themeprvider.changeTheme();
                      },
                      icon: themeprvider.isLight
                          ? const Icon(
                              Icons.dark_mode_outlined,
                              size: 35,
                            )
                          : const Icon(
                              Icons.light_mode,
                              size: 35,
                            )),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemBuilder: (context, index) =>
                          messgesList[index].id == argEmail
                              ? messgesList[index].type == 2
                                  ? ImageBuble(
                                      messgesList[index],
                                    )
                                  : chatBuble(
                                      modelMassge: messgesList[index],
                                    )
                              : messgesList[index].type == 2
                                  ? imageBubleForFrind(
                                      messgesList[index],
                                    )
                                  : chatBubleForFrind(
                                      modelMassge: messgesList[index]),
                      itemCount: messgesList.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                          color: themeprvider.isLight
                              ? Colors.black
                              : Colors.white),
                      onSubmitted: (data) {
                        contentMessage = data;
                        messages?.add({
                          'message': contentMessage,
                          'creatAt': DateTime.now(),
                          'id': argEmail,
                          'type': 1
                        });
                        controller.clear();

                        _controller.animateTo(
                          0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themeprvider.isLight
                            ? Colors.white
                            : const Color(0xFF1F2C34),
                        hintText: 'Send Message',
                        hintStyle: TextStyle(
                            color: themeprvider.isLight
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            fontSize: 17),
                        prefixIcon: GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Icon(
                              Icons.image,
                              color: themeprvider.isLight
                                  ? Colors.grey
                                  : Colors.white,
                            )),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              {
                                messages?.add({
                                  'message': controller.text,
                                  'creatAt': DateTime.now(),
                                  'id': argEmail,
                                  'type': 1
                                });
                                controller.clear();

                                _controller.animateTo(
                                  0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn,
                                );
                              }
                            },
                            child: Icon(
                              Icons.send,
                              color: themeprvider.isLight
                                  ? Colors.grey
                                  : Colors.white,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        uploadFile();
      }
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = uploadFile1(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      onSendMessage(imageUrl, 2);
    } on FirebaseException {}
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      messages?.add({
        'message': content,
        'creatAt': DateTime.now(),
        'id': argEmail,
        'type': 2
      });
    }
  }

  UploadTask uploadFile1(File image, String fileName) {
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }
}
