class StudentDailyAttendanceResponseModel {
  String? type;
  String? message;
  List<StudentDailyAttendanceModel>? response;

  StudentDailyAttendanceResponseModel({this.type, this.message, this.response});

  StudentDailyAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['response'] != null) {
      response = <StudentDailyAttendanceModel>[];
      json['response'].forEach((v) {
        response!.add(StudentDailyAttendanceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDailyAttendanceModel {
  String? classname;
  int? presentmale;
  int? absentmale;
  int? presentfemale;
  int? absentfemale;
  int? totalstudents;

  StudentDailyAttendanceModel(
      {this.classname,
      this.presentmale,
      this.absentmale,
      this.presentfemale,
      this.absentfemale,
      this.totalstudents});

  StudentDailyAttendanceModel.fromJson(Map<String, dynamic> json) {
    classname = json['classname'];
    presentmale = json['presentmale'];
    absentmale = json['absentmale'];
    presentfemale = json['presentfemale'];
    absentfemale = json['absentfemale'];
    totalstudents = json['totalstudents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['classname'] = classname;
    data['presentmale'] = presentmale;
    data['absentmale'] = absentmale;
    data['presentfemale'] = presentfemale;
    data['absentfemale'] = absentfemale;
    data['totalstudents'] = totalstudents;
    return data;
  }
}

class StudentMonthlyAttendanceResponseModel {
  String? type;
  String? message;
  List<StudentMonthlyAttendanceModel>? response;

  StudentMonthlyAttendanceResponseModel(
      {this.type, this.message, this.response});

  StudentMonthlyAttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['response'] != null) {
      response = <StudentMonthlyAttendanceModel>[];
      json['response'].forEach((v) {
        response!.add(StudentMonthlyAttendanceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentMonthlyAttendanceModel {
  String? classname;
  String? presentmalepercent;
  String? presentfemalepercent;
  String? presentpercent;

  StudentMonthlyAttendanceModel(
      {this.classname,
      this.presentmalepercent,
      this.presentfemalepercent,
      this.presentpercent});

  StudentMonthlyAttendanceModel.fromJson(Map<String, dynamic> json) {
    classname = json['classname'];
    presentmalepercent = json['presentmalepercent'];
    presentfemalepercent = json['presentfemalepercent'];
    presentpercent = json['presentpercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['classname'] = classname;
    data['presentmalepercent'] = presentmalepercent;
    data['presentfemalepercent'] = presentfemalepercent;
    data['presentpercent'] = presentpercent;
    return data;
  }
}
