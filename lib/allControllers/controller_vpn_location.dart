import 'package:get/get.dart';
import 'package:vpn_basic_project/apiVpnGate/api_vpn_gate.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';

import '../allModels/vpn_info.dart';

class ControllerVPNLocation extends GetxController
{
  List<VpnInfo> vpnFreeServersAvailableList = AppPreferences.vpnList;

  final RxBool isLoadingNewLocations = false.obs;

  //retrieve the vpn information
  Future<void> retrieveVpnInformation() async
  {
    //for loading animation while waiting for the available servers to load up
    isLoadingNewLocations.value = true;

    //make sure your vpnServer list is empty and then we can get all the free vpn servers using our ApiVPNGate
    vpnFreeServersAvailableList.clear();

    //the below code will return the list as can be seen in the return statement of the ApiVpnGate class as can be seen on line 61
    //Then we now assign that list to our vpnFreeServersAvailableList
    vpnFreeServersAvailableList = await ApiVpnGate.retrieveAllAvailableVpnServers();

    //Once we get all those free available vpn servers, we have to set our boolean type variable to false, to stop the loading animation
    isLoadingNewLocations.value = false;
  }
}

//Next we need to create the screen to display the available free servers