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
