import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../data/repository/location_repo.dart';
import '../models/address_model.dart';
class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool loading = true;
  late Position _position ;
  late Position _pickPosition;
  Placemark _placemark= Placemark();
  Placemark _pickPlacemark= Placemark();
  List<AddressModel> _addressList=[];
  List<AddressModel> get  addressList =>_addressList;
  late List<AddressModel> allAddressList;
  List<String> addressTypeList=[];
  int addresTypeIndex=0;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;




}