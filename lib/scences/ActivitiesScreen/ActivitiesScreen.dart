import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/models/ActivitiesHistory.dart';
import 'package:dutstore/scences/ActivitiesScreen/ActivitiesViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ActivitiesScreen extends StatelessWidget {
  final ActivitiesViewModel _viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivitiesViewModel>(
      builder: (_) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: SvgPicture.asset(ICONS_TRASH),
                  ),
                )
              ],
              title: Text(
                'activities'.tr,
                style: TextStyle(
                    fontFamily: FONT_REGULAR, color: Colors.grey[800]),
              ),
              bottom: TabBar(
                labelColor: Theme.of(context).primaryColor.withAlpha(180),
                indicatorColor: Theme.of(context).primaryColor.withAlpha(180),
                unselectedLabelColor: kSecondaryColor,
                tabs: [
                  Tab(
                    icon: Text(
                      'notifications'.tr,
                      style: TextStyle(fontFamily: FONT_BOLD),
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'history'.tr,
                      style: TextStyle(fontFamily: FONT_BOLD),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                buildNotification(context),
                buildHistory(context),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension _ActivitiesScreen on ActivitiesScreen {
  Widget buildNotification(BuildContext context) {
    return StreamBuilder<List<ActivitiesHistory>>(
      stream: _viewModel.activitiesHistoryList,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) => ListTile(),
                itemCount: snapshot.data?.length,
              )
            : Center(
                child: Image(
                  height: 400,
                  image: AssetImage(ACTIVITIES_NOTI),
                ),
              );
      },
    );
  }

  Widget buildHistory(BuildContext context) {
    return StreamBuilder<List<ActivitiesHistory>>(
      stream: _viewModel.activitiesHistoryList,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) => ListTile(),
                itemCount: snapshot.data?.length,
              )
            : Center(
                child: Image(
                  height: 400,
                  image: AssetImage(ACTIVITIES_HISTORY),
                ),
              );
      },
    );
  }
}
