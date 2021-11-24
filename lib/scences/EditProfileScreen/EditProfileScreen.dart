import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/scences/EditProfileScreen/EditProfileViewModel.dart';
import 'package:dutstore/widgets/Loading/CustomLoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileViewModel _viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileViewModel>(
      initState: (state) {
        _viewModel.isLoading.listen(
              (isLoading) {
            isLoading ? LoadingIndicator.show(context) : LoadingIndicator.hide();
          },
        );
      },
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              "Edit Profile",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Color(0xFF6713D2), Color(0xFFCC208E)])),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 120,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                            Text(
                              "Choose Image",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: TextFormField(
                    onChanged: (value) {
                      _viewModel.usernameTrigger.add(value);
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: border,
                      hintText: "Name",
                      focusedBorder: border.copyWith(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                  margin: EdgeInsets.only(left: 12, right: 12, top: 24),
                ),
                Container(
                  child: TextFormField(
                    onChanged: (value) {
                      _viewModel.emailTrigger.add(value);
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: border,
                        hintText: "Email",
                        focusedBorder: border.copyWith(
                            borderSide: BorderSide(color: Colors.blue))),
                  ),
                  margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                ),
                Container(
                  child: TextFormField(
                    onChanged: (value){
                      _viewModel.phoneTrigger.add(value);
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: border,
                        hintText: "Mobile Number",
                        focusedBorder: border.copyWith(
                            borderSide: BorderSide(color: Colors.blue))),
                  ),
                  margin: EdgeInsets.only(left: 12, right: 12, top: 12),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 48, right: 48),
                  child: RaisedButton(
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      _viewModel.updateTrigger.add(null);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}
