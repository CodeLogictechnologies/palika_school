class TeacherDailyAttendanceResponseModel {
  String? type;
  String? message;
  List<TeacherDailyAttendanceModel>? response;

  TeacherDailyAttendanceResponseModel({this.type, this.message, this.response});

  TeacherDailyAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['response'] != null) {
      response = <TeacherDailyAttendanceModel>[];
      json['response'].forEach((v) {
        response!.add(TeacherDailyAttendanceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherDailyAttendanceModel {
  String? staffname;
  String? checkintime;
  String? checkinstatus;
  String? checkouttime;
  String? checkoutstatus;
  String? workinghours;

  TeacherDailyAttendanceModel(
      {this.staffname,
      this.checkintime,
      this.checkinstatus,
      this.checkouttime,
      this.checkoutstatus,
      this.workinghours});

  TeacherDailyAttendanceModel.fromJson(Map<String, dynamic> json) {
    staffname = json['staffname'];
    checkintime = json['checkintime'];
    checkinstatus = json['checkinstatus'];
    checkouttime = json['checkouttime'];
    checkoutstatus = json['checkoutstatus'];
    workinghours = json['workinghours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['staffname'] = staffname;
    data['checkintime'] = checkintime;
    data['checkinstatus'] = checkinstatus;
    data['checkouttime'] = checkouttime;
    data['checkoutstatus'] = checkoutstatus;
    data['workinghours'] = workinghours;
    return data;
  }
}

class TeacherMonthlyAttendanceResponseModel {
  String? type;
  String? message;
  List<TeacherMonthlyAttendanceModel>? response;

  TeacherMonthlyAttendanceResponseModel(
      {this.type, this.message, this.response});

  TeacherMonthlyAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['response'] != null) {
      response = <TeacherMonthlyAttendanceModel>[];
      json['response'].forEach((v) {
        response!.add(TeacherMonthlyAttendanceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherMonthlyAttendanceModel {
  String? staffname;
  int? workingdays;
  int? presentdays;
  int? absentdays;

  TeacherMonthlyAttendanceModel(
      {this.staffname, this.workingdays, this.presentdays, this.absentdays});

  TeacherMonthlyAttendanceModel.fromJson(Map<String, dynamic> json) {
    staffname = json['staffname'];
    workingdays = json['workingdays'];
    presentdays = json['presentdays'];
    absentdays = json['absentdays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['staffname'] = staffname;
    data['workingdays'] = workingdays;
    data['presentdays'] = presentdays;
    data['absentdays'] = absentdays;
    return data;
  }
}
