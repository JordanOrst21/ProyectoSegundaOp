import 'package:isr_dart24/isr_dart24.dart';

class ISRConfiguration extends Configuration {
  ISRConfiguration(String fileName) : super.fromFile(File(fileName));
  late DatabaseConfiguration database;
}
