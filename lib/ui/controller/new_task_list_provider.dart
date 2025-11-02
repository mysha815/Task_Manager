import 'package:flutter/cupertino.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class NewTaskListProvder extends ChangeNotifier{
  bool _getNewTasksInProgress = false;

  String? _errorMessage;

  bool get getNewTasksInProgress => _getNewTasksInProgress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> _newTaskList = [];

  bool get getNewTasksProgress => _getNewTasksInProgress;

  String? get errorMessages => _errorMessage;

  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTasks() async{
    bool isSuccess = false;

    _getNewTasksInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.newTaskListUrl,
    );
    if(response.isSuccess){
      List<TaskModel> list =[];
     for (Map<String, dynamic> jsonData in response.responseData['data']) {
       list.add(TaskModel.fromjson(jsonData));
     }

     _newTaskList = list;
     isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _getNewTasksInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}