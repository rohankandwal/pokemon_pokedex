import 'package:byzat_pokemon/core/utils/utility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Utility utility = Utility();
  double weight = 23, height = 34;

  test('should check for InternetConenction.hasConnection', () async {
    // arrange
    // when(utility.getBMI(weight, height)).thenAnswer((realInvocation) => 12.0);

    // act
    final result = utility.getBMI(weight, height);
    // assert
    // verify(utility.getBMI(weight, height));
    expect(result, 0.019896193771626297);
  });
}
