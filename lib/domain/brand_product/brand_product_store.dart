import 'package:konsolto/data/brands_product.dart/brand_product.dart';
import 'package:konsolto/domain/brand_product/brand_product_repo_interf.dart';

class BrandsProductsStore {
  IBrandsproductRepo iBrandsproductRepo;
  BrandsProductsStore(this.iBrandsproductRepo);
  BrandsProductModel brandsProductModel;

  Future<BrandsProductModel> getProductsbrand(String id) async {
    print(iBrandsproductRepo.getProductsbrand(id));
    brandsProductModel = BrandsProductModel.fromJson(
        await iBrandsproductRepo.getProductsbrand(id));

    return brandsProductModel;
  }
}
