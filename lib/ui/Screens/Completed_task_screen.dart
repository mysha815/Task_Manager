import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../Widgets/TaskCard.dart';
import '../Widgets/snack_ber_message.dart';
import '../Widgets/task_count_by_status_card.dart';
import '../controller/completed_task_list_provider.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> _CompletedTaskList = [];
  final CompletedProvider _completedProvider = CompletedProvider();
  @override
  void initState() {
    super.initState();
    _getAllCompletedTasks();
  }
  Future<void> _getAllCompletedTasks() async{
    _getCompletedTaskInProgress = true;
    setState(() {

    });
    final ApiResponse response = await ApiCaller.getRequest(url: Urls.completedTaskListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromjson(jsonData));
      }
      _CompletedTaskList = list;
    }else{
      showSnackbarMessage(context, response.errorMessage!);
    }

    _getCompletedTaskInProgress = false;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _completedProvider,
      child: Scaffold(
        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<CompletedProvider>(
            builder: (context, completedProvider, _){
              return Visibility(
                visible: completedProvider.completedInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.separated(
                  itemCount: _CompletedTaskList.length,
                  itemBuilder: (context,index){
                    return  TaskCard(title: 'Completed',
                      rowcolor: Colors.blueAccent,
                      taskModel: _CompletedTaskList[index],
                      refreshParent: () {
                        _getAllCompletedTasks();
                      },);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 8,);
                  },

                ),
              );
            } ,
          ),
        ),



      ),
    );
  }
}




