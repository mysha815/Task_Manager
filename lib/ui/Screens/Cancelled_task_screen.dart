import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/ui/Widgets/snack_ber_message.dart';

import '../../data/utils/urls.dart';
import '../Widgets/TaskCard.dart';


class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _CancelledTaskList = [];
  @override
  void initState() {
    super.initState();
    _getAllCancelledTasks();
  }
  Future<void> _getAllCancelledTasks() async{
    _getCancelledTaskInProgress = true;
    setState(() {

    });
    final ApiResponse response = await ApiCaller.getRequest(url: Urls.cancelledTaskListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromjson(jsonData));
      }
      _CancelledTaskList = list;
    }else{
      showSnackbarMessage(context, response.errorMessage!);
    }

    _getCancelledTaskInProgress = false;
    setState(() {

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:  Visibility(
          visible: _getCancelledTaskInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: _CancelledTaskList.length,
            itemBuilder: (context,index){
              return  TaskCard(title: 'Cancelled',
                rowcolor: Colors.blueAccent,
                taskModel: _CancelledTaskList[index],
                refreshParent: () {
                  _getAllCancelledTasks();
                },);
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 8,);
            },

          ),
        ),
      ),



    );
  }

}




