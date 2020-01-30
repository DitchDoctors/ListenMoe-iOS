
import '../Models/enums.dart';

extension Method on HTTPMethod {
  String get convertToString {
    return this.toString().replaceAll('HTTPMethod.', "").toUpperCase();
  }
} 