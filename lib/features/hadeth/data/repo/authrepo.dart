// features/hadeth/data/repo/authrepo.dart
import 'package:dio/dio.dart';
import 'package:islami/core/services/dio_endpoints.dart';
import 'package:islami/core/services/dio_provider.dart';
import 'package:islami/features/hadeth/data/model/response/hadith_details/hadith_details.dart';

class AuthRepo {
  static Future<HadithDetails?> loadHadith() async {
    try {
      var response = await DioProvider.get(endpoint: DioEndPoints.baseUrl);
      if (response.statusCode == 200) {
        return HadithDetails.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
