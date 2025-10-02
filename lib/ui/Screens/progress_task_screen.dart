import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../Widgets/TaskCard.dart';
import '../Widgets/snack_ber_message.dart';
import '../Widgets/task_count_by_status_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  List<TaskModel> _ProgressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllProgressTasks();
  }

  Future<void> _getAllProgressTasks() async {
    _getProgressTaskInProgress = true;
    setState(() {});
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.progressTaskListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromjson(jsonData));
      }
      _ProgressTaskList = list;
    } else {
      showSnackbarMessage(context, response.errorMessage!);
    }

    _getProgressTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: _getProgressTaskInProgress == false,
          replacement:Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: _ProgressTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                title: 'Progress',
                rowcolor: Colors.pinkAccent,
                taskModel: _ProgressTaskList[index],
                refreshParent: () {
                  _getAllProgressTasks();
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 8,
              );
            },
          ),
        ),
      ),
    );
  }
}
