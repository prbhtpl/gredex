class ApiUrl {
  static const int maxRetry = 3;
  static const int timeOutMinutes = 5;

 static const baseUrl = 'https://gridxecosystem.io:5000/';
 //static const baseUrl = 'http://209.182.232.82:5000/';

  ///Test URL
 // static const baseUrl = 'https://hellofarmers.in:5000/';

// static const baseUrl = 'http://10.0.2.2:5000/';
  static const login = '${baseUrl}login';
  static const verifyOtp = '${baseUrl}userverification';
  static const register = '${baseUrl}register';
  static const getUserProfile = '${baseUrl}user/userprofile';
  static const binaryTree = '${baseUrl}user/treesecondlevel';
  static const activationHistory = '${baseUrl}user/buypackagereport';
  static const dashboardapi = '${baseUrl}user/dashboardapi';
  static const banner = '${baseUrl}sliders';
  static const downline = '${baseUrl}user/getMyDownline';
  static const getMemberByLevel = '${baseUrl}user/getMemberByLevel';
  static const get3Xamount = '${baseUrl}user/get3Xamount';
  static const gdxLiveRate = '${baseUrl}getliveamount';
  static const transactionHistoryReport =
      '${baseUrl}user/transactionhistoryreport';

  ///update profile
  static const updateProfile = '${baseUrl}user/updateProfile';

  /// update Email & Mobile
  static const updateEmailMobile = '${baseUrl}user/updateEmailMobile';

  ///otp  verification Email & Mobile
  static const otpVerifyAndUpdate = '${baseUrl}user/otpVerifyAndUpdate';

  ///renewal History
  static const renewalHistory = '${baseUrl}user/renualHistory';

  ///get teamMember
  static const getTeamMember = '${baseUrl}user/getteammember';

  ///update Password
  static const updatePassword = '${baseUrl}user/changePasswordSave';

  ///send otp when change password
  static const sendOtp = '${baseUrl}user/changePassword';

  ///direct reward
  static const directReward = '${baseUrl}user/directreport';

  ///matching reward
  static const matchingReward = '${baseUrl}user/binaryreport';

  ///GDX Trading
  static const gdxTrading = '${baseUrl}user/gdxTrading';

  ///p2p transaction
  static const p2pTransaction = '${baseUrl}user/p2ptran';

  ///p2p transaction Verify

  static const p2pTransactionVerify = '${baseUrl}user/p2ptranVerify';

  ///Check User
  static const checkUser = '${baseUrl}user/checkuser';

  ///Transaction History
  static const transactionHistory = '${baseUrl}user/p2ptranHistory';

  ///forget password
  static const forgotPassword = '${baseUrl}forgotPassword';

  ///forget password Save
  static const forgotPasswordSave = '${baseUrl}forgotPasswordSave';

  ///activate Account
  static const package = '${baseUrl}user/package';

  ///activate Account Verify
  static const packageVerify = '${baseUrl}user/packageVerify';

  ///fund Request
  static const fundRequest = '${baseUrl}user/walletrequest';
  static const fundRequestList = '${baseUrl}user/fundRequestList';

  ///USD Trading
  static const usdTrading = '${baseUrl}user/usdTrading';

  ///Bonanza
  static const bonanza = '${baseUrl}user/bonanza';

  ///completedBonanza
  static const completedBonanza = '${baseUrl}user/bonanzaCompleted';
  ///bonanzaNew
  static const getBonanzaNew = '${baseUrl}user/bonanzaNew';

  ///airdrop
  static const airdrop = '${baseUrl}user/airDrops';

  ///withdrawalHistory
  static const withdrawalHistory = '${baseUrl}user/withrawalReport';
 ///gameWalletHistories
  static const gameWalletHistories = '${baseUrl}user/gameWalletHistories';

  ///withdrawal
  static const withdrawal = '${baseUrl}user/withdrawal';
 ///fundTransferToGameWallet
  static const fundTransferToGameWallet = '${baseUrl}user/fundTranferToGameWallet';

  ///withdrawalVerify
  static const withdrawalVerify = '${baseUrl}user/withdrawalVerify';

  ///fundTransferToGameWalletVerify
  static const fundTransferToGameWalletVerify = '${baseUrl}user/fundTranferToGameWalletVerify';
  ///rank
  static const rank = '${baseUrl}user/rank';

  ///qrCode
  static const qrCode = '${baseUrl}user/qrCode';

  ///tokenList
  static const ticketList = '${baseUrl}user/ticket/list';
 ///createToken
  static const createTicket = '${baseUrl}user/ticket/create';
  ///closeTicket
  static const closeTicket = '${baseUrl}user/ticket/ticketClose';
 ///ticketDetails
  static const ticketDetails = '${baseUrl}user/ticket/details';
  ///sendMessage
  static const sendMessage = '${baseUrl}user/ticket/ticketReply';

  ///Transfer
  static const withdrawalGdx = '${baseUrl}user/withdrawalGdx';
  static const withdrawalGdxVerify = '${baseUrl}user/withdrawalGdxVerify';
  ///TransferHistory
  static const withdrawalGdxReport = '${baseUrl}user/withdrawalGdxReport';
 ///userTime
  static const userTime = '${baseUrl}user/userTime';
 /// swapTransfer
  static const swapTokens = '${baseUrl}user/swapTokens';
  ///calculate swapAmount
  static const swapAmount = '${baseUrl}calculatePancake';

  ///myP2pSellList
  static const myP2pSellList = '${baseUrl}user/myP2pSellList';
  ///p2pSell
  static const p2pSell = '${baseUrl}user/p2pSell';
  ///addAccountOrUpi
  static const addAccountOrUpi = '${baseUrl}user/addAccountOrUpi';
  ///getAccountDetails
  static const getAccountDetails = '${baseUrl}user/getAccountDetails';
  ///showP2PRequestList
  static const showP2PRequestList = '${baseUrl}user/showP2PRequestList';
  ///showP2PRequestList
  static const myP2pSellCancel = '${baseUrl}user/myP2pSellCancel';
  ///sendRequestSellerToBuyer
  static const sendRequestSellerToBuyer = '${baseUrl}user/sendRequestSellerToBuyer';
  ///buyRequestList
  static const buyRequestList = '${baseUrl}user/buyRequestList';
  ///buyRequestListSelf
  static const buyRequestListSelf = '${baseUrl}user/buyRequestListSelf';
  ///resendOtpForP2p
  static const resendOtpForP2p = '${baseUrl}user/resendOtpForP2p';
  ///verifiedOtpForP2p
  static const verifiedOtpForP2p = '${baseUrl}user/verifiedOtpForP2p';
  ///approveRequestAmount
  static const approveRequestAmount = '${baseUrl}user/approveRequestAmount';
  ///cancelBuyRequest
  static const cancelBuyRequest = '${baseUrl}user/cancelBuyRequest';
 ///cancelBuyRequestSeller
  static const cancelBuyRequestSeller = '${baseUrl}user/cancelBuyRequestSeller';
}
