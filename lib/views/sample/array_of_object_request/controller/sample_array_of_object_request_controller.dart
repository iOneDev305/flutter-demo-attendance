import '../../../../base/controller/array_of_objects_controller.dart';
import '../model/sample_array_of_object_request_model.dart';

class SampleArrayOfObjectRequestController extends ArrayOfObjectsController<SampleArrayOfObjectRequestModel> {
  @override
  fetchApi(Map<String, dynamic> params) {
    return apiManager.getDepartment(params);
  }

  @override
  List<SampleArrayOfObjectRequestModel> fromJsonList(List jsonList) {
    return SampleArrayOfObjectRequestModel.fromJsonList(jsonList);
  } // Observable for selected leave type
}
