
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/allControllers/controller_vpn_location.dart';
import 'package:get/get.dart';


import '../allWidgets/vpn_location_card_widget.dart';


class AvailableVpnServersLocationScreen extends StatelessWidget
{
  //after creating the instance below, we need to remove the "const" in AvailableVpnServersLocation
  //const AvailableVpnServersLocation({super.key});
  AvailableVpnServersLocationScreen({super.key});

  //create an instance of our ControllerVPNLocation class
  final vpnLocationController = ControllerVPNLocation();

  loadingUIWidget()
  {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),

          const SizedBox(
            height: 8,
          ),
          Text(
            "Gathering free VPN Locations...",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  noVpnServerFoundUIWidget()
  {
    return Center(
      child: Text(
        "No VPNs Found, try again",
        style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  //Displaying the available servers on the available server screen
  vpnAvailableServersData()
  {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServersAvailableList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(3),
      itemBuilder: (context, index)
      {
        //The free server locations are displayed with the help of the vpn_location_card_widget as it passes a parameter, therefore
        // the vpnInfo that is return here as parameter is the vpnInfo that is received in vpn_location_card_widget at Point 2
        //Point 2
        return VpnLocationCardWidget(vpnInfo: vpnLocationController.vpnFreeServersAvailableList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context)
  {
    //if the vpnFreeServersAvailableList is empty, we call the retrieveVpnInformation() method which
    //retrieves all available servers
    if(vpnLocationController.vpnFreeServersAvailableList.isEmpty)
      {
        vpnLocationController.retrieveVpnInformation();
      }
    //Now, display the locations on the User Interface for the user to see
    return Obx(()=> Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        //displays the location number here
        title: Text(
          "VPN Locations (" + vpnLocationController.vpnFreeServersAvailableList.length.toString() + ")",
        ),
      ),
      body: vpnLocationController.isLoadingNewLocations.value
          ? loadingUIWidget()
          : vpnLocationController.vpnFreeServersAvailableList.isEmpty
          ? noVpnServerFoundUIWidget()
          : vpnAvailableServersData(),
    ));
  }
}
