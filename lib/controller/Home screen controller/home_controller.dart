



import 'package:beat/view/splash%20screen/splash_screen.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}