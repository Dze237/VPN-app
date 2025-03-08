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

    expect(ipInfo.countryName, 'USA');
    expect(ipInfo.regionName, 'California');
    expect(ipInfo.cityName, 'Los Angeles');
    expect(ipInfo.zipCode, '90001');
    expect(ipInfo.timezone, 'PST');
    expect(ipInfo.internetServiceProvider, 'Comcast');
    expect(ipInfo.query, '192.168.0.1');
  });


 // Test for missing keys in the fromJson method
  test('IPInfo fromJson handles missing keys correctly', () {
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
    expect(ipInfo.cityName, ''); // Default value
    expect(ipInfo.zipCode, '90001');
    expect(ipInfo.timezone, 'PST');
    expect(ipInfo.internetServiceProvider, 'Comcast');
    expect(ipInfo.query, 'Not available'); // Default value
  });


  // Test default values for missing fields
  test('IPInfo fromJson uses default values when keys are missing', () {
    final jsonData = {
      'country': 'USA',
      'regionName': 'California',
      // Missing fields like city, zip, timezone, isp, query
    };

    final ipInfo = IPInfo.fromJson(jsonData);

    expect(ipInfo.countryName, 'USA');
    expect(ipInfo.regionName, 'California');
    expect(ipInfo.cityName, ''); // Default empty value
    expect(ipInfo.zipCode, ''); // Default empty value
    expect(ipInfo.timezone, 'Unknown'); // Default value
    expect(ipInfo.internetServiceProvider, 'Unknown'); // Default value
    expect(ipInfo.query, 'Not available'); // Default value
  });
}
