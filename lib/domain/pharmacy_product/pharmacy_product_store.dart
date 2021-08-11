import 'package:konsolto/domain/pharmacy_product/pharmacy_product_repo_interf.dart';
import 'package:konsolto/data/pharmacy_product/pharmacy_product_model.dart';

class PharmacyproductStore {
  IPharmacyproductRepo iPharmacyproductRepo;
  PharmacyproductStore(this.iPharmacyproductRepo);
  PharmacyProductModel pharmacyProductModel;

  Future<PharmacyProductModel> getPharmacyproduct(String id) async {
    pharmacyProductModel = PharmacyProductModel.fromJson(
        await iPharmacyproductRepo.getPharmacyproduct(id));

    return pharmacyProductModel;
  }
}
