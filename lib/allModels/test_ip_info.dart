import 'package:test/test.dart';
import 'package:your_package/ip_info.dart'; // Change this to the actual path of your IPInfo class

void main() {
  // Test the constructor
  test('IPInfo constructor initializes correctly', () {
    final ipInfo = IPInfo(
      countryName: 'USA',
      regionName: 'California',
      cityName: 'Los Angeles',
      zipCode: '90001',
      timezone: 'PST',
      internetServiceProvider: 'Comcast',
      query: '192.168.0.1',
    );

    expect(ipInfo.countryName, 'USA');
    expect(ipInfo.regionName, 'California');
    expect(ipInfo.cityName, 'Los Angeles');
    expect(ipInfo.zipCode, '90001');
    expect(ipInfo.timezone, 'PST');
    expect(ipInfo.internetServiceProvider, 'Comcast');
    expect(ipInfo.query, '192.168.0.1');
  });

  // Test the fromJson method
  test('IPInfo fromJson initializes correctly', () {
    final jsonData = {
      'country': 'USA',
      'regionName': 'California',
      'city': 'Los Angeles',
      'zip': '90001',
      'timezone': 'PST',
      'isp': 'Comcast',
      'query': '192.168.0.1'
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

  final ipInfo = IPInfo.fromJson(jsonData);

    expect(ipInfo.countryName, 'Canada'); // Error: Incorrect expectation for countryName
    expect(ipInfo.regionName, 'Texas'); // Error: Incorrect expectation for regionName
    expect(ipInfo.cityName, 'Los Angeles'); // Error: Incorrect expectation for cityName
    expect(ipInfo.zipCode, '12345'); // Error: Incorrect expectation for zipCode
    expect(ipInfo.timezone, 'GMT'); // Error: Incorrect expectation for timezone
    expect(ipInfo.internetServiceProvider, 'AT&T'); // Error: Incorrect expectation for ISP
    expect(ipInfo.query, 'N/A'); // Error: Incorrect expectation for query
  });
}
