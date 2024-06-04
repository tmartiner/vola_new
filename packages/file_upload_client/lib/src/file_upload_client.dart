import 'package:image_picker/image_picker.dart';

class FileUploadClient {
  final ImagePicker _picker;

  FileUploadClient({
    ImagePicker? picker,
  }) : _picker = picker ?? ImagePicker();

  Future<String?> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;
      return pickedFile.path;
    } catch (err) {
      throw Exception('Failed to pick image: $err');
    }
  }

  Future<String> uploadImage(String filePath) async {
    try {
      return 'https://images.unsplash.com/photo-1704869881379-4e88e66c0248?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      // TODO: Implement the upload image logic
      // var uri = Uri.parse('...');
      // // Create a multipart request and attach the file to the request
      // var request = http.MultipartRequest('POST', uri);
      // request.files.add(await http.MultipartFile.fromPath('image', filePath));

      // // Send the request
      // var streamedResponse = await request.send();

      // if (streamedResponse.statusCode == 200) {
      //   var response = await http.Response.fromStream(streamedResponse);
      //   var responseData = json.decode(response.body);
      //   final imageUrl = responseData['imageUrl'];
      //   debugPrint('Image uploaded successfully: $imageUrl');
      //   return imageUrl;
      // } else {
      //   throw Exception(
      //     'Failed to upload image: ${streamedResponse.statusCode}, ${streamedResponse.reasonPhrase}',
      //   );
      // }
    } catch (err) {
      throw Exception('Failed to upload image: $err');
    }
  }
}
