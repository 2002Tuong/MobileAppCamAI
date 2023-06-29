import 'package:cloudgo_mobileapp/shared/constants.dart';
import 'package:flutter/material.dart';

enum TimeOffType {
  noSalary(formatString: "Nghỉ không lương"),
  hasSalary(formatString: "nghỉ có lương");

  const TimeOffType(
    {required this.formatString
    }
  );

  final String formatString;
}

enum StateOFRequest {
  accept(icon: Icons.task_alt_outlined, color:  Colors.lightGreenAccent),
  reject(icon: Icons.dangerous_outlined, color:  Colors.red),
  waitting(icon: Icons.hourglass_bottom_outlined, color:  Colors.amber);

  const StateOFRequest({
    required this.icon,
    required this.color
  });
  final IconData icon;
  final Color color;
}

class RequestItem extends StatefulWidget {
  const RequestItem({super.key, required String name, required DateTime start, required end, required TimeOffType type, required String reason, StateOFRequest state = StateOFRequest.waitting})
    : _name = name, _start = start, _end = end, _type = type, _reason = reason, _state = state;
  final String _name;
  final DateTime _start;
  final DateTime _end;
  final TimeOffType _type;
  final String _reason;
  final StateOFRequest _state;
  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MarginValue.medium, vertical: MarginValue.small),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        color:const Color.fromARGB(150, 183, 169, 207),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/logo.png", fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      widget._name,
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(widget._state.icon, color:  widget._state.color,)
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xFF774615),
                child: Padding(
                  padding: EdgeInsets.all(MarginValue.medium),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          margin: EdgeInsets.only(bottom: MarginValue.small),
                          child: const Text(
                            "Nghỉ phép",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.40
                            ),
                          ),
                        ),
                        Table(
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: labelWithInformation("Thời gian", "${dateTimetoString(widget._start)} - ${dateTimetoString(widget._end)}")
                                ),
                                TableCell(
                                  child:  labelWithInformation("Loại nghỉ phép ", widget._type.formatString, margin: MarginValue.small)
                                  )
                              ],
                            ),
                            TableRow(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: (){}, 
                                    icon:const Icon(
                                      Icons.restore_from_trash_outlined,
                                      color: Colors.red,
                                    )
                                  ),
                                ),
                                TableCell(
                                  child: labelWithInformation("Lý do", widget._reason, margin: MarginValue.small),
                                  )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
Text label(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Color(0xFFF4922E),
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      letterSpacing: 0.30,
    ),
  );
}
Text information(String infor) {
  return Text(
    infor,
    
    style:const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      letterSpacing: 0.30,
    ),
    overflow: TextOverflow.ellipsis,
  );
}

//format dd/mm/yyyy
String dateTimetoString(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
Widget labelWithInformation(String title, String infor, {double margin = 0}) {
  return Container(
    margin: EdgeInsets.only(left: margin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(title),
        information(infor),
      ],
    ),
  );
}