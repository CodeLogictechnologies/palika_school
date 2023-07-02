class ProfileModel {
  final int? profileid;
  final String? profilename;
  final String? designationname;
  final String? gender;
  final String? bloodgroup;
  final String? email;
  final String? mobilenumber;
  final String? localaddress;
  final String? profilephoto;

  ProfileModel(
      {required this.profileid,
      required this.profilename,
      required this.designationname,
      required this.gender,
      required this.bloodgroup,
      required this.email,
      required this.mobilenumber,
      required this.localaddress,
      required this.profilephoto});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        profileid: json['profileid'],
        profilename: json['profilename'],
        designationname: json['designationname'],
        gender: json['gender'],
        bloodgroup: json['bloodgroup'],
        email: json['email'],
        mobilenumber: json['mobilenumber'],
        localaddress: json['localaddress'],
        profilephoto: json['profilephoto']);
  }

  Map<String, dynamic> toJson() {
    return {
      'profileid': profileid,
      'profilename': profilename,
      'designationname': designationname,
      'gender': gender,
      'bloodgroup': bloodgroup,
      'email': email,
      'mobilenumber': mobilenumber,
      'localaddress': localaddress,
      'profilephoto': profilephoto
    };
  }
}

class ProfileResponseModel {
  final String type;
  final String message;
  final ProfileModel? response;

  ProfileResponseModel({
    required this.type,
    required this.message,
    required this.response,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
        type: json['type'],
        message: json['message'],
        response: ProfileModel.fromJson(json['response']));
  }
}
