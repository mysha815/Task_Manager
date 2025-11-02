import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/Widgets/snack_ber_message.dart';

import '../../data/models/task_model.dart';
import '../Widgets/TaskCard.dart';
import '../Widgets/task_count_by_status_card.dart';
import '../controller/new_task_list_provider.dart';
import 'add_new.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];


  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    context.read<NewTaskListProvder>().getNewTasks();
  }

  Future<void> _getAllTaskStatusCount() async {
    _getAllTaskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskStatusCountUrl);
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromjson(jsonData));
      }
      _taskStatusCountList = list;
    }else{
      showSnackbarMessage(context, response.errorMessage!);
    }

    _getAllTaskStatusCountInProgress = false;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 90,
              child: Visibility(
                visible: _getAllTaskStatusCountInProgress == false,
                replacement:  CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountByStatusCard(
                      title: _taskStatusCountList[index].status,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 4,
                    );
                  },
                ),
              ),
            ),
            Expanded(
                child: Consumer<NewTaskListProvder>(
                  builder: (context,newTaskListProvider, _){
                    return Visibility(
                      visible: newTaskListProvider.getNewTasksProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ListView.separated(
                        itemCount: newTaskListProvider.newTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskModel: newTaskListProvider.newTaskList[index],
                            title: 'new',
                            rowcolor: Colors.green,
                            refreshParent: () {
                             context.read<NewTaskListProvder>().getNewTasks();
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNew()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
