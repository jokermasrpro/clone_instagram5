// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   String userName = '';
//   String userEmail = '';
//   String profileImageUrl = '';
//   String userId = ''; // ID للمستخدم الحالي
//   String currentUserId = ''; // ID للمستخدم الذي يتصفح التطبيق

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   // تحميل بيانات المستخدم
//   Future<void> _loadUserProfile() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;

//     if (currentUser != null) {
//       // حفظ ID المستخدم الحالي
//       currentUserId = currentUser.uid;

//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserId)
//           .get();

//       setState(() {
//         userName = userDoc['name'];
//         userEmail = userDoc['email'];
//         profileImageUrl = userDoc['profile_picture'] ?? '';
//         userId = currentUserId;
//       });
//     }
//   }

//   // بدء محادثة مع مستخدم آخر
//   void _startChat(String otherUserId, String otherUserName, String otherUserImage) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatPage(
//           userId: currentUserId,
//           otherUserId: otherUserId,
//           userName: userName,
//           otherUserName: otherUserName,
//           userImage: profileImageUrl,
//           otherUserImage: otherUserImage,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: profileImageUrl.isEmpty
//                   ? AssetImage('assets/default_profile.png')
//                   : NetworkImage(profileImageUrl) as ImageProvider,
//             ),
//             SizedBox(height: 20),
//             Text(userName, style: TextStyle(fontSize: 24)),
//             Text(userEmail, style: TextStyle(fontSize: 18)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // يمكنك هنا توجيه المستخدم إلى صفحة تعديل البيانات الشخصية
//               },
//               child: Text('Edit Profile'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // بدء محادثة مع مستخدم آخر (على سبيل المثال، مع مستخدم آخر من قائمة الأصدقاء أو المستخدمين)
//                 _startChat('otherUserId', 'Other User', 'https://someurl.com/image.jpg');
//               },
//               child: Text('Start Chat'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
