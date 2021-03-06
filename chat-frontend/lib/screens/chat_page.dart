import 'package:chat/controllers/chatController.dart';
import 'package:chat/models/User.dart';
import 'package:chat/models/chat_users_model.dart';
import 'package:chat/widgets/conversation_list.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Future<List<User>>? futureUserList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    List<User> userList = await getAllUser();
    setState(() {
      futureUserList = Future.value(userList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          "Conversation",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.pink[50],
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.pink,size: 20,),
                            SizedBox(width: 2,),
                            Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search ...",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: FutureBuilder<List<User>>(
                future: futureUserList,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return ConversationList(userID: snapshot.data![index].id!, username: snapshot.data![index].name!, email: snapshot.data![index].email!,);
                      },
                    );
                  }else{
                    return Text('Loading...');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
