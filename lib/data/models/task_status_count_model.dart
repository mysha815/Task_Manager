class TaskStatusCountModel {
  final String status;
  final int count;

  TaskStatusCountModel({required this.status,required this.count});

  factory TaskStatusCountModel.fromjson(Map<String, dynamic> jsonData) {
    return TaskStatusCountModel(status: jsonData['_id'], count: jsonData['sum']);
  }
}