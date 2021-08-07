import 'package:dooromi/Worklog/model/Equipment.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/ClientPage.dart';
import 'package:flutter/material.dart';

class HeavyEquipmentPage extends StatefulWidget {
  final Worklog worklog;

  HeavyEquipmentPage({required this.worklog});

  @override
  _HeavyEquipmentState createState() => new _HeavyEquipmentState(worklog: worklog);
}

class _HeavyEquipmentState extends State<HeavyEquipmentPage> {

  final Worklog worklog;

  _HeavyEquipmentState({required this.worklog});

  @override
  Widget build(BuildContext context) {
    var _equipmentList = {'크레인'}; //todo 서버에서 리스트 받아오기
    var _sepcList = {'25T', '50T', '100T'};
    var _selectedEquipment = '크레인';
    var _selectedSpec = '';


    return Scaffold(
        appBar: AppBar(
          title: Text('두루미'),
        ),
        body:
        new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child:
          new Column(
              children: <Widget>[
                new Container(
                  width: 250,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                     "근무장비 입력",
                    style: new TextStyle(
                        fontSize:25.0,
                        color: Colors.white,
                        fontFamily: "Roboto"
                    ),
                  ),
                ),





                new Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: DropdownButton(
                    value: _selectedEquipment,
                      items: _equipmentList.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                                child: Text(value)
                            );
                          }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedEquipment = value as String;
                        });
                      }
                  ),
                ),
                new Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Icon(
                        Icons.mic,
                        color: Colors.teal,
                        size: 100
                    )
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                      child: Text('다음'),
                      onPressed: () {
                        worklog.setEquipment(new Equipment(_selectedEquipment, _selectedSpec));
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new ClientPage(worklog: worklog))
                        );
                      },
                    )
                ),
              ]
          ),
        )
    );
  }
}