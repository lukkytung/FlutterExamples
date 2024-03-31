import 'package:logger/logger.dart';

class BaseService {
  late Logger log;

  BaseService({required String title}) {
    log = Logger(
      filter: null, // Use the default LogFilter (-> only log in debug mode)
      printer: PrettyPrinter(excludePaths: [
        title
      ]), // Use the PrettyPrinter to format and print log
      output: null, // Use the default LogOutput (-> send everything to console)
    );
  }
}
