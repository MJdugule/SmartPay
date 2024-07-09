import 'dart:convert';

class ApiException implements Exception{
   String message = "";

  ApiException.fromResponse(int? statusCode, dynamic error){
    error = jsonDecode(error.body) ;
    

    if (statusCode != 200 ) {
      if (statusCode != 201){ 
       switch (statusCode) {
      case 400:
        message = error['message'];
        break;
      case 401:
         message = error['message'];
         break;
      case 403:
         message = error['message'];
         break;
      case 404:
         message = error['message'];
         break;
      case 500:
      // print(error['message']);
         message = error['message'];
         break;
      case 422:
         message = error['message'];
         break;
      case 429:
         message = error['message'];
         break;
      case 502:
         message = 'Bad gateway';
         break;
      default:
         message = 'Oops something went wrong';
         break;
    }
    }else{
      message = "null";
    }
    }else{
      message = "null";
    }
   
  }
  
  ApiException.fromMultipartResponse(int? statusCode, dynamic error){
    error = jsonDecode(error) ;
    

    if (statusCode != 200 ) {
      if (statusCode != 201){ 
       switch (statusCode) {
      case 400:
        message = error['message'];
        break;
      case 401:
         message = error['message'];
         break;
      case 403:
         message = error['message'];
         break;
      case 404:
         message = error['message'];
         break;
      case 500:
      // print(error['message']);
         message = 'Oops something went wrong';
         break;
      case 422:
         message = error['message'];
         break;
      case 502:
         message = 'Bad gateway';
         break;
      default:
         message = 'Oops something went wrong';
         break;
    }
    }else{
      message = "null";
    }
    }else{
      message = "null";
    }
   
  }

  @override
  String toString() => message;
}