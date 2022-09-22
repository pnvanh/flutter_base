class APIBaseOutput {
  final Map<String, dynamic> json;

  APIBaseOutput(this.json) : super() {
    mapping(json);
  }

  mapping(Map<String, dynamic> json) {}

  String get errorMessage => json['status_message'] as String;

  bool get success => json['success'] as bool;
}
