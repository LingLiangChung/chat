import 'package:chat/controllers/chatController.dart';
import 'package:chat/models/Chat.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {

  final int receiverUserID;

  const ChatDetailPage({Key? key, required this.receiverUserID}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(receiverUserID);
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  final int receiverUserID;

  _ChatDetailPageState(this.receiverUserID);

  Future<List<Chat>>? futureChatList;
  TextEditingController textMessageController = TextEditingController();
  int currentLoggedInUserID = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserChatDetail();
  }

  Future getUserChatDetail() async {
    List<Chat> chatList = await getChatUser(receiverUserID);
    setState(() {
      futureChatList = Future.value(chatList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ling",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                ),
                Icon(Icons.settings, color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<List<Chat>>(
            future: futureChatList,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    bool isCurrentUser = snapshot.data![index].chatReceiverUserID != currentLoggedInUserID ? true : false;
                    return ChatList(chat: snapshot.data![index], currentLogInUserID: currentLoggedInUserID);
                  },
                );
              }else{
                return Text('Loading...');
              }
            }
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: textMessageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      sendMessage(receiverUserID, textMessageController.text);
                      textMessageController.clear();
                      getUserChatDetail();
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatelessWidget {

  final Chat chat;
  final int currentLogInUserID;
  const ChatList({Key? key, required this.chat, required this.currentLogInUserID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = chat.chatReceiverUserID != currentLogInUserID ? true : false;
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (!isCurrentUser ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (!isCurrentUser ? Colors.grey.shade200:Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            chat.chatMessage!,
            style: TextStyle(
                fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}

