import '../../../../utils/parameters.dart';
import '../../../base/controller/single_object_controller.dart';
import '../model/account_model.dart';

class AccountController extends SingleObjectController<AccountModel> {
  @override
  Future fetchApi(Map<String, dynamic> params) async {
    final additionalParams = await ApiParamsHelper.getParamsWithToken();
    params.addAll(additionalParams);
    return apiManager.getMyAccount(params);
  }

  @override
  AccountModel fromJson(Map<String, dynamic> json) {
    return AccountModel.fromJson(json);
  }
}
