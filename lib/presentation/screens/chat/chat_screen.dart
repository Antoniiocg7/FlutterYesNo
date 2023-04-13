import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';


import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://imgs.search.brave.com/rwkvr-Jhu_VpP_UfJmXQJ0691AlIkZclAARMUl8-GmE/rs:fit:160:175:1/g:ce/aHR0cHM6Ly9jZG4u/ZnV0dXJhLXNjaWVu/Y2VzLmNvbS9idWls/ZHN2Ni9pbWFnZXMv/cHJvZmlsZWhlcm8v/ZC85L2EvZDlhMTA1/ODkxMF81MDE2MzE0/Ml9lbG9uLW11c2sx/LmpwZw"),
          ),
        ),
        title: const Text("Elon Musk"),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: ListView.builder( 
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                
              return (message.fromWho == FromWho.hers)
                ? HerMessageBubble(message: message) 
                : MyMessageBubble(message: message)
              ;
            },
            )),
            //Caja de texto de mensajes
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}