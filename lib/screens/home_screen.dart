import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shazly_chat/helpers.dart';
import 'package:shazly_chat/pages/calls_page.dart';
import 'package:shazly_chat/pages/contacts_page.dart';
import 'package:shazly_chat/pages/messages_page.dart';
import 'package:shazly_chat/pages/notifications_page.dart';
import 'package:shazly_chat/theme.dart';
import 'package:shazly_chat/widgets/avatar.dart';
import 'package:shazly_chat/widgets/glowing_action_button.dart';
import 'package:shazly_chat/widgets/icon_buttons.dart';

 class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  final  ValueNotifier<int> pageIndex =ValueNotifier(0);
  final  ValueNotifier<String> title =ValueNotifier('Messages');

 



final pages = const [
   MessagesPage(),
    ContactPage(),

   CallsPage(),
   NotificationsPage(),
  
];

final pagesTitle =const[
    'Messages',
    'Contacts',
    'Calls',
    'Notifications',
    
];


   void _onItemSelected(index) {
    title.value = pagesTitle[index];
          pageIndex.value=index;
          }

   @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
        appBar: AppBar(
          iconTheme:Theme.of(context).iconTheme ,
          centerTitle: true,
          title: ValueListenableBuilder( 
            builder: ((BuildContext context, String value, _) {
              return Text(
               value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              
            );} ),
            valueListenable: title,
           
          ),
        elevation: 0,
        backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:24.0),
              child: Avatar.small(
                url: Helpers.randomPictureUrl(),
              ),
            ),
          ],


          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: Icons.search, onTap: () {
// TO DO SEARCH
              },),
          ),
          leadingWidth: 54, toolbarTextStyle: Theme.of(context).textTheme.bodyText2, titleTextStyle: Theme.of(context).textTheme.headline6,
        ),
      
        body: ValueListenableBuilder(
          builder: ((BuildContext context, int value, _) => pages[value]),
          valueListenable: pageIndex,
        ),
      bottomNavigationBar: _BottomNavigationBar(
          onItemSelected: _onItemSelected,
          
        )
      )
  ;
  }

}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key, required this.onItemSelected,
  }) : super(key: key);
final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
var selectedIndex=0;
void handelItemSelected(int index){

  setState(() {
      selectedIndex = index;
  });
    widget.onItemSelected(index);
}

  @override
  Widget build(BuildContext context) {
    final brightness= Theme.of(context).brightness;
    return Card(
      elevation: 0,
    color: 
    (brightness == Brightness.light) ? Colors.transparent : null,
      margin: const EdgeInsets.all(8),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                _NavigationBarItem( 
                  isSelected:(selectedIndex==0) ,
                  onTap: handelItemSelected,
                  index: 0,
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  message: 'Messaging',
    
                ),
                                _NavigationBarItem(
                  isSelected: (selectedIndex == 1),
                  onTap: handelItemSelected,
                  index: 1,
                  message: 'Contacts',
                  icon: CupertinoIcons.person_2_fill,
                ),
                GlowingActionButton(
                    color: AppColors.secondary,
                    icon: CupertinoIcons.add,
                    onPressed: () {}),

               
                _NavigationBarItem( 
                  isSelected: (selectedIndex==2),
                  onTap:handelItemSelected,
                  index: 2,
                  message: 'Calls',
                  icon: CupertinoIcons.phone_fill ,
                ),
                _NavigationBarItem(
                  isSelected: (selectedIndex==3),
                  onTap: handelItemSelected,
                  index: 3,
                  message: 'Notifications',
                  icon: CupertinoIcons.bell_solid,
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}



class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.message,
    required this.icon, 
    required this.index,

    required this.onTap,
    this.isSelected = false,


  }) : super(key: key);
final String message;
final IconData icon;
final int index;
final bool isSelected;
final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
       onTap(index);
        },
      child: SizedBox(
        height: 50,
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style:isSelected? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: isSelected ? AppColors.secondary : null,
                    )
                  : const TextStyle(fontSize: 11),
            ),
      
      
          ],
        ),
      ),
    );
  }
}
