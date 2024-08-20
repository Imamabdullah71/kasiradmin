import 'package:get/get.dart';
import 'package:kasiradmin/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  var isLoading = false.obs;
  var userList = <UserModel>[].obs;
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse('http://10.10.10.129/flutterapi/api_users.php'));
      print("Response body: ${response.body}"); // Logging response body

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['users'] as List;
        var logs = jsonResponse['log'] as List;

        // Print all logs from the API
        for (var log in logs) {
          print("API Log: $log");
        }

        print("Data pengguna yang diterima dari API: $data");

        userList.value = data.map((user) => UserModel.fromJson(user)).toList();
        print("Jumlah pengguna yang dimuat: ${userList.length}");
      } else {
        print("Failed to load users");
      }
    } catch (e) {
      print("Error loading users: $e");
    } finally {
      isLoading.value = false;
    }
  }

  UserModel? getUserById(int id) {
    return userList.firstWhereOrNull((user) => user.id == id);
  }
}
