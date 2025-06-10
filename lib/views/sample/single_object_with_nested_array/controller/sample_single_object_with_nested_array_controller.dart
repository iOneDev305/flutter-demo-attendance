import '../../../../base/controller/single_object_with_nested_array_controller.dart';
import '../../../../utils/parameters.dart';
import '../model/sample_single_object_with_nested_array_model.dart';

class SampleSingleObjectWithNestedArrayController extends SingleObjectWithNestedArrayController<
    SampleContentList, SampleModel> {
  String filterDate = "0";

  SampleSingleObjectWithNestedArrayController(super.apiManager);

  @override
  fetchApi(Map<String, dynamic> params) async {
    final token = await ApiParamsHelper.getParamsWithToken();
    params.addAll(token);
    params['filter_date'] = filterDate;
    return apiManager.getAttendancesMy(params);
  }

  @override
  List<SampleContentList> fromJsonList(List jsonList) {
    return SampleContentList.fromJsonList(jsonList);
  }

  @override
  fromJsonUser(Map<String, dynamic> json) {
    return SampleModel.fromJson(json);
  }

}
