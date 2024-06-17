class Configs {
  static const TEST_MODE = false;
  static const appNameHiHi = "XaaSvik"; // Ielts Lydia
  static const verApp = "Version 1.0.0+1@XaaSvik2024";
  static const bool isToeicApp = false;

  //account
  static const FAILED = -1;
  static const SUCCESS = 0;
  static const ACCOUNT_IS_USED = 1;
  static const ACCOUNT_NOT_EXISTS = 2;
  static const WRONG_PWD = 3;
  static const FORBIDDEN = 7;
  static const TOKEN_INVALID = 8;
  static const ACCOUNT_WAIT_FOR_VERIFY = 9;

  //task
  static const int openTask = 0;
  static const int inprogressTask = 1;
  static const int reviewTask = 2;
  static const int bugTask = 3;
  static const int completeTask = 4;
  static const int cacelTask = 5;

//feature app
  static const bool openLoginGoogle = false;
  static const bool openLoginApple = false;
  static const bool openLoginFacebook = false;
  static const bool openRoadMap = false;

  //view app
  static const bool isOpenHomeScreenAfterLogin =
      false; // khong di qua man home, di thang vao man topic
  static const bool isOpenCheckPurchasedCouse =
      false; //mo ra cho nhuwng app muon thanh toan mua khoa hoc

  static const String appLanguage = "en";
  //logic app
  static const String courseIdSpeaking = "5112644562321408";
  static const int LOGIN_FAILED = -1;
  static const int LOGIN_SUCCESS = 0;
  static const int LOGIN_ACCOUNT_IS_USED = 1;
  static const int REGISTER_ACCOUNT_IS_USED = 7;

  static const int LOGIN_ACCOUNT_NOT_EXIST = 2;
  static const int LOGIN_WRONG_PASSWORD = 3;
  static const int TOKEN_VALID = -2;
  static const int LOGIN_NOT_EXISTED = 8;
  static const double PERCENT_PASS_SPEAKING = 80;
  static const int FAIL = -1;
  // transaction in app purchase
  static const productIds = ["4855799341907968", "5242361951027200"];
  static const int TRANSACTION_NONE = 0;
  static const int TRANSACTION_SUCCESS = 1;
  static const int TRANSACTION_WATTING = 2;
  static const int TRANSACTION_REFUND = 3;
  static const int TRANSACTION_REPLIED = 4;
  static const int TRANSACTION_PROCESSING = 5; // 5;
  static const int TRANSACTION_FAILT = 6;
  static const int TRANSACTION_ROLLBACK = 7;

  //user course
  static const int CLASS_NOT_JOIN = 1;
  static const int CLASS_WATTING = 2;
  static const int CLASS_APPROVED = 3;
  static const int CLASS_BANNED = 4;
  static const int CLASS_RESERVE = 5;
  static const int CLASS_REFUND = 6;

  //user DB
  static const int VERSION_DB = 1;
  //topic
  static const int TOPIC_TYPE_LESSON = 1;
  static const int TOPIC_TYPE_EXCIRSE = 2;
  static const int TOPIC_TYPE_TEST = 3;
  static const int TOPIC_TYPE_CATEGORY = 4;
  static const int STATUS_DELETED = -1;
  static const int STATUS_PRIVATE = 0;
  static const int STATUS_PUBLIC = 1;
  static const int STATUS_TESTING = 2;
  static const int STATUS_WAITING = 3;
  static const int STATUS_OPEN = 4;
  static const int STATUS_EXPIRED = 5;
  static const int STATUS_REFER = 6;

  //mode topic
  static final int STUDY_MODE_NOMAL = 0;
  static final int STUDY_MODE_FLASHCARD = 1;
  //topic progress
  static const EXAM_SCORE_WAITING = 1;
  static const EXAM_SCORE_PLAY = 2;
  static const EXAM_SCORE_FINISH = 3;
  static const EXAM_SCORE_PAUSE = 4;

  //practie
  static const Duration maxRecordDuation = Duration(minutes: 5, seconds: 30);

  //Game
  static const String skipText = "SKIP_TEXT";
  static const String defaultSpeechLanguage = "en-US"; //"en-EN"vi-VN
  static final int ANSWER_INCORRECT = 0; //sai
  static final int ANSWER_CORRECT = 1; //dung
  static final int MAX_BOX_NUM = 4;
  static final int EXP_CORRECT_ANSWER = 20;
}
