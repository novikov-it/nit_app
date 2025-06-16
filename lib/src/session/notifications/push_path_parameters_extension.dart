extension PushParsePathParameters on String? {
  Map<String, String> get parsePushPathParameters {
    Map<String, String> result = {};
    if (this == null) return result;
    List<String> parts = this!.split('=');

    if (parts.length == 2) {
      result[parts[0]] = parts[1];
    }

    return result;
  }
}
