class PalikaProfileReponseModel {
  String? type;
  String? message;
  PalikaProfileModel? response;

  PalikaProfileReponseModel({this.type, this.message, this.response});

  PalikaProfileReponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    response = json['response'] != null
        ? PalikaProfileModel.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class PalikaProfileModel {
  String? palikaname;
  int? basicschool;
  int? secondaryschool;

  PalikaProfileModel({this.palikaname, this.basicschool, this.secondaryschool});

  PalikaProfileModel.fromJson(Map<String, dynamic> json) {
    palikaname = json['palikaname'];
    basicschool = json['basicschool'];
    secondaryschool = json['secondaryschool'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['palikaname'] = palikaname;
    data['basicschool'] = basicschool;
    data['secondaryschool'] = secondaryschool;
    return data;
  }
}

class StudentAttendaceSummaryResponseModel {
  String? type;
  String? message;
  StudentAttendanceSummaryModel? response;

  StudentAttendaceSummaryResponseModel(
      {this.type, this.message, this.response});

  StudentAttendaceSummaryResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    response = json['response'] != null
        ? StudentAttendanceSummaryModel.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class StudentAttendanceSummaryModel {
  int? totalStudent;
  int? presentMale;
  int? presentFemale;
  int? presentOther;
  int? absentMale;
  int? absentFemale;
  int? absentOther;

  StudentAttendanceSummaryModel(
      {this.totalStudent,
      this.presentMale,
      this.presentFemale,
      this.presentOther,
      this.absentMale,
      this.absentFemale,
      this.absentOther});

  StudentAttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    totalStudent = json['totalStudent'];
    presentMale = json['presentMale'];
    presentFemale = json['presentFemale'];
    presentOther = json['presentOther'];
    absentMale = json['absentMale'];
    absentFemale = json['absentFemale'];
    absentOther = json['absentOther'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalStudent'] = totalStudent;
    data['presentMale'] = presentMale;
    data['presentFemale'] = presentFemale;
    data['presentOther'] = presentOther;
    data['absentMale'] = absentMale;
    data['absentFemale'] = absentFemale;
    data['absentOther'] = absentOther;
    return data;
  }
}

class TeacherAttendanceSummaryResponseModel {
  String? type;
  String? message;
  TeacherAttendanceSummaryModel? response;

  TeacherAttendanceSummaryResponseModel(
      {this.type, this.message, this.response});

  TeacherAttendanceSummaryResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    response = json['response'] != null
        ? TeacherAttendanceSummaryModel.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class TeacherAttendanceSummaryModel {
  int? totalMale;
  int? totalFemale;
  int? totalOther;
  int? totalTeacher;
  int? presentMale;
  int? presentFemale;
  int? presentOther;
  int? totalPresent;
  int? absentMale;
  int? absentFemale;
  int? absentOther;
  int? totalAbsent;

  TeacherAttendanceSummaryModel(
      {this.totalMale,
      this.totalFemale,
      this.totalOther,
      this.totalTeacher,
      this.presentMale,
      this.presentFemale,
      this.presentOther,
      this.totalPresent,
      this.absentMale,
      this.absentFemale,
      this.absentOther,
      this.totalAbsent});

  TeacherAttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    totalMale = json['totalMale'];
    totalFemale = json['totalFemale'];
    totalOther = json['totalOther'];
    totalTeacher = json['totalTeacher'];
    presentMale = json['presentMale'];
    presentFemale = json['presentFemale'];
    presentOther = json['presentOther'];
    totalPresent = json['totalPresent'];
    absentMale = json['absentMale'];
    absentFemale = json['absentFemale'];
    absentOther = json['absentOther'];
    totalAbsent = json['totalAbsent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMale'] = totalMale;
    data['totalFemale'] = totalFemale;
    data['totalOther'] = totalOther;
    data['totalTeacher'] = totalTeacher;
    data['presentMale'] = presentMale;
    data['presentFemale'] = presentFemale;
    data['presentOther'] = presentOther;
    data['totalPresent'] = totalPresent;
    data['absentMale'] = absentMale;
    data['absentFemale'] = absentFemale;
    data['absentOther'] = absentOther;
    data['totalAbsent'] = totalAbsent;
    return data;
  }
}
