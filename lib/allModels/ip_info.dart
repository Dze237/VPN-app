class IPInfo
{
  late final String countryName;
  late final String regionName;
  late final String cityName;
  late final String zipCode;
  late final String timezone;
  late final String internetServiceProvider;
  late final String query;

  //make a constructor of the above
  IPInfo({
    required this.countryName,
    required this.regionName,
    required this.cityName,
    required this.zipCode,
    required this.timezone,
    required this.internetServiceProvider,
    required this.query,
  });

  //with the help of the IPInfo class, we will convert the json data which we will get as a response from the VPNGate Api
  //to the VPN server to which the user is connected. For each server we have its IP details and the response which comes from
  //the Api is in json format and in order to display it easily on the user interface in our frontend application, we basically
  //access it with the help of the variables at the beginning of this file.
  //So after getting the data in json, we can assign it to those variables at the top of the page (cpuntryName, etc.)
  //this is the same as the Vpn_Info Model class.
  IPInfo.fromJson(Map<String, dynamic> jsonData)
  {
    countryName = jsonData['country'];
    regionName = jsonData['regionName'] ?? '';
    cityName = jsonData['city'] ?? '';
    zipCode = jsonData['zip'] ?? '';
    timezone = jsonData['timezone'] ?? 'Unknown';
    internetServiceProvider = jsonData['isp'] ?? 'Unknown';
    query = jsonData['query'] ?? 'Not available';
  }
  //After this, get ipdetails from the api and the json data will be converted with the help of the IPInfo Model class from Json
  //to proper normal format for our frontend app and this will be assigned to the variables at the top of the page.

}