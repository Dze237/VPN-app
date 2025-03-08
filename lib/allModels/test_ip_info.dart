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
