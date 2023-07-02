import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:palika_school/providers/config_providers.dart';
import 'package:palika_school/widgets/attendance_filter/components/ward_select.dart';
import 'package:tuple/tuple.dart';

import '../../models/config_model.dart';

final List<DropdownModel> months = [
  DropdownModel(label: 'Baisakh', value: '01'),
  DropdownModel(label: 'Jestha', value: '02'),
  DropdownModel(label: 'Ashadh', value: '03'),
  DropdownModel(label: 'Shrawan', value: '04'),
  DropdownModel(label: 'Bhadra', value: '05'),
  DropdownModel(label: 'Ashoj', value: '06'),
  DropdownModel(label: 'Kartik', value: '07'),
  DropdownModel(label: 'Mangsir', value: '08'),
  DropdownModel(label: 'Poush', value: '09'),
  DropdownModel(label: 'Magh', value: '10'),
  DropdownModel(label: 'Falgun', value: '11'),
  DropdownModel(label: 'Chaitra', value: '12')
];

// ignore: must_be_immutable
class AttendanceFilter extends ConsumerStatefulWidget {
  // tuple5 -> organizationid, reporttype, attendancedatebs, monthid, academicyear
  void Function(Tuple5<int, String, String, String, int>) refreshApi;
  void Function(dynamic value, String module) onChange;
  String reportType;
  String? dropdownValue;
  String? selectedMonth;
  NepaliDateTime? selectedDateTime;
  int organizationid;

  AttendanceFilter(
      {super.key,
      this.dropdownValue,
      required this.reportType,
      required this.refreshApi,
      this.selectedDateTime,
      this.selectedMonth,
      required this.organizationid,
      required this.onChange});

  @override
  ConsumerState<AttendanceFilter> createState() => _AttendanceFilterState();
}

class _AttendanceFilterState extends ConsumerState<AttendanceFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xFF0F80C4),
                  borderRadius: BorderRadius.circular(4)),
              child: ref.watch(wardListProvider).when(
                  data: (data) => WardSelect(
                      list: data,
                      onChange: (String? value) {
                        widget.onChange(value!, 'dropdownValue');

                        ref.refresh(
                            schoolListProvider(Tuple2(value, '')).future);
                        setState(() {});
                      },
                      value: widget.dropdownValue),
                  error: (error, err) {
                    print(error);
                    return WardSelect(list: [], onChange: (String? value) {});
                  },
                  loading: () =>
                      WardSelect(list: [], onChange: (String? value) {})),
            ),
            SizedBox(
              width: 10,
            ),
            // Expanded(
            //     child: TextField(
            //   style: TextStyle(color: Color(0xFF78797C)),
            //   decoration: new InputDecoration(
            //     suffixIcon: Icon(Icons.search),
            //     labelText: "Search School Name",
            //     filled: true,
            //     fillColor: Color(0xFFF3F4F6),
            //     border:
            //         OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            //     enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(width: 1, color: Color(0xFFE1E0E0)),
            //         borderRadius: BorderRadius.circular(20)),
            //     focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(width: 1, color: Color(0xFF0F80C4)),
            //         borderRadius: BorderRadius.circular(20)),
            //     isDense: true,
            //     contentPadding:
            //         EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
            //   ),
            // )),
            Expanded(
                child: ref
                    .watch(schoolListProvider(Tuple2(widget.dropdownValue, '')))
                    .when(
                        data: (data) => Autocomplete<SchoolListModel>(
                              displayStringForOption: (SchoolListModel gg) =>
                                  gg.organizationname,
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable.empty();
                                }
                                return data.where((SchoolListModel option) {
                                  return option.organizationname
                                      .toLowerCase()
                                      .contains(
                                          textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (selection) {
                                widget.onChange(
                                    selection.organizationid, "organizationid");
                                widget.refreshApi(Tuple5(
                                    selection.organizationid,
                                    widget.reportType,
                                    widget.selectedDateTime!
                                        .format('yyyy-MM-dd'),
                                    widget.selectedMonth ?? '',
                                    2080));
                              },
                            ),
                        error: (error, err) => Center(child: Text('Error')),
                        loading: () =>
                            Center(child: CircularProgressIndicator())))
          ],
        ),
        SizedBox(height: 15),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0F80C4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
                onPressed: () async {
                  widget.selectedDateTime = await showMaterialDatePicker(
                    context: context,
                    initialDate:
                        widget.selectedDateTime ?? NepaliDateTime.now(),
                    firstDate: NepaliDateTime(1970, 2, 5),
                    lastDate: NepaliDateTime(2099, 11, 6),
                    initialDatePickerMode: DatePickerMode.day,
                  );
                  widget.onChange(widget.selectedDateTime, 'selectedDateTime');
                  widget.onChange('datepicker', 'reportType');
                  widget.refreshApi(Tuple5(
                      widget.organizationid,
                      'datepicker',
                      widget.selectedDateTime!.format('yyyy-MM-dd'),
                      widget.selectedMonth ?? '',
                      2080));
                  setState(() {});
                },
                child: Text(
                  NepaliDateFormat("MMMM d, y")
                      .format(widget.selectedDateTime ?? NepaliDateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.w400),
                )),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xFF0F80C4),
                  borderRadius: BorderRadius.circular(4)),
              child: DropdownButton<String>(
                hint: Text(
                  'Select month',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                value: widget.selectedMonth,
                style: TextStyle(color: Colors.white),
                onChanged: (String? value) {
                  widget.onChange('monthpicker', 'reportType');
                  widget.onChange(value!, 'selectedMonth');
                  widget.refreshApi(Tuple5(
                      widget.organizationid,
                      'monthpicker',
                      widget.selectedDateTime!.format('yyyy-MM-dd'),
                      value,
                      2080));
                  setState(() {});
                },
                items: months
                    .map<DropdownMenuItem<String>>(
                        (DropdownModel value) => DropdownMenuItem<String>(
                              value: value.value,
                              child: Text(
                                value.label,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                    .toList(),
                selectedItemBuilder: (BuildContext ctxt) {
                  return months.map<Widget>((item) {
                    return DropdownMenuItem(
                        child: Text("${item.label}",
                            style: TextStyle(color: Colors.white)),
                        value: item.value);
                  }).toList();
                },
                icon: SvgPicture.asset('assets/icons/down.svg'),
                iconSize: 42,
                underline: SizedBox(),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Divider(
          color: Color(0xFF9CA3AF),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
