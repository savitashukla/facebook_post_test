import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomePageController extends GetxController
{
  var likeValues=3.obs;
  var imagePickUpD="".obs;
   final box = GetStorage();
 var images=[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    likeValues.value= box.read('likeValues')??0;
    images.value = getStoredImages();

  }
  Future<void> uploadImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final storage = GetStorage();
      storage.write('image_${DateTime.now().millisecondsSinceEpoch.toString()}', pickedImage.path);

       images.value = getStoredImages();
    }
  }
  // Function to retrieve stored images
  List<dynamic> getStoredImages() {
    final storage = GetStorage();
    final keys = storage.getKeys().where((key) => key is String && key.startsWith('image_')).toList();
    final images = keys.map((key) => storage.read(key)).toList();

    return images;
    print(images);

 /*   if(box.getKeys().where((key) => key.startsWith('image_'))!=null)
    {

      print(storage.getKeys().where((key) => key.startsWith('image_')).map((key) => storage.read(key)).toList());

      return storage.getKeys().where((key) => key.startsWith('image_')).map((key) => storage.read(key)).toList();
*/


    /*}
    else
    {
      null;
    }*/
  }
}