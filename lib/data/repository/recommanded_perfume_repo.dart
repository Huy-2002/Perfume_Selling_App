import 'package:flutter_perfume_application/data/api/api_client.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService
{
    final ApiClient apiClient;

    RecommendedProductRepo({required this.apiClient});

    Future<Response> getRecommendedProductList() async
    {
        // End Point
        return await apiClient.getData(AppConstants.RECOMMANDED_PRODUCT_URI);
    }
}