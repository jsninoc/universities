class University {
  String alphaTwoCode;
  List<dynamic> domains;
  String country;
  String? stateProvince;
  List<dynamic> webPages;
  String name;
  String studentsQty;

  University({
    required this.alphaTwoCode,
    required this.domains,
    required this.country,
    this.stateProvince,
    required this.webPages,
    required this.name,
    required this.studentsQty
  });


  factory University.fromJSON(Map<String,dynamic> data) {
    return University(
      alphaTwoCode: data['alpha_two_code'],
      domains: data['domains'],
      country: data['country'],
      stateProvince: data['state-province'],
      webPages: data['web_pages'],
      name: data['name'],
      studentsQty: '0'
    );
  }
}