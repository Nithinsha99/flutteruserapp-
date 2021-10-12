class HttpException implements Exception{
  String mesaage;
  HttpException(this.mesaage);
  @override
  String toString() {
    // TODO: implement toString
    return mesaage;
  }
}
