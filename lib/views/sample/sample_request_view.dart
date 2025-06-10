import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ione_office_intern/routes/route_constants.dart';
import 'package:ione_office_intern/utils/constant/fonts_style.dart';

import '../../../../custom/app_bar.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/utils.dart';

class SampleRequestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = ResponsiveUtils.getHorizontalPadding(
          constraints,
        );

        return Scaffold(
          backgroundColor: Primitives.grey1,
          appBar: CustomAppBar(title: 'Sample For Request API'.tr),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: _buildBody(), // Observe state changes
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 16),
          InkWell(
            onTap: () {
              Get.toNamed(RouteConstants.arrayOfObjectView);
            },
            child: Card(
              color: ViewColor.containerBlue.color,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(
                  "Array of object Request",
                  style: TextStyle(
                    color: TextColor.light.color,
                    fontFamily: appFont,
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          InkWell(
            onTap: () {
              Get.toNamed(RouteConstants.singleObjectView);
            },
            child: Card(
              color: ViewColor.containerBlue.color,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(
                  "Single Object Request",
                  style: TextStyle(
                    color: TextColor.light.color,
                    fontFamily: appFont,
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),
          InkWell(
            onTap: (){
              Get.toNamed(RouteConstants.singleObjectWithNestedView);
            },
            child: Card(
              color: ViewColor.containerBlue.color,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(
                  "Single Object With Nested Array",
                  style: TextStyle(
                    color: TextColor.light.color,
                    fontFamily: appFont,
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
