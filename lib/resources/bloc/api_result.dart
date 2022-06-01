class ApiResult<T> {
  T? data;
  String? message;
  Status status;

  ApiResult.loading(this.message) : status = Status.LOADING;
  ApiResult.completed(this.data) : status = Status.COMPLETED;
  ApiResult.error(this.message) : status = Status.ERROR;
}

enum Status { LOADING, COMPLETED, ERROR }
