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
