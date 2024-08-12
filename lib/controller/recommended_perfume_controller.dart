import 'package:flutter_perfume_application/data/repository/recommanded_perfume_repo.dart';
import 'package:flutter_perfume_application/model/perfume_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController
{
    final RecommendedProductRepo recommendedProductRepo;
    RecommendedProductController ({required this.recommendedProductRepo});

    List<dynamic> _recommendedProductList = [];
    List<dynamic> get recommendedProductList =>_recommendedProductList;

    bool _isLoaded = false;
    bool get isLoaded => _isLoaded; 

    Future<void> getRecommendedProductList() async
    {
        Response response = await recommendedProductRepo.getRecommendedProductList();
        if(response.statusCode == 200)
        {
            //print("got products recommended");
            _recommendedProductList = [];
            _recommendedProductList.addAll(Product.fromJson(response.body).products);
            //print(_popularProductList);
            _isLoaded = true;

            update(); 
        }

        else
        {
             print("Mở sever lên bạn ơi");
        }
    }
}