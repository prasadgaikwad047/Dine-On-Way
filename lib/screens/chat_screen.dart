import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/* 
void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
} */

class ChatScreen extends StatefulWidget {
  final QueryDocumentSnapshot finalorderdoc;

  final user;
  ChatScreen({super.key, required this.finalorderdoc, required this.user});
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  //late Stream<QuerySnapshot> messagecollectionRef;

  CollectionReference referenceOrderList =
      FirebaseFirestore.instance.collection('order list');
  @override
  /*  void initState() {
    super.initState();
    String orderId = widget.finalorderdoc.id;
    final orderdocref = referenceOrderList.doc(orderId);
    final messagecollectionRef = orderdocref.collection('messages');
  } */

  void _sendMessage() {
    String orderId = widget.finalorderdoc.id;
    final orderdocref = referenceOrderList.doc(orderId);
    final messagecollectionref = orderdocref.collection('messages');
    messagecollectionref.add({
      'text': _textController.text,
      'createdAt': Timestamp.now(),
      'sender': widget.user,
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 0,
        title: const Text(
          '              Message Us',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.shade800,
              Colors.black87,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                //stream: FirebaseFirestore.instance
                //  .collection('messages')
                stream: (referenceOrderList.doc(widget.finalorderdoc.id))
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong.'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message['sender'] == widget.user;

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blueGrey[800] : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['text'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                (message['createdAt'].toDate().toString())
                                    .substring(0, 16),
                                style: TextStyle(
                                  color: isMe ? Colors.white70 : Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              color: Colors.black,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: _sendMessage,
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
