sealed class ApiResult<T>{}

  class Success<T> extends ApiResult<T>{
    final T data;
    Success(this.data);
  }

  class Error<T>extends ApiResult<T>{
    final String message;
    final int? statusCode;
    Error(this.message, {this.statusCode});
  }