import 'dart:core';
 
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shazly_chat/helpers.dart';
import 'package:shazly_chat/models/message_data.dart';
import 'package:shazly_chat/screens/chat_screen.dart';
import 'package:shazly_chat/theme.dart';

import '../models/story_data.dart';
import '../widgets/avatar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _delegate,
           
          ),
        )
      ],
    );
  }
}



Widget _delegate  (BuildContext context, int index ) {


  final Faker faker =Faker();
  final date = Helpers.randomDate();
  
  
  
  return _MessageTitle(


    messageData: MessageData(
      senderName: faker.person.name(),
      message: faker.lorem.sentence(),
       messageDate: date ,
       dateMessage: Jiffy(date).fromNow(),
      profilePicture: Helpers.randomPictureUrl(),
      ),

  );
            }

class _MessageTitle extends StatelessWidget {
   const _MessageTitle({required this.messageData});

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
        Navigator.of(context).push(
          ChatScreen.route(messageData),
        );
    },
      child: Container(
        margin: const EdgeInsets.all(8),
        height:100,
        decoration: const BoxDecoration(
            border: Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: .2
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                  url: messageData.profilePicture,
                ),
              ),
              Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    messageData.senderName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      letterSpacing: .2,
                      wordSpacing: 1.5,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  const SizedBox(height: 8),
                Text(
                    messageData.message,   
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textFaded,
                    ),
    ),
    
                
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -.2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFaded
                      ),
                    ),
                    const SizedBox(height:8),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                        
                      ),
                      child: const Center(
                          child: Text(
                        '1',
                        style: TextStyle(
                          color: AppColors.textLight,
                          fontSize: 10,
                        ),
                      )),
                    )
              
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60,
                        child: _StoryCard(
                            storyData: StoryData(
                                name: faker.person.name(),
                                url: Helpers.randomPictureUrl())),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
