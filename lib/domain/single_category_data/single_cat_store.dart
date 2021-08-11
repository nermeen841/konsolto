import 'package:konsolto/domain/single_category_data/single_cat_repo_inter.dart';
import 'package:konsolto/data/get_one_category_model/one_category_model.dart';

class SingleCatStore {
  IRepoSingleCat iRepoSingleCat;
  SingleCatStore(this.iRepoSingleCat);
  SinglecatModel getsingleCatModel;

  Future<SinglecatModel> getSingleCat(String id) async {
    getsingleCatModel =
        SinglecatModel.fromJson(await iRepoSingleCat.getSingleCat(id));

    return getsingleCatModel;
  }
}
