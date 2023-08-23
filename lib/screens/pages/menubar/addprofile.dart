// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:stash_project/core/constants.dart';
// import 'package:stash_project/db/profile/profile_db.dart';
// import 'package:stash_project/models/profile/profile_model.dart';

// class AddProfile extends StatefulWidget {
//   const AddProfile({super.key});

//   @override
//   State<AddProfile> createState() => _AddProfileState();
// }

// class _AddProfileState extends State<AddProfile> {
//   final namecntrl = TextEditingController();
//   final emailcntrl = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   File? image;
//   Future getImage(ImageSource source) async {
//     final image = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (image == null) return;
//     final imageTemporary = File(image.path);

//     setState(() => this.image = imageTemporary);
//     log('Ram');
//     // photo = File(image.path);
//   }

//   Future gallery(ImageSource source) async {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image == null) return;
//     final imageTemporary = File(image.path);

//     setState(() => this.image = imageTemporary);
//     // photo = File(image.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mainColor,
//         title: const Text('Add Profile'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Form(
//             key: formKey,
//             child: ListView(
//               children: [
//                 const SizedBox(
//                   height: 80,
//                 ),
//                 CircleAvatar(
//                     radius: 100,
//                     backgroundImage: image == null
//                         ? const AssetImage('assets/man.jpg')
//                         : FileImage(File(image!.path)) as ImageProvider),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(65, 5, 55, 5),
//                         child: CustomButton(
//                           title: 'Gallary',
//                           icon: Icons.image_outlined,
//                           onClick: () => gallery(ImageSource.gallery),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(65, 5, 55, 5),
//                         child: CustomButton(
//                           title: 'Cemara',
//                           icon: Icons.camera,
//                           onClick: () => getImage(ImageSource.camera),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: namecntrl,
//                   keyboardType: TextInputType.name,
//                   decoration: const InputDecoration(
//                       hintText: 'Name',
//                       suffixIcon: Icon(Icons.person),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)))),
//                   validator: (value) {
//                     if (namecntrl.text.isEmpty) {
//                       return 'Name Field is Empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 TextFormField(
//                   controller: emailcntrl,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                       hintText: 'email',
//                       suffixIcon: Icon(Icons.email_outlined),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)))),
//                   validator: (value) {
//                     if (emailcntrl.text.isEmpty ||
//                         !emailcntrl.text.contains("@")) {
//                       return 'enter a valid eamil';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(224, 11, 9, 12)),
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       if (image?.path == null) {
//                         addingFailed();
//                       } else {
//                         addingSuccess();
//                       }
//                     }
//                   },
//                   child: const Text('Submit'),
//                 )
//               ],
//             )),
//       )),
//     );
//   }

//   void addingFailed() {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text("Please add the pofile picture!"),
//       backgroundColor: Colors.red,
//       margin: EdgeInsets.all(10),
//       behavior: SnackBarBehavior.floating,
//       showCloseIcon: true,
//       closeIconColor: Colors.white,
//       duration: Duration(seconds: 2),
//     ));
//   }

//   Future<void> addingSuccess() async {
//     ProfileModel student = ProfileModel(
//       image: image!.path,
//       name: namecntrl.text.trim(),
//       email: emailcntrl.text.trim(),
//       id: DateTime.now().microsecondsSinceEpoch,
//     );
//     await addprofile(student);

//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('${namecntrl.text} is added to database successfully!'),
//       backgroundColor: Colors.green,
//       margin: const EdgeInsets.all(10),
//       behavior: SnackBarBehavior.floating,
//       showCloseIcon: true,
//       closeIconColor: Colors.white,
//       duration: const Duration(seconds: 2),
//     ));
//     image = null;
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pop();
//   }
// }

// // ignore: non_constant_identifier_names
// Widget CustomButton({
//   required String title,
//   required IconData icon,
//   required VoidCallback onClick,
// }) {
//   return SizedBox(
//     child: ElevatedButton(
//       onPressed: onClick,
//       child: Row(
//         children: [
//           Icon(icon),
//           const SizedBox(
//             width: 25,
//           ),
//           Text(title),
//         ],
//       ),
//     ),
//   );
// }
