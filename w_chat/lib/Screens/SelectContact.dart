import 'package:flutter/material.dart';
import 'package:w_chat/CustomUI/ContactCard.dart';
import 'package:w_chat/Model/ChatModel.dart';

class SelectContact extends StatefulWidget{
  SelectContact({Key? key}) : super(key: key);

  @override
  SelectContactState createState() => SelectContactState();
}

class SelectContactState extends State<SelectContact>{
  @override
  Widget build(BuildContext context){
    List<ChatModel> contacts = [
      ChatModel(
        name: "Onat",
        icon: "person.svg",
        time: "00.27",
        currentMessage: "query ler bitti ibo",
        availablePlace: "empty",
        id:5
      ),
      ChatModel(
        name: "Berk",
        icon: "person.svg",
        time: "00.30",
        currentMessage: "API boi",
        availablePlace: "full",
        id: 4
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon:Icon(Icons.search, size: 30,), onPressed: () {}),
          PopupMenuButton<String>(
              onSelected: (value){
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Invite your friend"),
                    value: "Invite", 
                  ),
                  PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh", 
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help", 
                  ),
                ];
              },
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context,index) => ContactCard(
          contact: contacts[index],
        ),
      ),
    );
  }
}
