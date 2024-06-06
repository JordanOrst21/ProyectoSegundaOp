import 'package:isr_dart24/isr_dart24.dart';

Future main() async {
  final app = Application<IsrDart24Channel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8898;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
