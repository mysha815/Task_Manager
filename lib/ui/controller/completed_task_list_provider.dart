import 'package:flutter/cupertino.dart';

import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class CompletedProvider extends ChangeNotifier{
  bool _completedInProgress = false;

  String? _errorMessage;

  bool get completedInProgress => _completedInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> completedTask(String taskId) async{
    bool isSuccess = false;

    _completedInProgress = true;
    notifyListeners();

    Map<String,dynamic> requestBody ={
      'id':taskId,
      'status':'completed',
    };
    final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.completedTaskListUrl,
        body: requestBody
    );
    if(response.isSuccess && response.responseData['status'] == 'success'){
      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage ?? 'Complete failed!';
    }
    _completedInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}