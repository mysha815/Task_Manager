import 'package:flutter/cupertino.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class ProgressTaskListProvder extends ChangeNotifier{
  bool _getProgressTasksInProgress = false;

  String? _errorMessage;
  List<TaskModel> _progressTaskList = [];

  bool get getprogressTasksInProgress => _getProgressTasksInProgress;

  String? get errorMessages => _errorMessage;

  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTasks() async{
    bool isSuccess = false;

    _getProgressTasksInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.progressTaskListUrl,
    );
    if(response.isSuccess){
      List<TaskModel> list =[];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromjson(jsonData));
      }

      _progressTaskList = list;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _getProgressTasksInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}