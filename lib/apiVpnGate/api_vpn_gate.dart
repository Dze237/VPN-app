import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/appPreferences/appPreferences.dart';

import '../allModels/vpn_info.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/allModels/ip_info.dart';


class ApiVpnGate
{
  static Future<List<VpnInfo>> retrieveAllAvailableVpnServers() async
  {
    //initialize a list to which we will obtain the server when we get them from the Api
    final List<VpnInfo> vpnServerList = [];

    //sending request to the VpnGate server to retrieve all available vpn servers in the api format of the file (csv or json)
    //After which this is converted to a readable format and passed to the variables in the VpnInfo Model class
    try
    {
      final responseFromApi = await http.get(Uri.parse("https://domainname.com/api"));

      //We convert all the * signs in the api to an empty string
      final commaSeperatedValueString = responseFromApi.body.split("#")[1].replaceAll("*", "");

      //We convert the Csv file to a list data
      List<List<dynamic>> listData = const CsvToListConverter().convert(commaSeperatedValueString);

      final header = listData[0];

      for(int counter=1; counter<listData.length-1; counter++)
        {
          Map<String, dynamic> jsonData = {};
          //this inner loop will execute until innerCounter<header.length is false
          for(int innerCounter=0; innerCounter<header.length; innerCounter++)
          {
            jsonData.addAll({header[innerCounter].toString(): listData[counter][innerCounter]});
          }

          //this should start adding the api we are receiving from the server, which is now in normal format
          //the VpnInfo.fromJson is done with the help of our VpnInfo Model class, we are getting the values from Json
          //all the servers gotten with the help of our VpnInfo Model class is added to the vpnServerList.
          vpnServerList.add(VpnInfo.fromJson(jsonData));
        }
    }
    //error that shows if any problems occur
    catch(errorMsg)
    {
      Get.snackbar("Error Occurred", errorMsg.toString(), colorText: Colors.white, backgroundColor: Colors.redAccent.withOpacity(.8));
    }


    //this means all available servers coming from the openGate Api as response should be assigned to the AppPreferences.vpnList
    // which is basically reserved to the local storage hence we can say that we own the servers and have reliable access to it
    //with the help of our vpnList. So whenever we need it, we will just get it from our vpnList
    vpnServerList.shuffle();
    if(vpnServerList.isNotEmpty) AppPreferences.vpnList = vpnServerList;
    return vpnServerList;
  }

  //get ip details of the vpn server to which the user is connected according to their choice.
  //we will implement a method for that
  //the Rx<IPInfo> needs to be implemented in the Model
  //the IPInfo Model class has been implemented, now we need to get the data from the json file
  static Future<void> retrieveIpDetails({required Rx<IPInfo> ipInformation}) async
  {
    //Here, we send the request to retrieve the ipdetails in json format
    //After which when received in json format, it is converted to a readable format and
    //kept in our IPInfo Model class.
    try
    {
      final responseFromApi = await http.get(Uri.parse('http://ip-api.com/json'));
      final dataFromApi = jsonDecode(responseFromApi.body);
      //The data has just been gotten in Json format. Below we will convert it to a readable format by our app

      //We can now convert it from a json format to a readable format by our app with the help of the IPInfo.fromJson
      //found in our Model class
      ipInformation.value = IPInfo.fromJson(dataFromApi);
    }

    //if error occurs, display the below error message and its properties
    catch(errorMsg)
    {
      Get.snackbar("Error", errorMsg.toString(), colorText: Colors.white, backgroundColor: Colors.redAccent.withOpacity(.8));
    }
  }
}