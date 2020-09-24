class APIResponse<T>{
  T data;
  bool error;
  String errMessage;

  APIResponse({this.data, this.error = false, this.errMessage});
}