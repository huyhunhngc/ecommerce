import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/scences/MainScreen/MainViewModel.dart';
import 'package:dutstore/scences/MoreScreen/MoreViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/ActionAppbar.dart';
import 'package:dutstore/widgets/AppBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Component/MoreMenu.dart';
import 'Component/ProfilePicture.dart';

class MoreScreen extends StatelessWidget {
  final MainViewModel _mainViewModel = Get.find();
  final MoreViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          StreamBuilder<int>(
            stream: _mainViewModel.cartOrderCount,
            builder: (context, snapshot) {
              return ActionCart(
                count: snapshot.data,
              );
            },
          )
        ],
      ),
      body: AppBody(
        hasBackgroundImage: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: Row(
                  children: [
                    ProfilePic(
                      imageUrlStream: _viewModel.imageUrl,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<String>(
                              stream: _viewModel.userName,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data ?? 'KhanhTv',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: FONT_REGULAR,
                                      fontSize: 20,
                                      color: kPrimaryColor),
                                );
                              }),
                          StreamBuilder<String>(
                            stream: _viewModel.userEmail,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data ?? 'khanhtv@gmail.com',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: FONT_REGULAR,
                                    fontSize: 14,
                                    color: kPrimaryColor),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Edit Profile",
                icon: "assets/icons/User Icon.svg",
                press: () => _viewModel.editProfileTrigger.add(null),
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () => _viewModel.settingsTrigger.add(null),
              ),
              ProfileMenu(
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () => _viewModel.helpsTrigger.add(null),
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () => _viewModel.loggoutTrigger.add(null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
