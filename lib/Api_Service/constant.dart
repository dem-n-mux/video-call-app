import 'dart:developer';

class Constant {
  ///////////// API \\\\\\\\\\\\

  static const BASE_URL = "http://flirtzybackend.centralindia.cloudapp.azure.com:5000/"; // Enter your base URL like :: http://182.168.19.35:5000/
  static const SECRET_KEY = "shared_secret_key";

  static const setting = "/setting";
  static const fetchCountry = "http://ip-api.com/json";
  static const globalCountry = "/flag";
  static const globalSearchCountry = "/flag/searchFlag";
  static const rating = "/ratting/rattingByUserToHost";

  //////////// User ////////////
  static const fetchUser = "user/userProfile";
  static const getUser = "user/userProfile";
  static const updateUser = "user/userProfile";
  static const checkUser = "user/checkUser";

  //////////// AUTH ////////////
  static const signUpUser = "user/register";
  static const logInUser = "user/login";

  ///////////// Host /////////////
  static const fetchHost = "host/login";
  static const fetchLiveHost = "liveHost";
  static const getHost = "host/hostProfile";
  static const updateHost = "host/updateProfile";
  static const fetchHostThumbList = "host/hostThumbList";
  static const hostStatus = "host/isOnline";
  static const hostSettlement = "hostSettlement/hostSettlementForHost";
  /////// Host Request //////
  static const hostRequest = "request/newRequest";

  /////// Complain /////////
  /////// Complain /////////
  static const createComplain = "complaint/create";
  static const getUserComplain = "complaint/userComplaintList";
  static const getHostComplain = "complaint/hostComplaintList";

  /////// Other //////////
  static const fetchBanner = "banner";
  static const getSetting = "setting";
  // static const getSetting = "/live";

  static const coinPlan = "coinPlan/appPlan";

  /////// chat ///////

  static const createChatRoom = "chatTopic/createRoom";
  static const createChat = "chat/createChat";
  static const getOldChat = "chat/getOldChat";
  static const chatThumbList = "chatTopic/chatList";

  ////////// Story /////////
  static const createStory = "story/create";
  static const createViewStory = "story/view";
  static const storyView = "ViewStory/create";
  static const getHostStory = "story/hostStory";
  static const createUserViewStory = "ViewStory/create";
  static const deleteStory = "story/storyId";
  static const hostViceAllStory = "story/hostWiseAllStory";

  ///////// video_call //////

  static const makeCall = "history/makeCall";
  static const randomCall = "random/match";

  ////// Gift //////////
  static const createGiftCategory = "giftCategory/app";
  static const generateGift = "gift/categoryWise";

  ///////////coin_plan//////
  static const coinHistory = "coinPlan/createHistory";
  static const rechargeHistory = "history/historyForUser";
  static const creditHistory = "history/historyForUser";
  static const debitHistory = "history/userDebit";

  //////////  sticker ////////////

  static const sticker = "sticker";

  ///////////// Album /////////
  static const album = "host/addAlbum";
  static const deleteAlbum = "host/deleteAlbum";

  ///////////////  notification list///////////

  static const hostNotification = "notification/hostList";
  static const userNotification = "notification/userList";
  static const userUpdateNotification = "notification/updateFCM";

  ///////////// redeem //////////

  static const createRedeem = "redeem";
  static const withdraw = "redeem/user";
  static const getWithdrawType = "withdraw";
  static const getRedeemStatus = "redeem/user";
  static const hostDebitHistory = "redeem/debit";

  static const searchUser = "chatTopic/userSearch";
  static const searchHost = "chatTopic/hostSearch";
  static const deleteUserAccount = "user/deleteUserAccount";
  static const deleteHostAccount = "host/deleteHostAccount";

  // static String getDomainFromURL(String url) {
  //   final uri = Uri.parse(url);
  //   String host = uri.host;
  //   if (host.startsWith("www.")) {
  //     return host.substring(4);
  //   }
  //   log("The object Host URL :: $host");
  //   return host;
  // }

  ////// WITH PORT //////

  static String getDomainFromURL(String url) {
    final uri = Uri.parse(url);
    String host = uri.host;
    if (host.startsWith("www.")) {
      host = host.substring(4);
    }
    String domainWithPort = uri.hasPort ? "$host:${uri.port}" : host;
    log("The object Host URL :: $domainWithPort");

    return domainWithPort;
  }
}
