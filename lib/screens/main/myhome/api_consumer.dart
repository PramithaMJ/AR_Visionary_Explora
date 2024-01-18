import 'dart:typed_data';
import 'package:ar_visionary_explora/screens/main/myhome/global.dart';
import 'package:http/http.dart' as http;

class ApiConsumer {
  Future<Uint8List> removeImageBackgroundApi(String imagePath) async {
    var requestApi = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));

    // which image file to send - define
    requestApi.files.add(
      await http.MultipartFile.fromPath(
        "image_file",
        imagePath,
      ),
    );

    // api header - communicate with help of api key
    requestApi.headers.addAll({"X-API-Key": apiKeyRemoveImageBackground});

    // send request and recieve response
    final responseFromaApi = await requestApi.send();

    if (responseFromaApi.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(responseFromaApi);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception(
          "Error Occured: " + responseFromaApi.statusCode.toString());
    }
  }
}
