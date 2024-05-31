// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter/models/profile_model.dart';
import 'package:flutter_starter/models/user_model.dart';
import 'package:flutter_starter/services/auth_service.dart';
import 'package:flutter_starter/services/profile_service.dart';
import 'package:flutter_starter/shared/custom_snackbar.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late UserModel user;
  late ProfileModel profile;
  String avatar = "";
  final _formKey = GlobalKey<FormState>();
  bool _isModified = false;

  late TextEditingController _genderController;
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _birthdayController;
  late TextEditingController _professionController;
  late TextEditingController _familySituationController;

  @override
  void initState() {
    super.initState();
    user = Provider.of<AuthService>(context, listen: false).connectedUser!;

    profile = Provider.of<ProfileService>(context, listen: false).profile!;

    _genderController = TextEditingController(text: profile.gender);
    _firstnameController = TextEditingController(text: profile.firstname);
    _lastnameController = TextEditingController(text: profile.lastname);
    _phoneController = TextEditingController(text: profile.phone);
    _birthdayController = TextEditingController(text: profile.birthday);
    _professionController = TextEditingController(text: profile.profession);
    _familySituationController =
        TextEditingController(text: profile.family_situation);

    _genderController.addListener(_checkForModifications);
    _firstnameController.addListener(_checkForModifications);
    _lastnameController.addListener(_checkForModifications);
    _phoneController.addListener(_checkForModifications);
    _birthdayController.addListener(_checkForModifications);
    _professionController.addListener(_checkForModifications);
    _familySituationController.addListener(_checkForModifications);
  }

  void _checkForModifications() {
    final isModified = _genderController.text != profile.gender ||
        _firstnameController.text != profile.firstname ||
        _lastnameController.text != profile.lastname ||
        _phoneController.text != profile.phone ||
        _birthdayController.text != profile.birthday ||
        _professionController.text != profile.profession ||
        _familySituationController.text != profile.family_situation;

    if (isModified != _isModified) {
      setState(() {
        _isModified = isModified;
      });
    }
  }

  @override
  void dispose() {
    _genderController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    _professionController.dispose();
    _familySituationController.dispose();
    super.dispose();
  }

  // void _updateImage(File newImage) async {
  //   final imageId = await UploadFileService()
  //       .uploadPicture(newImage, _firstnameController.text);
  //   if (imageId != null) {
  //     final imageUrl = "${Constants.uriAssets}/$imageId";

  //     user.avatar = imageUrl;

  //     final bool success = await ProfilService().updateProfil(user);
  //     if (success) {
  //       CustomSnackBar(
  //         level: 'success',
  //         message: 'User avatar was updated with success',
  //         duration: 2,
  //       ).display(context);
  //       setState(() {
  //         avatar = imageUrl;
  //       });
  //     } else {
  //       CustomSnackBar(
  //         level: 'error',
  //         message: 'Error while updating user avatar',
  //         duration: 2,
  //       ).display(context);
  //     }
  //   } else {
  //     CustomSnackBar(
  //       level: 'error',
  //       message:
  //           '“An error occurred during the transfer of the avatar picture”',
  //       duration: 2,
  //     ).display(context);
  //   }
  // }

  void _updateProfile() async {
    if (_isModified) {
      profile.gender = _genderController.text;
      profile.firstname = _firstnameController.text;
      profile.lastname = _lastnameController.text;
      profile.phone = _phoneController.text;
      profile.birthday = _birthdayController.text;

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Update profile'),
                content: Text('Are you sure you want update your profile?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('No', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Yes', style: TextStyle(color: Colors.green)),
                    onPressed: () async {
                      final bool success =
                          await ProfileService(context).updateProfile(profile);
                      if (success) {
                        CustomSnackBar(
                          level: 'success',
                          message: 'Profile updated with success',
                          duration: 3,
                        ).display(context);
                      } else {
                        CustomSnackBar(
                          level: 'error',
                          message: 'Error while updating profile',
                          duration: 3,
                        ).display(context);
                      }
                      Navigator.of(context).pop();
                      setState(() {
                        _isModified = false;
                      });
                    },
                  )
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                // child: GestureDetector(
                //   onTap: () {
                //     showModalBottomSheet(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return ImagePickerModal(
                //           onChoice: (source) async {
                //             final picker = ImagePicker();
                //             final pickedFile = await picker.pickImage(
                //               source: source,
                //               maxHeight: 600,
                //               maxWidth: 600,
                //               imageQuality: 50,
                //             );
                //             if (pickedFile != null) {
                //               _updateImage(File(pickedFile.path));
                //             }
                //           },
                //         );
                //       },
                //     );
                //   },
                //   child: user.avatar != null
                //       ? CircleAvatar(
                //           radius: 80, backgroundImage: NetworkImage(user.avatar!))
                //       : CircleAvatar(
                //           radius: 80,
                //           backgroundImage: AssetImage(
                //             _genderController.text == "M"
                //                 ? "lib/shared/img/man.png"
                //                 : "lib/shared/img/woman.png",
                //           ),
                //         ),
                // ),
                ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: _genderController.text,
                    onChanged: (newValue) {
                      setState(() {
                        _genderController.text = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: "M",
                        child: Text("M"),
                      ),
                      DropdownMenuItem(
                        value: "F",
                        child: Text("F"),
                      ),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person_outline),
                      labelText: 'Gender',
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _firstnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Firstname',
                    ),
                    validator: (value) {
                      final nameRegex = RegExp(r"^(?![- ])[a-zA-ZÀ-ÿ -]*[^-]$");
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!nameRegex.hasMatch(value)) {
                        return 'Special characters or numbers are not allowed';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                labelText: 'lastname',
              ),
              validator: (value) {
                final nameRegex = RegExp(r"^(?![- ])[a-zA-ZÀ-ÿ -]*[^-]$");
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } else if (!nameRegex.hasMatch(value)) {
                  return 'Special characters or numbers are not allowed';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.phone),
                labelText: 'Phone',
              ),
              validator: (value) {
                final phoneRegex = RegExp(r"^0\d{9}$");
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } else if (!phoneRegex.hasMatch(value)) {
                  return 'Phone number must be 10 digits long and begin with 0';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _birthdayController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.health_and_safety),
                labelText: 'birthday',
              ),
              validator: (value) {
                //! Regex à définir pour le champ birthday
                //* final birthdayRegex = RegExp();
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } //* else if (!phoneRegex.hasMatch(value)) { return 'errorMessage';}
                return null;
              },
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _professionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.work),
                labelText: 'Profession',
              ),
              validator: (value) {
                final nameRegex = RegExp(r"^(?![- ])[a-zA-ZÀ-ÿ -]*[^-]$");
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } else if (!nameRegex.hasMatch(value)) {
                  return 'Special characters or numbers are not allowed';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            TextFormField(
              controller: _familySituationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.family_restroom),
                labelText: 'Family situation',
              ),
              validator: (value) {
                final nameRegex = RegExp(r"^(?![- ])[a-zA-ZÀ-ÿ -]*[^-]$");
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                } else if (!nameRegex.hasMatch(value)) {
                  return 'Special characters or numbers are not allowed';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_isModified)
                  ElevatedButton.icon(
                    icon: Icon(Icons.update),
                    label: Text("Save modifications"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateProfile();
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
