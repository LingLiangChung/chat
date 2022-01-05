import 'package:chat/screens/chat_detail_page.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {

  final int userID;
  final String username;
  final String email;

  const ConversationList({Key? key, required this.userID, required this.username, required this.email}) : super(key: key);

  @override
  _ConversationListState createState() => _ConversationListState(userID, username, email);
}

class _ConversationListState extends State<ConversationList> {

  final int userID;
  final String username;
  final String email;

  _ConversationListState(this.userID, this.username, this.email);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatDetailPage(receiverUserID: userID);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                      maxRadius: 30,
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: 6,),
                            Text(
                              email, // used to be text message but I replace with user email
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            Text('10.30am',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
