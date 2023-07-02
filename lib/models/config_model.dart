class WardListResponseModel {
  final String type;
  final String message;
  final List<String>? response;

  WardListResponseModel({
    required this.type,
    required this.message,
    required this.response,
  });

  factory WardListResponseModel.fromJson(Map<String, dynamic> json) {
    return WardListResponseModel(
        type: json['type'],
        message: json['message'],
        response: (json['response'] as List<dynamic>)
            .map((item) => item.toString())
            .toList());
  }
}

class SchoolListModel {
  final int organizationid;
  final String organizationname;
  final String logo;
  final int wardname;

  SchoolListModel(
      {required this.organizationid,
      required this.organizationname,
      required this.logo,
      required this.wardname});

  factory SchoolListModel.fromJson(Map<String, dynamic> json) {
    return SchoolListModel(
        organizationid: json['organizationid'],
        organizationname: json['organizationname'],
        logo: json['logo'],
        wardname: json['wardname']);
  }
}

class SchoolListResponseModel {
  final String type;
  final String message;
  final List<SchoolListModel>? response;

  SchoolListResponseModel({
    required this.type,
    required this.message,
    required this.response,
  });

  factory SchoolListResponseModel.fromJson(Map<String, dynamic> json) {
    return SchoolListResponseModel(
        type: json['type'],
        message: json['message'],
        response: List<SchoolListModel>.from((json['response'] as List)
            .map((item) => SchoolListModel.fromJson(item))));
  }
}

class DropdownModel {
  String value;
  String label;
  DropdownModel({required this.value, required this.label});
}
