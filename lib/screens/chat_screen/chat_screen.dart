import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String image, userName, chatId;
  ChatScreen(
      {super.key,
      // required this.uid,
      required this.image,
      required this.userName,
      required this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendMessageNew() async {
    if (_messageController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .add({
        'sender': FirebaseAuth.instance.currentUser!.uid,
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      FirebaseFirestore.instance.collection('chats').doc(widget.chatId).update({
        'last_message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          // centerTitle: true,
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 25, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(15),
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[800]),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Block",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Block",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        onClosing: () {},
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey[200],
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    // .orderBy('timestamp')
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'send massege now 😊',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  final chatDocs = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: chatDocs.length,
                      itemBuilder: (ctx, index) => ListTile(
                        title: Align(
                          alignment: chatDocs[index]['sender'] ==
                                  _auth.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: chatDocs[index]['sender'] ==
                                      _auth.currentUser!.uid
                                  ? Colors.blue
                                  : Colors.grey[850],
                            ),
                            child: Text(
                              chatDocs[index]['message'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.blue,
                      controller: _messageController,
                      decoration: InputDecoration(
                        prefixIcon:
                            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                        hintText: 'Type a message...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      _sendMessageNew();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
