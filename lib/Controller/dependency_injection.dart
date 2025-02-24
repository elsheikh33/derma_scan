import 'package:get/get.dart';

import 'network_connectivity.dart';


class DependecyInjection {
  void init(){
    Get.put<NetworkConnectivity>(NetworkConnectivity(),permanent: true);

  }
}