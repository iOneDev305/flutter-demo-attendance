import '../../../../base/controller/single_object_controller.dart';
import '../../../../utils/parameters.dart';
import '../model/sample_single_object_request_model.dart';

class SampleSingleObjectRequestController extends SingleObjectController<SampleSingleObjectRequestModel> {
  @override
  Future fetchApi(Map<String, dynamic> params) async {
    final additionalParams = await ApiParamsHelper.getParamsWithToken();
    params.addAll(additionalParams);
    return apiManager.getMyAccount(params);
  }

  @override
  SampleSingleObjectRequestModel fromJson(Map<String, dynamic> json) {
    return SampleSingleObjectRequestModel.fromJson(json);
  }
}
