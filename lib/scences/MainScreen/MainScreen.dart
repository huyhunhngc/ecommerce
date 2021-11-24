import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/models/Destination.dart';
import 'package:dutstore/scences/ActivitiesScreen/ActivitiesScreen.dart';
import 'package:dutstore/scences/HomeScreen/HomeScreen.dart';
import 'package:dutstore/scences/MoreScreen/MoreScreen.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Loading/CustomLoadingIndicator.dart';
import 'package:dutstore/widgets/Navigation/CustomBottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'MainViewModel.dart';

class MainScreen extends StatelessWidget {
  final MainViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    final List<Destination> _destinationScreens = <Destination>[
      Destination('Home'.tr, ICONS_HOME, HomeScreen()),
      Destination('Notification'.tr, ICONS_NOTI, ActivitiesScreen()),
      Destination('Profile'.tr, ICONS_USER, MoreScreen()),
    ];

    return GetBuilder<MainViewModel>(initState: (state) {
      viewModel.isLoading.listen(
        (isLoading) {
          isLoading ? LoadingIndicator.show(context) : LoadingIndicator.hide();
        },
      );
    }, builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          if (viewModel.selectedIndex.valueWrapper!.value == 0) {
            Future.delayed(const Duration(milliseconds: 300), () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            });
          } else {
            viewModel.bottomTabBarTrigger.add(0);
          }
          return false;
        },
        child: StreamBuilder<int?>(
          stream: viewModel.selectedIndex,
          builder: (context, snapshot) {
            return Scaffold(
              body: IndexedStack(
                index: snapshot.data,
                children: _destinationScreens.map((e) => e.screen).toList(),
              ),
              bottomNavigationBar: CustomBottomNavBar(
                onChange: (index) {
                  viewModel.bottomTabBarTrigger.add(index);
                },
                currentIndex: snapshot.data,
                children: _destinationScreens
                    .map(
                      (des) => CustomBottomNavItem(
                          icon: des.icon,
                          label: des.title,
                          color: primaryColor),
                    )
                    .toList(),
                itemColor: primaryColor,
              ),
            );
          },
        ),
      );
    });
  }
}
