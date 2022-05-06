import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:w_chat/Model/ChatModel.dart';

class ContactCard extends StatelessWidget{
  const ContactCard({Key? key, required this.contact}) : super (key : key);
  final ChatModel contact;
  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: (){},
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: SvgPicture.asset(
            "assets/person.svg", height: 30, width: 30,
          ),
          backgroundColor: Colors.blue,
        ),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          contact.availablePlace,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        
      ),
    );
  }
}