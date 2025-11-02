import 'package:flutter/cupertino.dart';

import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class CancelledProvider extends ChangeNotifier{
  bool _cancelledInProgress = false;

  String? _errorMessage;

  bool get cancelledInProgress => _cancelledInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> cancelledTask(String taskId) async{
    bool isSuccess = false;

    _cancelledInProgress = true;
    notifyListeners();

    Map<String,dynamic> requestBody ={
     'id':taskId,
      'status':'cancelled',
    };
    final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.cancelledTaskListUrl,
        body: requestBody
    );
    if(response.isSuccess && response.responseData['status'] == 'success'){
      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage ?? 'Cancel failed!';
    }
    _cancelledInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}