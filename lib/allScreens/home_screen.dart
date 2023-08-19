

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/allScreens/available_vpn_servers_location_screen.dart';
import 'package:vpn_basic_project/allWidgets/custom_widget.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';
import 'package:vpn_basic_project/allControllers/controller_home.dart';

import '../allModels/vpn_status.dart';
import '../main.dart';
import '../vpnEngine/vpn_engine.dart';

class HomeScreen extends StatelessWidget
{
  //const is removed from HomeScreen becuase of the instance declared below
  HomeScreen({super.key});

  //Creating the instance of the "controller_home" to enable its use here
  //Make sure the Get is imported because the Get will be used for this
  final homeController = Get.put(ControllerHome());

  locationSelectionBottomNavigation(BuildContext context)
  {
    return SafeArea(
      child: Semantics(
        button:true,
        child: InkWell(
          //This is the select country / location button onTap redirection
          //to redirect user to a screen which is our AvailableVpnServerLocationScreen
          onTap: ()
              {
                //This is the screen the user is sent to after tapping on the bottomNavigationBar at Point 1 below
                //Point 1
                Get.to(()=> AvailableVpnServersLocationScreen());
              },
          child: Container(
            color: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * .041),
            height: 62,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),

                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Select Country to Connect",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Spacer(),

                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  //As before the colors were left untouched to set it according to the state which have already been implemented in
  //controller_home with 'getRoundButtonColor' and 'getRoundVpnButtonText', all of which is according to the VPN connection state
  Widget vpnRoundButton()
  {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: (){

            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //As explained above, this color has to be changed according to the state in controller_home
                //color: Colors.red,
                color: homeController.getRoundVpnButtonColor.withOpacity(.1),
              ),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //As explained above, this color has to be changed to the state in controller_home
                  //color: Colors.red,
                  color: homeController.getRoundVpnButtonColor.withOpacity(.3),
                ),
                child: Container(
                  height: sizeScreen.height * .14,
                  width: sizeScreen.width * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //As explained above, this color has to be changed to the state in controller_home
                    //color: Colors.red,
                    color: homeController.getRoundVpnButtonColor, //this does not come withOpacity because it will display the colors in getRoundVpnButtonColor as described in that function
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),

                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        //change the title to collect from controller_home using the instance create at the beginning of the page
                        //"Tap to Connect",
                        homeController.getRoundVpnButtonText,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context)
  {

    //We have to call our  VpnEngine inside our Widget build
    //If you remember the snapshotVpnStage, it will listen for the event, which means it will listen for the Stage of our VPN
    //and get the latest Stage. That Stage is inside our event. After getting the latest stage, it will be saved to the
    //homeController.vpnConnectionState's value, hence (homeController.vpnConnectionState.value)
    VpnEngine.snapshotVpnStage().listen((event)
    {
      homeController.vpnConnectionState.value = event;
    });

    sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Free VPN"),
        leading: IconButton(
          onPressed: ()
          {

          },
          icon: Icon(Icons.perm_device_info),
        ),
        actions: [
          IconButton(
            onPressed: ()
            {
              Get.changeThemeMode(
                AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark
              );

              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: Icon(Icons.brightness_4),
          ),
        ],
      ),

      //button to Select Country to Connect
      //Point 1
      bottomNavigationBar: locationSelectionBottomNavigation(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          //2 round widgets
          //location of the country + ping
              //Because we are managing the Start using Getx for the location & ping round widget, we also have to move it inside Obx
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                //using the instance of the controller for this widget to get text for display at certain states
                //To explain below text code - if the countryLongName is empty ? display Location as a title : otherwise
                //if the countryLongName is not empty, in that case we will display that actual country's name
                titleText: homeController.vpnInfo.value.countryLongName.isEmpty ? "Location" : homeController.vpnInfo.value.countryLongName,
                subTitleText: "FREE",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blueAccent,
                  child: homeController.vpnInfo.value.countryLongName.isEmpty ? Icon(
                    Icons.flag_circle,
                    size: 30,
                    color: Colors.white,
                  ) : null,
                  backgroundImage: homeController.vpnInfo.value.countryLongName.isEmpty ? null : AssetImage("countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png"),//take country image from asset in countryFlags folder asset
                ),
              ),

              CustomWidget(
                //Same thing as above. Although for the last part, we can + "ms"
                titleText: homeController.vpnInfo.value.countryLongName.isEmpty ? "60 ms" : "${ homeController.vpnInfo.value.ping} ms",
                subTitleText: "Ping",
                roundWidgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.graphic_eq,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),),

          //button for VPN
          vpnRoundButton(),
          //2 round widgets
          //download + upload
                //This StreamBuilder was created to get changing values of the download and upload features
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, dataSnapshot)
            {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    //to get changing value of Download, we will first have to implement the StreamBuilder<VpnStatus?> and input this row into that
                    titleText: "${dataSnapshot.data?.byteIn ?? '0 kbps'}",
                    subTitleText: "DOWNLOAD",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.arrow_circle_down,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  CustomWidget(
                    titleText: "${dataSnapshot.data?.byteOut ?? '0 kbps'}",
                    subTitleText: "UPLOAD",
                    roundWidgetWithIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
