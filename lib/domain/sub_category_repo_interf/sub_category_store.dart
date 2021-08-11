import 'package:konsolto/domain/sub_category_repo_interf/sub_category_repo_interf.dart';
import 'package:konsolto/data/sub_category_model/sub_category_model.dart';

class SubCatStore {
  ISubcatRepo iSubcatRepo;
  SubCatStore(this.iSubcatRepo);
  SubCatModel subCatModel;

  Future<SubCatModel> getSubcat(String id) async {
    subCatModel = SubCatModel.fromJson(await iSubcatRepo.getSubcat(id));
    return subCatModel;
  }
}
