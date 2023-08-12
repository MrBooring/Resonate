
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:resonate/controllers/single_room_controller.dart';

import '../../models/participant.dart';

class ParticipantBlock extends StatelessWidget {
  ParticipantBlock({
    super.key,
    required this.participant,
    required this.controller,
  });

  final Participant participant;
  SingleRoomController controller;

  String getUserRole() {
    if (participant.isAdmin) {
      return "Admin";
    } else if (participant.isModerator) {
      return "Moderator";
    } else if (participant.isSpeaker) {
      return "Speaker";
    } else {
      return "Listener";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      onPressed: () {},
      menuItemExtent: 0.109*Get.width,
      menuWidth: 0.43753*Get.width,
      menuBoxDecoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.amber,
          width: 0.0024*Get.width,
        ),
      ),
      duration: const Duration(milliseconds: 100),
      animateMenuItems: true,
      blurBackgroundColor: Colors.black54,
      menuItems: (controller.me.value.isAdmin)
          ? (participant.isAdmin)
              ? []
              : [
                  if (participant.hasRequestedToBeSpeaker)
                    FocusedMenuItem(
                        title:  Text(
                          "Add Speaker",
                          style: TextStyle(color: Colors.amber, fontSize: 0.0085 * Get.height + 0.017 * Get.width),
                        ),
                        trailingIcon:  Icon(
                          Icons.record_voice_over,
                          color: Colors.green,
                        size: 0.02187*Get.width+0.01095*Get.height,
                        ),
                        onPressed: () {
                          controller.makeSpeaker(participant);
                        },
                        backgroundColor: Colors.black),
                  if (participant.isSpeaker)
                    FocusedMenuItem(
                        title: Text(
                          "Make Listener",
                          style: TextStyle(color: Colors.amber, fontSize: 0.0085 * Get.height + 0.017 * Get.width),
                        ),
                        trailingIcon: Icon( 
                          Icons.mic_off_sharp,
                          color: Colors.red,
                                                  size: 0.02187*Get.width+0.01095*Get.height,
                        ),
                        onPressed: () {
                          controller.makeListener(participant);
                        },
                        backgroundColor: Colors.black),
                  FocusedMenuItem(
                      title:  Text(
                        "Kick Out",
                        style: TextStyle(color: Colors.amber,  fontSize: 0.0085 * Get.height + 0.017 * Get.width),
                      ),
                      trailingIcon:  Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                                                size: 0.02187*Get.width+0.01095*Get.height,
                      ),
                      onPressed: () {
                        controller.kickOutParticipant(participant);
                      },
                      backgroundColor: Colors.black),
                ]
          : [],
      openWithTap:
          (controller.me.value.isAdmin && !participant.isAdmin) ? true : false,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.00243*Get.height, horizontal: 0.00486*Get.width),
        alignment: Alignment.center,
        child: Column(
          children: [
            CircleAvatar(
              radius: 0.01947*Get.height+0.03889*Get.width,
              backgroundColor: Colors.amber,
              child: CircleAvatar(
                backgroundImage: NetworkImage(participant.dpUrl),
                  radius: 0.0364*Get.width+0.01825*Get.height,
                child: (participant.hasRequestedToBeSpeaker)
                    ? Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.waving_hand_rounded,
                              color: Colors.amber,
                              size: 0.012*Get.height+0.024*Get.width,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (participant.isSpeaker)
                  Icon(
                    (participant.isMicOn) ? Icons.mic : Icons.mic_off,
                    color: (participant.isMicOn) ? Colors.lightGreenAccent : Colors.red,
                    size: 0.01*Get.height+0.0218*Get.width,
                  ),
                Text(
                  participant.name.split(' ').first,
                  style: TextStyle(color: Colors.white, fontSize: 0.01944*Get.width+0.009735),
                ),
              ],
            ),
            Text(
              getUserRole(),
              style: TextStyle(color: Colors.grey,  fontSize: 0.0085 * Get.height + 0.017 * Get.width),
            )
          ],
        ),
      ),
    );
  }
}