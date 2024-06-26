class AppConstants{
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  static const String BASE_URL="";
  static const String BACK_URL="http://10.0.2.2:8000";
  static const String POPULAR_PRODUCT_URI="/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI="/api/v1/products/recommended";
  static const String DRINKS_URI="/api/v1/products/drinks";
  static const String UPLOAD_URL = "/uploads/";

  static const String USER_ADDRESS = "user-address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';

  //auth endpoint
  static const String RAGITRATION_URI="/api/v1/auth/register";
  static const String LOGIN_URI="/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String TOKEN="";
  static const String PHONE="";
  static const String PASSWORD="";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

  //"http://mvs.bslmeiyu.com"
  //"http://10.0.2.2:8000"
}
