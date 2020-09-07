/// name : "BeJson"
/// url : "http://www.bejson.com"
/// page : 88
/// isNonProfit : true
/// address : {"street":"科技园路.","city":"江苏苏州","country":"中国"}
/// links : [{"name":"Google","url":"http://www.google.com"},{"name":"Baidu","url":"http://www.baidu.com"},{"name":"SoSo","url":"http://www.SoSo.com"}]

class UserEntity {
  String _name;
  String _url;
  int _page;
  bool _isNonProfit;
  Address _address;
  List<Links> _links;

  String get name => _name;
  String get url => _url;
  int get page => _page;
  bool get isNonProfit => _isNonProfit;
  Address get address => _address;
  List<Links> get links => _links;

  UserEntity({
      String name, 
      String url, 
      int page, 
      bool isNonProfit, 
      Address address, 
      List<Links> links}){
    _name = name;
    _url = url;
    _page = page;
    _isNonProfit = isNonProfit;
    _address = address;
    _links = links;
}

  UserEntity.fromJson(dynamic json) {
    _name = json["name"];
    _url = json["url"];
    _page = json["page"];
    _isNonProfit = json["isNonProfit"];
    _address = json["address"] != null ? Address.fromJson(json["address"]) : null;
    if (json["links"] != null) {
      _links = [];
      json["links"].forEach((v) {
        _links.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["url"] = _url;
    map["page"] = _page;
    map["isNonProfit"] = _isNonProfit;
    if (_address != null) {
      map["address"] = _address.toJson();
    }
    if (_links != null) {
      map["links"] = _links.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Google"
/// url : "http://www.google.com"

class Links {
  String _name;
  String _url;

  String get name => _name;
  String get url => _url;

  Links({
      String name, 
      String url}){
    _name = name;
    _url = url;
}

  Links.fromJson(dynamic json) {
    _name = json["name"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["url"] = _url;
    return map;
  }

}

/// street : "科技园路."
/// city : "江苏苏州"
/// country : "中国"

class Address {
  String _street;
  String _city;
  String _country;

  String get street => _street;
  String get city => _city;
  String get country => _country;

  Address({
      String street, 
      String city, 
      String country}){
    _street = street;
    _city = city;
    _country = country;
}

  Address.fromJson(dynamic json) {
    _street = json["street"];
    _city = json["city"];
    _country = json["country"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["street"] = _street;
    map["city"] = _city;
    map["country"] = _country;
    return map;
  }

}