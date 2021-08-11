import 'package:konsolto/data/recommended_product/recommended_product_model.dart';
import 'package:konsolto/domain/get_recommended/recommended_repo_interf.dart';


class RecommendedStore {
  RecommendedModel recommendedModel;
  IRecommendedRepo iRecommendedRepo;
  RecommendedStore(this.iRecommendedRepo);

  Future<RecommendedModel> getRecommended() async {
    recommendedModel =
        RecommendedModel.fromJson(await iRecommendedRepo.getRecommended());
    return recommendedModel;
  }
}
