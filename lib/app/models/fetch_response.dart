class FetchResponse<T> {
  
  final int code;
  final T data;
  final String message;
  FetchResponse({this.code, this.data, this.message});

  bool get success => this.code == 200 || this.code == 201;
}