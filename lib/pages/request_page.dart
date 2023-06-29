import 'package:cloudgo_mobileapp/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloudgo_mobileapp/widgets/request_item.dart';
class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State <RequestPage> createState() =>  RequestPageState();
}

class  RequestPageState extends State<RequestPage> with SingleTickerProviderStateMixin{
  late TabController _controller;
  List<String> name = ["name1", "name2", "name3", "name4"];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F6),
        centerTitle: true,
        title:const Text("YÊU CẦU",
          style:  TextStyle(
            color: Color(0xFF3A4869),
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.40,
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _controller ,
          tabs: [
            tabLabel("Đơn của tôi"),
            tabLabel("Chờ duyệt"),
            tabLabel("Chấp thuận"),
            tabLabel("Từ chối")
          ]),
      ),
      body: Container(
        decoration:const BoxDecoration(color: Color(0x93D6DCED)),
        child: TabBarView(
          controller: _controller,
          children: [
            myRequestTab(context, name),
            myRequestTab(context, name),
            myRequestTab(context, name),
            myRequestTab(context, name),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber ,
        onPressed: (){},
        child: const Icon(
          Icons.add,
        ) ,        
      ),
    );
  }

  Text tabLabel(String label) {
    return Text(label,
      style:const TextStyle(
        color: Color(0xFF3A4869),
        fontSize: 15,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.30,
        ),
    );
  }
  Widget myRequestTab(BuildContext context, List<String> listItem)
   
  => Container(
    margin: EdgeInsets.only(top: MarginValue.medium),
    child: ListView.builder(
      itemCount: listItem.length,
      itemBuilder: (context, index) {
        return RequestItem(
        name: listItem[index], 
        reason: "lấy vợ", 
        type: TimeOffType.noSalary, 
        start: DateTime(2023, 6,23), 
        end: DateTime(2023,6,30)
        );
      },
    ),
  );
}
