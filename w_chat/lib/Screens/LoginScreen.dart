import 'package:flutter/material.dart';
import 'package:w_chat/Model/ChatModel.dart';
import 'package:w_chat/CustomUI/ButtonCard.dart';
import 'package:w_chat/Screens/Homescreen.dart';

class LoginScreen extends StatefulWidget{
  LoginScreen ({Key? key}) : super(key : key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Ege",
      icon: "person.svg",
      time: "00.37",
      currentMessage: "Hi my friend",
      availablePlace: "full",
      id: 1
    ),
    ChatModel(
      name: "Maruf",
      icon: "person.svg",
      time: "00.35",
      currentMessage: "Welcome to my java  tutorial",
      availablePlace: "full",
      id: 2
    ),
    ChatModel(
      name: "Umit",
      icon: "person.svg",
      time: "00.33",
      currentMessage: "Chat i bitirdin mi?",
      availablePlace: "full",
      id: 3
    ),
    ChatModel(
      name: "Berk",
      icon: "person.svg",
      time: "00.30",
      currentMessage: "API boi",
      availablePlace: "full",
      id: 4
    ),
    ChatModel(
      name: "Onat",
      icon: "person.svg",
      time: "00.27",
      currentMessage: "query ler bitti ibo",
      availablePlace: "empty",
      id: 5
    ),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: (){
            sourceChat = chatmodels.removeAt(index);
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (builder) => Homescreen(
                chatmodels:chatmodels,
                sourcechat: sourceChat,
              )
            ));
          },
          child: ButtonCard(
            name: chatmodels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}