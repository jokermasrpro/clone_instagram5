import 'package:clone_instagram/screens/chat_screen/chat_screen.dart';
import 'package:clone_instagram/shard/widgets/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllChatsScreen extends StatelessWidget {
  AllChatsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           createChat('ZR9gjtiWFjQu99xq0pvIppeawiR2');
        //         },
        //         icon: Icon(Icons.get_app))
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // custom app bar
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'option2') {}
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'option1',
                            child: Text('hide story'),
                          ),
                          PopupMenuItem<String>(
                            value: 'option2',
                            child: Text('delete story'),
                          ),
                        ];
                      },
                    );
                  },
                  child: Text(
                    "Chats",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "search...",
                    hintStyle: TextStyle(color: darkBorder),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .where('users',
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return ScaffoldMessenger(
                          child: SnackBar(
                              content: Text("${snapshot.error.toString()}")));
                    }

                    if (snapshot.hasData) {
                      final getUser = snapshot.data!.docs;
                      print("----------------------");
                      print(getUser);
                      return Expanded(
                        child: ListView.builder(
                          itemCount: getUser.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userMap =
                                snapshot.data!.docs[index].data();
                            print("=====================");
                            print(userMap);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                            image: userMap['userImage'],
                                            userName: userMap['userName'],
                                            chatId: userMap['chatId'])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 0, bottom: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(userMap['userImage']),
                                      radius: 30,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // userMap[index]['userName'],
                                          userMap['userName'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          userMap['last_message'],
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      timeago.format(
                                          userMap['timestamp'].toDate()),
                                      style:
                                          TextStyle(color: darkSecondaryText),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          PopupMenuButton<String>(
                                            onSelected: (value) {
                                              if (value == 'option1') {}
                                              if (value == 'option2') {}
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              return [
                                                PopupMenuItem<String>(
                                                  value: 'option1',
                                                  child: Text('hide story'),
                                                ),
                                                PopupMenuItem<String>(
                                                  value: 'option2',
                                                  child: Text('delete story'),
                                                ),
                                              ];
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.more_vert)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("null"),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
