import 'package:dutstore/config/AppColors.dart';
import 'package:dutstore/scences/SelectLocationGoogleMap/SelectLocationViewModel.dart';
import 'package:dutstore/utils/Assets.dart';
import 'package:dutstore/widgets/Input/CustomElevatedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuple/tuple.dart';

class SelectLocationScreen extends StatelessWidget {
  SelectLocationScreen({Key? key}) : super(key: key);
  final SelectLocationViewModel _viewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<Marker>(
            stream: _viewModel.destination,
            builder: (context, snapshot) {
              return GoogleMap(
                initialCameraPosition: _viewModel.cameraPosition,
                mapToolbarEnabled: false,
                onMapCreated: (controller) =>
                    _viewModel.googleMapController = controller,
                markers: {if (snapshot.hasData) snapshot.data!},
                onTap: (latlong) => _viewModel.position.add(
                  Tuple2(latlong.latitude, latlong.longitude),
                ),
              );
            },
          ),
          Positioned(
            child: Container(
              height: 40,
              width: 40,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            top: 25,
            left: 15,
          ),
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.isLoadingLocation,
                    builder: (context, snapshot) {
                      bool isLoading = snapshot.data ?? false;
                      return FloatingActionButton(
                        onPressed: () => _viewModel.location.add(null),
                        child: !isLoading
                            ? Icon(
                                Icons.gps_fixed,
                              )
                            : CupertinoActivityIndicator(),
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.white,
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: _buildPickAddressCard(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension _SelectLocation on SelectLocationScreen {
  Widget _searchBox() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.place_rounded,
              color: Colors.redAccent,
            ),
            onPressed: () => Get.back(),
            color: primaryColor,
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(fontFamily: FONT_REGULAR),
              onChanged: (value) {},
              decoration:
                  InputDecoration.collapsed(hintText: 'hint_search_text'.tr),
              cursorColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickAddressCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBox(),
            Row(
              children: [
                Icon(
                  Icons.motorcycle,
                  color: Colors.blue,
                  size: 30,
                ),
                SizedBox(width: 20),
                StreamBuilder<String>(
                  stream: _viewModel.address,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Flexible(
                            child: Text(
                              snapshot.data!,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: FONT_REGULAR),
                            ),
                          )
                        : CircularProgressIndicator();
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            StreamBuilder<bool>(
                stream: _viewModel.isLoadingLocation,
                builder: (context, snapshot) {
                  return Center(
                    child: CustomElevatedButton(
                      onPress: snapshot.data ?? false ? null : () {
                        _viewModel.selectAddress.add(null);
                      },
                      width: 200,
                      height: 50,
                      text: 'Select Address',
                    ),
                  );
                }),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
