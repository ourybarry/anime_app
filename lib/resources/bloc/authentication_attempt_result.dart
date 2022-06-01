class AuthenticationAttemptResult {
  String? data;
  String? message;
  Status status;

  AuthenticationAttemptResult.loading(this.message) : status = Status.LOADING;
  AuthenticationAttemptResult.completed(this.data) : status = Status.COMPLETED;
  AuthenticationAttemptResult.error(this.message) : status = Status.ERROR;
}

enum Status { LOADING, COMPLETED, ERROR }
