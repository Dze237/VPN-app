import 'package:test/test.dart';
import 'package:your_package/ip_info.dart'; // Change this to the actual path of your IPInfo class

void main() {
  // Test the constructor with incorrect expectations
  test('IPInfo constructor initializes incorrectly', () {
    final ipInfo = IPInfo(
      countryName: 'USA',
      regionName: 'California',
      cityName: 'Los Angeles',
      zipCode: '90001',
      timezone: 'PST',
      internetServiceProvider: 'Comcast',
      query: '192.168.0.1',
    );

    expect(ipInfo.countryName, 'Canada'); // Error: Incorrect expectation for countryName
    expect(ipInfo.regionName, 'California');
    expect(ipInfo.cityName, 'New York'); // Error: Incorrect expectation for cityName
    expect(ipInfo.zipCode, '90000'); // Error: Incorrect expectation for zipCode
    expect(ipInfo.timezone, 'PST');
    expect(ipInfo.internetServiceProvider, 'Verizon'); // Error: Incorrect expectation for internetServiceProvider
    expect(ipInfo.query, '192.168.0.2'); // Error: Incorrect expectation for query
  });

    // Test the fromJson method with incorrect JSON data
  test('IPInfo fromJson initializes incorrectly', () {
    final jsonData = {
      'country': 'Canada', // Error: Incorrect value for country
      'regionName': 'Ontario',
      'city': 'Toronto',
      'zip': 'M5A 1A1',
      'timezone': 'EST',
      'isp': 'Bell',
      'query': '192.168.0.2'
    };

       final ipInfo = IPInfo.fromJson(jsonData);

    expect(ipInfo.countryName, 'USA'); // Error: Incorrect expectation for countryName
    expect(ipInfo.regionName, 'Ontario');
    expect(ipInfo.cityName, 'Toronto');
    expect(ipInfo.zipCode, 'M5A 1A1');
    expect(ipInfo.timezone, 'EST');
    expect(ipInfo.internetServiceProvider, 'Comcast'); // Error: Incorrect expectation for isp
    expect(ipInfo.query, '192.168.0.1'); // Error: Incorrect expectation for query
  });


   // Test for missing keys with incorrect default values expectations
  test('IPInfo fromJson handles missing keys incorrectly', () {
    final jsonData = {
      'country': 'USA',
      'regionName': 'California',
      // 'city' is missing
      'zip': '90001',
      'timezone': 'PST',
      'isp': 'Comcast',
      // 'query' is missing
    };


       final ipInfo = IPInfo.fromJson(jsonData);

    expect(ipInfo.countryName, 'USA');
    expect(ipInfo.regionName, 'California');
    expect(ipInfo.cityName, 'San Francisco'); // Error: Incorrect expectation for cityName
    expect(ipInfo.zipCode, '12345'); // Error: Incorrect expectation for zipCode
    expect(ipInfo.timezone, 'CST'); // Error: Incorrect expectation for timezone
    expect(ipInfo.internetServiceProvider, 'Verizon'); // Error: Incorrect expectation for ISP
    expect(ipInfo.query, 'Not available'); // Correct: This should be the default value
  });


    // Test for missing fields with incorrect default value checks
  test('IPInfo fromJson uses wrong default values when keys are missing', () {
    final jsonData = {
      'country': 'USA',
      'regionName': 'California',
      // Missing fields like city, zip, timezone, isp, query
    };

  final ipInfos = IPInfo.fromJson(jsonData);

    expect(ipInfos.countryNames, 'Canada'); // Error: Incorrect expectation for countryName
    expect(ipInfos.regionNames, 'Texas'); // Error: Incorrect expectation for regionName
    expect(ipInfos.cityNames, 'Los Angeles'); // Error: Incorrect expectation for cityName
    expect(ipInfos.zipCodes, '12345'); // Error: Incorrect expectation for zipCode
    expect(ipInfos.timezones, 'GMT'); // Error: Incorrect expectation for timezone
    expect(ipInfos.internetServiceProviders, 'AT&T'); // Error: Incorrect expectation for ISP
    expect(ipInfos.querys, 'N/A'); // Error: Incorrect expectation for query
  });
}
