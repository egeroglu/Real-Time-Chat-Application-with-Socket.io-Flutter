import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:w_chat/CustomUI/OwnMessageCard.dart';
import 'package:w_chat/CustomUI/ReplyCard.dart';
import 'package:w_chat/Model/ChatModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:w_chat/Model/MessageModel.dart';

class IndividualPage extends StatefulWidget{
  IndividualPage({Key? key, required this.chatmodel, required this.sourcechat}) : super(key:key);
  final ChatModel chatmodel;
  final ChatModel sourcechat;
  @override
  IndividualPageState createState() => IndividualPageState();
}

class IndividualPageState extends State<IndividualPage> {
  final IO.Socket _socket = IO.io('http://192.168.1.15:3000', IO.OptionBuilder().setTransports(['websocket']).build());

  _connectSocket(){
    _socket.emit("/signin",widget.sourcechat.id);
    _socket.onConnect((data) {
      print('Connection establish');
      _socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
      });
    });
    print(_socket.connected);
  }
  TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<MessageModel> messages = [];
  @override
  void initState(){
    super.initState();
    _connectSocket();
  }
  
void sendMessage(String message, int sourceId, int targetId){
  setMessage("source", message);
  _socket.emit("message",{
    "message": message, 
    "sourceId": sourceId, 
    "targetId": targetId
  });
}

void setMessage(String type, String message){
  MessageModel messageModel= MessageModel(type: type, message: message);
  setState(() {
    messages.add(messageModel);
  });
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 80, 146),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                    CircleAvatar(
                      child: SvgPicture.asset(
                        "assets/person.svg",
                        height: 37.0,
                        width: 37.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {
                  // NAVIGATE TO THE PROFILE
                },
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatmodel.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "last seen today at 12:37",
                        style: TextStyle(
                          fontSize: 13,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value){
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text("Settings"),
                        value: "Settings", 
                      ),
                      PopupMenuItem(
                        child: Text("Settings"),
                        value: "Settings", 
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 145,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context,index){
                      if(messages[index].type == "source"){
                        return OwnMessageCard(message: messages[index].message,);
                      }else {
                        return ReplyCard(message: messages[index].message);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          margin: EdgeInsets.only(left: 2,right: 2,bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25), 
                          ),
                          child: TextFormField(
                            controller: _controller,
                            focusNode: focusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              contentPadding: EdgeInsets.all(15),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.send,
                                ),
                                onPressed: () {
                                  sendMessage(_controller.text, widget.sourcechat.id, widget.chatmodel.id);
                                  _controller.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
