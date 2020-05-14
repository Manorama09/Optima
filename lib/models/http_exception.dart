class HttpException implements Exception{
  final String mssg;
  HttpException(this.mssg); 
  
  @override 
  String toString(){
    return mssg;
  }
}