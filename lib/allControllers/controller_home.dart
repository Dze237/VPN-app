import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allModels/vpn_configuration.dart';
import 'package:vpn_basic_project/allModels/vpn_info.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';
import 'package:vpn_basic_project/vpnEngine/vpn_engine.dart';

class ControllerHome extends GetxController
{
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;


  //method to check if connected to vpn or not and the action to take in each state
  //We added "async" after the method because we are waiting for the response of that method
  void connectToVpnNow() async
  {
    if(vpnInfo.value.base64OpenVPNConfigurationData.isEmpty)
      {
        Get.snackbar("Country / Location", "Please select country or location first.");
        return;
      }

    //if the connection state is disconnected
    //if vpn is in disconnected mode, then the user is ready to start the vpn, so we start the vpn with the method below
    if(vpnConnectionState.value == VpnEngine.vpnDisconnectedNow)
      {
        //then get vpn data
        final dataConfigVpn = Base64Decoder().convert(vpnInfo.value.base64OpenVPNConfigurationData);
        final configuration = Utf8Decoder().convert(dataConfigVpn);

        final vpnConfiguration = VpnConfiguration(
            username: "",
            password: "",
            countryName: vpnInfo.value.countryLongName,
            config: configuration
        );
        await VpnEngine.startVpnNow(vpnConfiguration);
      }
    //else if the vpn connection is already established and running, we do stop the vpn as can be seen in the method below
    else
    {
      await VpnEngine.stopVpnNow();
    }

  }

  //This is to change the color of the button when the user starts the vpn
  Color get getRoundVpnButtonColor
  {
    switch(vpnConnectionState.value)
    {
      //If the vpn connection is disconnected the following color is shown
      case VpnEngine.vpnDisconnectedNow:
        return Colors.red;

      //If the vpn connection is connected already, the following color is shown
      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      //If the vpn connection is neither connected or disconnected
      default:
        return Colors.orangeAccent;
    }
  }

  //Now we input the Messages for those buttons
  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
    //If the vpn connection is disconnected the following text is shown
      case VpnEngine.vpnDisconnectedNow:
        return "Tap to Connect";

    //If the vpn connection is connected already, the following text is shown
      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

    //If the vpn connection is neither connected or disconnected
      default:
        return "Connecting....";
    }
  }
}

//After this Controller has been configured, we can setup our home screen according to this configuration
//Note, to use this controller in the home page, you will need to create an instance of the controller