import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palika_school/providers/config_providers.dart';
import 'package:tuple/tuple.dart';

import '../models/config_model.dart';

// ignore: must_be_immutable
class SchoolScreen extends ConsumerStatefulWidget {
  const SchoolScreen({super.key});

  @override
  ConsumerState<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends ConsumerState<SchoolScreen> {
  String? search = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(
            'Schools List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                onChanged: (newValue) => search = newValue,
                style: TextStyle(color: Color(0xFF78797C)),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      ref.refresh(schoolListProvider(
                              Tuple2<String?, String?>('', search))
                          .future);
                      setState(() {});
                    },
                  ),
                  labelText: "Search School Name",
                  filled: true,
                  fillColor: Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFE1E0E0)),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF0F80C4)),
                      borderRadius: BorderRadius.circular(20)),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
                ),
              ))
            ],
          ),
          SizedBox(height: 25),
          Expanded(
              child: ref
                  .watch(
                      schoolListProvider(Tuple2<String?, String?>('', search)))
                  .when(
                      data: (data) => GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 4 / 3,
                          children: _schoolList(data)),
                      error: (error, err) => Center(
                            child: Text("Error"),
                          ),
                      loading: () => Center(
                            child: CircularProgressIndicator(),
                          )))
        ],
      ),
    ));
  }

  _schoolList(List<SchoolListModel> schools) {
    List<Widget> schoolsWidget = [];
    for (var i = 0; i < schools.length; i++) {
      schoolsWidget.add(Container(
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(width: 1, color: Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FadeInImage(
                      image: NetworkImage(schools[i].logo),
                      placeholder: NetworkImage(
                          'https://palika.smartschoolsms.net/public/assets/images/logo.png'),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.network(
                              'https://palika.smartschoolsms.net/public/assets/images/logo.png'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: Text(
                    schools[i].organizationname,
                    textAlign: TextAlign.center,
                  )),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Color(0xFF0F80C4)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Ward No: ${schools[i].wardname}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  )
                ],
              ))));
    }
    return schoolsWidget;
  }
}
