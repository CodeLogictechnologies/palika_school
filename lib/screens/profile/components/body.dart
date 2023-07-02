import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palika_school/providers/auth_providers.dart';
import 'package:palika_school/services/auth_service.dart';
import 'package:palika_school/widgets/table/custom_button.dart';
import 'package:tuple/tuple.dart';

import '../../../providers/settings_providers.dart';
import '../../home/home_screen.dart';

class Body extends ConsumerStatefulWidget {
  const Body({super.key});

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> {
  final storage = const FlutterSecureStorage();
  File? selectedImage;
  bool loading = false;
  String? profilename;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => selectedImage = imageTemporary);
    } on PlatformException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> showChooseImageUploadMethod(context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pickImage(ImageSource.gallery),
                        child: Column(
                          children: [
                            Icon(Icons.collections_outlined, size: 50),
                            SizedBox(height: 10),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => pickImage(ImageSource.camera),
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt_outlined, size: 50),
                            SizedBox(height: 10),
                            Text(
                              'Take Photo',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void handleProfileUpdate(String id, String name) async {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    setState(() {
      loading = true;
    });
    try {
      final response = await ref.read(
          updateProfileProvider(Tuple3(id, profilename ?? name, selectedImage))
              .future);
      if (response == true) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } catch (err) {
      final snackBar = SnackBar(content: Text(err.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(getAuthenticatedUserProvider);

    void checkAuth() async {
      final authStorage = await storage.read(key: 'auth');
    }

    return ref.watch(profileProvider).when(data: (data) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Form(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showChooseImageUploadMethod(context);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(width: 1, color: Color(0xFFC6CACD))),
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: FadeInImage(
                            image: (selectedImage != null
                                    ? FileImage(selectedImage as File)
                                    : NetworkImage(data?.profilephoto ?? ''))
                                as ImageProvider,
                            placeholder:
                                AssetImage('assets/images/thumbnail.png'),
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/thumbnail.png'),
                          ),
                        ),
                        Positioned(
                            bottom: -4,
                            right: 35,
                            child: Icon(Icons.camera_alt_rounded,
                                color: Color(0xFF8D8D8D)))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(data?.profilename ?? ''),
                Text(data?.designationname ?? ''),
                SizedBox(
                  height: 20,
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: Text(
                    'Information',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  onChanged: (value) {
                    profilename = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                  initialValue: data?.profilename,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Address",
                  ),
                  enabled: false,
                  initialValue: data?.localaddress,
                ),
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone number",
                  ),
                  enabled: false,
                  initialValue: data?.mobilenumber,
                ),
                SizedBox(height: 15),
                CustomButtom(
                    text: 'Update',
                    onPressed: () {
                      handleProfileUpdate(data?.profileid?.toString() ?? '',
                          data?.profilename ?? '');
                    }),
              ],
            ),
          )),
        ),
      );
    }, error: (error, err) {
      return Container(
        child: Center(
          child: Text("ERROR"),
        ),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
