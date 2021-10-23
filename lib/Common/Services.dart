import 'package:appcode/Models/AllSoundDataModel.dart';
import 'package:dio/dio.dart';
import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Models/AboutUsModel.dart';
import 'package:appcode/Models/SoundDataModel.dart';
import 'package:appcode/Models/SoundModel.dart';
import 'package:appcode/Models/TermsAndConditionsModel.dart';

var dio = Dio();

class Services {
  static Future<SoundModel> getSoundCategoryData() async {
    String url = cnst.Constants.apiBaseUrl + 'menu_category';
    Response response;
    Map<String, dynamic>? data;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      print("getCategoryData api called successfully");
      print(response.data);
      data = response.data;
    } else {
      print('error in calling getCategoryData api');
    }
    return SoundModel.fromJson(data!);
  }

  static Future<SoundDataModel> getSoundData(String cat_id) async {
    String url = cnst.Constants.apiBaseUrl + 'get_sound?cat_id=$cat_id';
    Response response;
    Map<String, dynamic>? data;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      print("getSoundData api called successfully");
      print(response.data);
      data = response.data;
    } else {
      print('error in calling getSoundData api');
    }
    return SoundDataModel.fromJson(data!);
  }
  static Future<AllSoundDataModel> getAllSoundData() async {
    String url = cnst.Constants.apiBaseUrl + 'get_sound1?cat_id=0';
    Response response;
    Map<String, dynamic>? data;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      print("getAllSoundData api called successfully");
      print(response.data);
      data = response.data;
    } else {
      print('error in calling getAllSoundData api');
    }
    return AllSoundDataModel.fromJson(data!);
  }

  static Future<AboutUsModel> getAboutUs() async {
    String url = cnst.Constants.apiBaseUrl + 'get_abuotus';
    Response response;
    Map<String, dynamic>? data;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      print("getAboutUs api called successfully");
      print(response.data);
      data = response.data;
    } else {
      print('error in calling getAboutUs api');
    }
    return AboutUsModel.fromJson(data!);
  }

  static Future<TermsAndConditionsModel> getTermsAndConditions() async {
    String url = cnst.Constants.apiBaseUrl + 'get_terms';
    Response response;
    Map<String, dynamic>? data;
    response = await dio.get(url);
    if (response.statusCode == 200) {
      print("getTermsAndConditions api called successfully");
      print(response.data);
      data = response.data;
    } else {
      print('error in calling getTermsAndConditions api');
    }
    return TermsAndConditionsModel.fromJson(data!);
  }

  static Future postFeedback(
      String email, String title, String description) async {
    String url = cnst.Constants.apiBaseUrl +
        'give_feedback?email=$email&title=$title&description=$description';
    Response response;
    Map<String, dynamic>? data;
    response = await dio.post(url);
    if (response.statusCode == 200) {
      print("postFeedback api called successfully");
      print(response.data);
      data = response.data;
    } else {
      print('error in calling postFeedback api');
    }
    return data!;
  }


}
