import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late TextEditingController textController;
  String textContent = "";

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: resolutionField(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Container(
              color: Colors.white,
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2023, 9, 13),
                lastDay: DateTime.utc(2030, 10, 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField resolutionField() {
    // final textProvider = Provider.of<InfoProvider>(context);

    return TextField(
      controller: textController,
      focusNode: _focusNode,
      style: TextStyle(
        color: sub1,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 15, 15, 0),
        hintText: '이번 달 다짐을 적어보세요!',
        hintStyle: TextStyle(
          color: sub4,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        counterText: '',
      ),
      maxLength: 20,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      cursorColor: sub2,
      cursorHeight: 19,
      cursorWidth: 1.5,
      autofocus: false,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (value) {
        setState(() {
          textContent = textController.text;
        });
      },
    );
  }
}
