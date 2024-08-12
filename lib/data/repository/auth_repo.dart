import 'package:flutter_perfume_application/data/api/api_client.dart';
import 'package:flutter_perfume_application/model/sign_up_body_model.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
  });

  Future <Response> registration(SignUpBody signUpBody) async
  {
    return await apiClient.postData(AppConstants.REGISTRATION_URL, signUpBody.toJson());
  }
  
  Future<String> getUserToken() async
  {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

   bool userLoggedIn()
  {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future <Response> login(String account, String password ) async
  {
    return await apiClient.postData(AppConstants.LOGIN_URL, {"email":account, "password":password});
  }

  Future<bool> saveUserToken(String token) async
  {
      apiClient.token = token;
      apiClient.updateHeader(token);
      return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async
  {
    try{
        await sharedPreferences.setString(AppConstants.PHONE, number);
        await sharedPreferences.setString(AppConstants.PASSWORD, password);

    }
    catch(e){
        throw e;
    }
  }

  bool clearSharedData()
  {
      sharedPreferences.remove(AppConstants.TOKEN);
      sharedPreferences.remove(AppConstants.PASSWORD);
      sharedPreferences.remove(AppConstants.PHONE);
      apiClient.token='';
      apiClient.updateHeader('');
      return true;
  }
}