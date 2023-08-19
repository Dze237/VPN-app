import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allControllers/controller_home.dart';
import 'package:vpn_basic_project/main.dart';

import '../allModels/vpn_info.dart';

class VpnLocationCardWidget extends StatelessWidget
{
  final VpnInfo vpnInfo;

  //This method and its parameters are passed to available_vpn_server_location to show the free VPN servers location/information
  //Point 2
  VpnLocationCardWidget({super.key, required this.vpnInfo,});


  //speedBytes is the variable used to receive the speeds for each vpn server
  String formatSpeedBytes(int speedBytes, int decimals)
  {
    if(speedBytes <= 0){
      return "0 B";
    }
    const suffixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];
    
    //here is the formular to convert the suffixsTitle speeds inorder to correctly measure the speed that will be gotten
    //from the speedBytes variable
    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();

    return "${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimals)} ${suffixesTitle[speedTitleIndex]}";
  }



  @override
  Widget build(BuildContext context)
  {
    final homeController = Get.find<ControllerHome>();

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: ()
        {

        },
        borderRadius: BorderRadius.circular(16),
        //ListTitle is a child of the return Card
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          //container to display our country flags on the left hand side
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              "countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 40,
              width: sizeScreen.width * .15,
              fit: BoxFit.cover,
            ),
          ),

          //country name
          title: Text(vpnInfo.countryLongName),

          //vpn speed
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                color: Colors.blueAccent,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              //Display the speed of our connection here with a text using the function implemented above
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),


          //number of sessions
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionNum.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).lightTextColor
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
