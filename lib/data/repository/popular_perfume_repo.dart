import 'package:flutter_perfume_application/data/api/api_client.dart';
import 'package:flutter_perfume_application/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService
{
    final ApiClient apiClient;

    PopularProductRepo({required this.apiClient});

    Future<Response> getPopularProductList() async
    {
        // End Point
        return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    }
}