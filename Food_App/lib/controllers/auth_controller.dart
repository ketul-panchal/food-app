import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      print("My token is "+response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      //responseModel = ResponseModel(false, response.body["errors"][0]["message"]);
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone,String password) async {
    print("get in token");
    print(authRepo.getUserToken());
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone,password);
    //print("my response is ${response.body}");
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Backend token");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      //responseModel = ResponseModel(false, response.body["errors"][0]["message"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn()  {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}