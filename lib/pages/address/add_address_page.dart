import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}


class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addressController = TextEditingController();
  final TextEditingController contactPersonNumber = TextEditingController();
  final TextEditingController contactPersonName = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(8.9806, 38.7578),zoom: 17);
  late LatLng _initialPosition =LatLng(8.9806, 38.7578);
  @override
  void initState() {
    // TODO: implement initState
    _isLogged=Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel==null){
        Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition=CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude'])
      ), );
      _initialPosition= LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude'])
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Page'),
      ),
      body:Column(
        children: [
          Container(
            height:Dimensions.height20*7 ,
            width:double.maxFinite,
            margin: EdgeInsets.only(left: Dimensions.width10/2, right: Dimensions.width10/2, top: Dimensions.height10/2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius5),
              border:  Border.all(color:AppColors.mainColor,width: 2)
            ),
            child: Stack(
              children: [
                GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 17),
                  zoomControlsEnabled:false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraIdle: (){},
                  onCameraMove: ((position)=>_cameraPosition=position),
                  onMapCreated: (GoogleMapController controller){},

                  
                )
              ],
            ),
          )
        ],
      ) ,
    );
  }
}
