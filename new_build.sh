_dropboxSource="$DROPBOX_PATH/mp_apps"

project="."
copyAssets() {
  appName=$1
  osName=$2
  _dataSource="$_dropboxSource/$appName/data"
  _imagesSource="$_dropboxSource/$appName/images"
  _iconsSource="$_dropboxSource/$appName/icons"
  _appColorSource="$_dropboxSource/$appName/colors"
  _appConfigSource="$_dropboxSource/$appName/configs"
  echo "Clear Assets..."
  ./remove.sh $project/assets/database/*
  # ./remove.sh $project/assets/icons/*
  echo "Copy Assets..."
  if [[ ! -d "$project/assets/icons" ]]; then
    mkdir $project/assets/icons
  fi
  if [[ ! -d "$project/assets/images" ]]; then
    mkdir $project/assets/images
  fi
  if [[ $osName == 'android' ]]; then
    echo "replace keystore"
    cp -r $_appConfigSource/key.jks $project/android/app/key.jks
  fi
  rm -rf $project/faq.db
  if [[ $appName == 'dmv' ]]; then
    echo "replace dmv data"
    cp -r $_dataSource/car.zip $project/assets/database/car.zip
    cp -r $_dataSource/cdl.zip $project/assets/database/cdl.zip
    cp -r $_dataSource/motorcycle.zip $project/assets/database/motorcycle.zip
  # else
    # cp -r $_dataSource/new_data.zip $project/assets/database/new_data.zip
  fi
  # cp -r $_dropboxSource/images/* $project/assets/images/
  # cp -r $_dataSource/intro.json $project/assets/intro.json
  cp -r $_imagesSource/* $project/assets/images/
  # cp -r $_iconsSource/* $project/assets/icons/
  cp -r $_appColorSource/app_colors.dart $project/lib/utils/app_colors.dart
  # cp -r $_appConfigSource/localization.g.dart $project/lib/utils/localization.g.dart
  # cp -r $_appConfigSource/google-services.json $project/android/app/google-services.json
  # cp -r $_appConfigSource/GoogleService-Info.plist $project/ios/Runner/GoogleService-Info.plist

}

getFlutterLibs() {
  version=$1
  buildNumber=$2
  echo "Get Flutter Libs"
  pubspecPath="pubspec.yaml"
  search_string="version: .*."
  replace_string="version: $version+$buildNumber"
  echo "getFlutterLibs... search_string : --- $search_string --- $replace_string"

  sed -i "" "s/$search_string/$replace_string/" $pubspecPath
  echo "Create Launcher Icons..."
  # sleep 10
  flutter pub run flutter_launcher_icons:main
}
changeAppName() {
  appName=$1
  version=$2
  buildNumber=$3
  osName=$4
  type=$5
  version_db=$6

  appInfosPath="$project/app_configs.json"
  keyPropertiesPath="$project/android/key.properties"

  echo "Change App Name $appInfosPath $appName $osName"

  key_alias=$(jq .$appName.android.keyAlias $appInfosPath)
  key_alias=$(echo $key_alias | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  echo "Key alias : $key_alias"
  appId=$(jq .$appName.id $appInfosPath)
  appId=$(echo $appId | sed 's/[^a-zA-Z0-9# +.~/-]//g')


  appNameHiHi=$(jq .$appName.appNameHiHi $appInfosPath)
  appNameHiHi=$(echo $appNameHiHi | sed 's/\"//g')
  echo " cho thannh 1 $appNameHiHi"

  verApp=$(jq .$appName.verApp $appInfosPath)
  verApp=$(echo $verApp | sed 's/[^a-zA-Z0-9# @+.~/-]//g')

  echo "cho thanh $verApp"

  minDurationMocktest=$(jq .$appName.minDurationMocktest $appInfosPath)
  minDurationMocktest=$(echo $minDurationMocktest | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  maxDurationMocktest=$(jq .$appName.maxDurationMocktest $appInfosPath)
  maxDurationMocktest=$(echo $maxDurationMocktest | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  minQuestionMocktest=$(jq .$appName.minQuestionMocktest $appInfosPath)
  minQuestionMocktest=$(echo $minQuestionMocktest | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  maxQuestionMocktest=$(jq .$appName.maxQuestionMocktest $appInfosPath)
  maxQuestionMocktest=$(echo $maxQuestionMocktest | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  inAppPurchase=$(jq .$appName.inAppPurchase $appInfosPath)
  inAppPurchase=$(echo $inAppPurchase | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  showAds=$(jq .$appName.showAds $appInfosPath)
  showAds=$(echo $showAds | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  hasState=$(jq .$appName.hasState $appInfosPath)
  hasState=$(echo $hasState | sed 's/[^a-zA-Z0-9# : +.~/-]//g')
  echo "hasStateeeee ---- $hasState"

  hasFAQ=$(jq .$appName.hasFAQ $appInfosPath)
  hasFAQ=$(echo $hasFAQ | sed 's/[^a-zA-Z0-9# : +.~/-]//g')
  if [[ $hasFAQ == 'true' ]]; then
    echo "hasFAQ runnnnnn replace"
    cp -r $_dataSource/faq.zip $project/assets/database/faq.zip
  fi
  echo "hasFAQ ---- $hasFAQ"

  openRoadMap=$(jq .$appName.openRoadMap $appInfosPath)
  openRoadMap=$(echo $openRoadMap | sed 's/[^a-zA-Z0-9# : +.~/-]//g')
  if [[ $openRoadMap == 'true' ]]; then
    echo "openRoadMap runnnnnn replace"
    cp -r $_dataSource/faq.zip $project/assets/database/faq.zip
  fi
  echo "openRoadMap ---- $openRoadMap"

  newUiRoadMap=$(jq .$appName.newUiRoadMap $appInfosPath)
  newUiRoadMap=$(echo $newUiRoadMap | sed 's/[^a-zA-Z0-9# : +.~/-]//g')
  if [[ $newUiRoadMap == 'true' ]]; then
    echo "newUiRoadMap runnnnnn replace"
    cp -r $_dataSource/faq.zip $project/assets/database/faq.zip
  fi
  echo "newUiRoadMap ---- $newUiRoadMap"

  showMockTest=$(jq .$appName.showMockTest $appInfosPath)
  showMockTest=$(echo $showMockTest | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  isToeicApp=$(jq .$appName.isToeicApp $appInfosPath)
  isToeicApp=$(echo $isToeicApp | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  openLoginGoogle=$(jq .$appName.openLoginGoogle $appInfosPath)
  openLoginGoogle=$(echo $openLoginGoogle | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  openLoginApple=$(jq .$appName.openLoginApple $appInfosPath)
  openLoginApple=$(echo $openLoginApple | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  openLoginFacebook=$(jq .$appName.openLoginFacebook $appInfosPath)
  openLoginFacebook=$(echo $openLoginFacebook | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  openRoadMap=$(jq .$appName.openRoadMap $appInfosPath)
  openRoadMap=$(echo $openRoadMap | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  isOpenHomeScreenAfterLogin=$(jq .$appName.isOpenHomeScreenAfterLogin $appInfosPath)
  isOpenHomeScreenAfterLogin=$(echo $isOpenHomeScreenAfterLogin | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  isOpenCheckPurchasedCouse=$(jq .$appName.isOpenCheckPurchasedCouse $appInfosPath)
  isOpenCheckPurchasedCouse=$(echo $isOpenCheckPurchasedCouse | sed 's/[^a-zA-Z0-9# : +.~/-]//g')


  multiCourse=$(jq .$appName.multiCourse $appInfosPath)
  multiCourse=$(echo $multiCourse | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

    hasStudyPlan=$(jq .$appName.hasStudyPlan $appInfosPath)
  hasStudyPlan=$(echo $hasStudyPlan | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  appleId=$(jq .$appName.ios.appleId $appInfosPath)
  appleId=$(echo $appleId | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  shortName=$(jq .$appName.shortName $appInfosPath)
  shortName=$(echo $shortName | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  name=$(jq .$appName.$osName.name $appInfosPath)
  name=$(echo $name | sed 's/[^a-zA-Z0-9# +.~/-]//g')

apiEndPoint=$(jq .$appName.apiEndPoint $appInfosPath)
apiEndPoint=$(echo $apiEndPoint | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  user_plolicy=$(jq .$appName.user_plolicy $appInfosPath)
  user_plolicy=$(echo $user_plolicy | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  user_terms=$(jq .$appName.user_terms $appInfosPath)
  user_terms=$(echo $user_terms | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  maxLevelApp=$(jq .$appName.maxLevelApp $appInfosPath)
  maxLevelApp=$(echo $maxLevelApp | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  mocktestOneCategory=$(jq .$appName.mocktestOneCategory $appInfosPath)
  mocktestOneCategory=$(echo $mocktestOneCategory | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  showGridviewHome=$(jq .$appName.showGridviewHome $appInfosPath)
  showGridviewHome=$(echo $showGridviewHome | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  showGridviewHomeXxxx=$(jq .$appName.showGridviewHomeXxxx $appInfosPath)
  showGridviewHomeXxxx=$(echo $showGridviewHomeXxxx | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  loadTopicMocktestAsMaxLevelApp_4=$(jq .$appName.loadTopicMocktestAsMaxLevelApp_4 $appInfosPath)
  loadTopicMocktestAsMaxLevelApp_4=$(echo $loadTopicMocktestAsMaxLevelApp_4 | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  showTextSplash=$(jq .$appName.showTextSplash $appInfosPath)
  showTextSplash=$(echo $showTextSplash | sed 's/[^a-zA-Z0-9# : +.~/-]//g')

  premium_acc_id=$(jq .$appName.$osName.premium_acc_id $appInfosPath)
  premium_acc_id=$(echo $premium_acc_id | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  packageName=$(jq .$appName.$osName.packageName $appInfosPath)
  packageName=$(echo $packageName | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  firebase_app_name=$(jq .$appName.firebase_app_name $appInfosPath)
  firebase_app_name=$(echo $firebase_app_name | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  firebase_project_id=$(jq .$appName.firebase_project_id $appInfosPath)
  firebase_project_id=$(echo $firebase_project_id | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  storeId=$(jq .$appName.ios.appleId $appInfosPath)
  storeId=$(echo $storeId | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  chPlayId=$(jq .$appName.android.packageName $appInfosPath)
  chPlayId=$(echo $chPlayId | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  firebase_app_id=$(jq .$appName.$osName.firebase_app_id $appInfosPath)
  firebase_app_id=$(echo $firebase_app_id | sed 's/[^a-zA-Z0-9# :+.~/-]//g')
  firebase_project_api_key=$(jq .$appName.firebase_project_api_key $appInfosPath)
  firebase_project_api_key=$(echo $firebase_project_api_key | sed 's/[^a-zA-Z0-9# _ +.~/-]//g')
  firebase_project_number=$(jq .$appName.firebase_project_number $appInfosPath)
  firebase_project_number=$(echo $firebase_project_number | sed 's/[^a-zA-Z0-9# _ +.~/-]//g')

  adModId=$(jq .$appName.$osName.adModId $appInfosPath)
  adModId=$(echo $adModId | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  nativeId=$(jq .$appName.$osName.nativeId $appInfosPath)
  nativeId=$(echo $nativeId | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  bannerId=$(jq .$appName.$osName.bannerId $appInfosPath)
  bannerId=$(echo $bannerId | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  interstitialId=$(jq .$appName.$osName.interstitialId $appInfosPath)
  interstitialId=$(echo $interstitialId | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  echo "Replace configs... xxxxxx $firebase_project_api_key"
  configPath="lib/utils/configs.dart"
  apiConfigPath="lib/repositories/dio.dart"

  search_string="keyAlias=.*."
  replace_string="keyAlias=$key_alias"
  sed -i "" "s+$search_string+$replace_string+" $keyPropertiesPath
  echo "XXXXX ----- $search_string/$replace_string/"

  search_string="static const appNameHiHi = \".*.\";"
  replace_string="static const appNameHiHi = \"$appNameHiHi\";"
    echo "cho thanh 22"
  echo $search_string
  echo $replace_string
  sed -i "" "s+$search_string+$replace_string+" $configPath


  search_string="static const verApp = \".*.\";"
  replace_string="static const verApp = \"$verApp\";"
  echo "cho thanh 3"
  echo $search_string
  echo $replace_string
  sed -i "" "s/$search_string/$replace_string/" $configPath
  
  search_string="String appId = \".*.\";"
  replace_string="String appId = \"$appId\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  search_string="static const shortName = \".*.\";"
  replace_string="static const shortName = \"$appName\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  echo "apple Id ----- $storeId --- $appId"
  search_string="const String appStoreId = \".*.\";"
  replace_string="const String appStoreId = \"$storeId\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  search_string="const String chPlayId = \".*.\";"
  replace_string="const String chPlayId = \"$chPlayId\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  search_string="static const USER_POLICY_LINK = \".*.\";"
  replace_string="static const USER_POLICY_LINK = \"$user_plolicy\";"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const String in_app_purchase_pro_id = \".*.\";"
  replace_string="const String in_app_purchase_pro_id = \"$premium_acc_id\";"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const USER_TERMS_CONDITIONS_LINK = \".*.\";"
  replace_string="static const USER_TERMS_CONDITIONS_LINK = \"$user_terms\";"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const TEST_MODE = .*.;"
  replace_string="static const TEST_MODE = false;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const int maxLevelApp = .*.;"
  replace_string="const int maxLevelApp = $maxLevelApp;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool mocktestOneCategory = .*.;"
  replace_string="const bool mocktestOneCategory = $mocktestOneCategory;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool hasFAQ = .*.;"
  replace_string="const bool hasFAQ = $hasFAQ;"
  sed -i "" "s+$search_string+$replace_string+" $configPath



  search_string="const bool newUiRoadMap = .*.;"
  replace_string="const bool newUiRoadMap = $newUiRoadMap;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static bool showAdsmob = .*.;"
  replace_string="static bool showAdsmob = $showAds;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool hasState = .*.;"
  replace_string="const bool hasState = $hasState;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

   search_string="const bool isToeicApp = .*.;"
  replace_string="const bool isToeicApp = $isToeicApp;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool openLoginGoogle = .*.;"
  replace_string="const bool openLoginGoogle = $openLoginGoogle;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

    search_string="const bool openLoginApple = .*.;"
  replace_string="const bool openLoginApple = $openLoginApple;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

    search_string="const bool openLoginFacebook = .*.;"
  replace_string="const bool openLoginFacebook = $openLoginFacebook;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

    search_string="const bool isOpenHomeScreenAfterLogin = .*.;"
  replace_string="const bool isOpenHomeScreenAfterLogin = $isOpenHomeScreenAfterLogin;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

    search_string="const bool openRoadMap = .*.;"
  replace_string="const bool openRoadMap = $openRoadMap;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool isOpenCheckPurchasedCouse = .*.;"
  replace_string="const bool isOpenCheckPurchasedCouse = $isOpenCheckPurchasedCouse;"
  sed -i "" "s+$search_string+$replace_string+" $configPath


  search_string="const bool hasFAQ = .*.;"
  replace_string="const bool hasFAQ = $hasFAQ;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool multiCourse = .*.;"
  replace_string="const bool multiCourse = $multiCourse;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

   search_string="static const apiEndPoint = \".*.\";"
  replace_string="static const apiEndPoint = \"$apiEndPoint\";"
  sed -i "" "s+$search_string+$replace_string+" $apiConfigPath

  search_string="const bool hasStudyPlan = .*.;"
  replace_string="const bool hasStudyPlan = $hasStudyPlan;"
  sed -i "" "s+$search_string+$replace_string+" $configPath


  search_string="const bool showMockTest = .*.;"
  replace_string="const bool showMockTest = $showMockTest;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const inAppPurchase = .*.;"
  replace_string="static const inAppPurchase = $inAppPurchase;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool showGridviewHome = .*.;"
  replace_string="const bool showGridviewHome = $showGridviewHome;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool showGridviewHomeXxxx = .*.;"
  replace_string="const bool showGridviewHomeXxxx = $showGridviewHomeXxxx;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const bool loadTopicMocktestAsMaxLevelApp_4 = .*.;"
  replace_string="const bool loadTopicMocktestAsMaxLevelApp_4 = $loadTopicMocktestAsMaxLevelApp_4;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const showTextSplash = .*.;"
  replace_string="static const showTextSplash = $showTextSplash;"
  sed -i "" "s+$search_string+$replace_string+" $configPath
  search_string="static const VERSION_CODE = \".*.\";"
  replace_string="static const VERSION_CODE = \"$2(+$3)\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  search_string="const String appName = \".*.\";"
  replace_string="const String appName = \"$name\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath
  search_string="const String FIRE_BASE_PROJECT_NAME = \".*.\";"
  replace_string="const String FIRE_BASE_PROJECT_NAME = \"$firebase_app_name\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath
  search_string="const String FIRE_BASE_PROJECT_ID = \".*.\";"
  replace_string="const String FIRE_BASE_PROJECT_ID = \"$firebase_project_id\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath
  search_string="const String FIRE_BASE_PROJECT_ID = \".*.\";"
  replace_string="const String FIRE_BASE_PROJECT_ID = \"$firebase_project_id\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  if [[ ! $osName == 'ios' ]]; then
    search_string="const String FIRE_BASE_APP_ID_ANDROID = \".*.\";"
    replace_string="const String FIRE_BASE_APP_ID_ANDROID = \"$firebase_app_id\";"
    sed -i "" "s/$search_string/$replace_string/" $configPath
  else
    search_string="const String FIRE_BASE_APP_ID_IOS = \".*.\";"
    replace_string="const String FIRE_BASE_APP_ID_IOS = \"$firebase_app_id\";"
    sed -i "" "s/$search_string/$replace_string/" $configPath
  fi

  search_string="const String FIRE_BASE_PROJECT_API_KEY = \".*.\";"
  replace_string="const String FIRE_BASE_PROJECT_API_KEY = \"$firebase_project_api_key\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath
  search_string="const String FIRE_BASE_PROJECT_NUMBER = \".*.\";"
  replace_string="const String FIRE_BASE_PROJECT_NUMBER = \"$firebase_project_number\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  search_string="static const ADMOB_APP_ID = \".*.\";"
  replace_string="static const ADMOB_APP_ID = \"$adModId\";"
  sed -i "" "s/$search_string/$replace_string/" $configPath

  search_string="static const BANNER_AD_ID = \".*.\";"
  replace_string="static const BANNER_AD_ID = \"$bannerId\";"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const INTERSTITIAL_AD_ID = \".*.\";"
  replace_string="static const INTERSTITIAL_AD_ID = \"$interstitialId\";"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const NATIVE_AD_ID = \".*.\";"

  replace_string="static const NATIVE_AD_ID = \"$nativeId\";"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  echo "Change Config Android"
  androidPath="android/app/src/main/AndroidManifest.xml"
  search_string="android:label=\".*.\""
  replace_string="android:label=\"$name\""
  sed -i "" "s/$search_string/$replace_string/" $androidPath

  search_string="android:value=\".*.\""
  replace_string="android:value=\"$adModId\""
  sed -i "" "12s/$search_string/$replace_string/" $androidPath

  androidBuildPath="android/app/build.gradle"
  search_string="applicationId \".*.\""
  replace_string="applicationId \"$packageName\""
  sed -i "" "s/$search_string/$replace_string/" $androidBuildPath

  search_string="const int minDurationMocktest = .*.;"
  replace_string="const int minDurationMocktest = $minDurationMocktest;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const int maxDurationMocktest = .*.;"
  replace_string="const int maxDurationMocktest = $maxDurationMocktest;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const int minQuestionMocktest = .*.;"
  replace_string="const int minQuestionMocktest = $minQuestionMocktest;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="const int maxQuestionMocktest = .*.;"
  replace_string="const int maxQuestionMocktest = $maxQuestionMocktest;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

  search_string="static const VERSION_DB = .*.;"
  replace_string="static const VERSION_DB = $version_db;"
  sed -i "" "s+$search_string+$replace_string+" $configPath

}
buildAndroid() {
  appName=$1
  packageName=$2
  version=$3
  buildNumberAndroid=$4
  test=$5

  if [[ $test == 'test' ]]; then
    echo "tét mode"
  else
    # flutter build apk
    flutter build appbundle --build-name=$version --build-number=$buildNumberAndroid
    # cp -r build/app/outputs/flutter-apk/app-release.apk "$_dropboxSource/$appName/${appName}_${version}($buildNumberAndroid).apk"
    cp -r build/app/outputs/bundle/release/app-release.aab "$_dropboxSource/$appName/${appName}_${version}($buildNumberAndroid).aab"
  fi
}
buildIOS() {
  echo "start build ios"
  shortName=$1
  version=$2
  buildNumber=$3
  test=$4
  appInfosPath="$project/app_configs.json"
  exportConfigPath="$project/ios/exportOptions.plist"

  ios_pbxproj_path="$project/ios/Runner.xcodeproj/project.pbxproj"
  ios_info_plist_path="$project/ios/Runner/Info.plist"

  dev_team_id=$(jq .$appName.ios.teamId $appInfosPath)
  dev_team_id=$(echo $dev_team_id | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  bundle_id=$(jq .$appName.ios.packageName $appInfosPath)
  bundle_id=$(echo $bundle_id | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  adModId=$(jq .$appName.ios.adModId $appInfosPath)
  adModId=$(echo $adModId | sed 's/[^a-zA-Z0-9# +.~/-]//g')

  app_name=$(jq .$appName.ios.name $appInfosPath)
  app_name=$(echo $app_name | sed 's/[^a-zA-Z0-9# +.~/-]//g')
  echo "app_name : $app_name"

  search_string="MARKETING_VERSION = .*.;"
  replace_string="MARKETING_VERSION = $version;"
  echo "$search_string/$replace_string/"
  sed -i "" "s/$search_string/$replace_string/" $ios_pbxproj_path

  search_string="CURRENT_PROJECT_VERSION = .*.;"
  replace_string="CURRENT_PROJECT_VERSION = $buildNumber;"
  echo "$search_string/$replace_string/"
  sed -i "" "s/$search_string/$replace_string/" $ios_pbxproj_path

  search_string="DEVELOPMENT_TEAM = .*.;"
  replace_string="DEVELOPMENT_TEAM = $dev_team_id;"
  echo "$search_string/$replace_string/"
  sed -i "" "s/$search_string/$replace_string/" $ios_pbxproj_path

  search_string="PRODUCT_BUNDLE_IDENTIFIER = .*.;"
  replace_string="PRODUCT_BUNDLE_IDENTIFIER = $bundle_id;"
  echo "$search_string/$replace_string/"
  sed -i "" "s/$search_string/$replace_string/" $ios_pbxproj_path
  echo " replace plist "
  search_string="<string>.*.</string>"
  replace_string="<string>$app_name</string>"
  echo "$search_string/$replace_string/"
  sed -i "" "10s+$search_string+$replace_string+" $ios_info_plist_path

  search_string="<string>.*.</string>"
  replace_string="<string>$bundle_id</string>"
  echo "$search_string/$replace_string/"
  sed -i "" "31s+$search_string+$replace_string+" $ios_info_plist_path
  # todo -ver 2: replace dynamic link in line 42

  search_string="<string>.*.</string>"
  replace_string="<string>$adModId</string>"
  echo "$search_string/$replace_string/"
  sed -i "" "45s+$search_string+$replace_string+" $ios_info_plist_path

  search_string="<string>.*.<\/string>"
  replace_string="<string>$dev_team_id<\/string>"
  sed -i "" "21s/$search_string/$replace_string/" $exportConfigPath

  if [[ $test == 'test' ]]; then
    echo "tét mode"
  else
    flutter build ios
    cd ios
    xcodebuild -workspace Runner.xcworkspace -scheme Runner -sdk iphoneos -configuration Release archive -archivePath $PWD/build/Runner.xcarchive
    xcodebuild -exportArchive -archivePath $PWD/build/Runner.xcarchive -exportOptionsPlist exportOptions.plist -exportPath $PWD/build/Runner.ipa -allowProvisioningUpdates
    cd ..
    ipaFile=$shortName.ipa
    cp "./ios/build/Runner.ipa/estudyme_toeic.ipa" /Users/$USER/Documents/IPA/$ipaFile
  fi

}

startTime=$(date +%s)
compile() {
  appName=$1
  version_android=$2
  version_ios=$3
  buildNumberIOS=$4
  buildNumberAndroid=$5
  version_db=$6
  type=$7
  osName=$8
  test=$9
  if [[ ! $osName == 'ios' ]]; then
    buildNumber=$buildNumberAndroid
    buildVersion=$version_android
    osName="android"
  else
    buildNumber=$buildNumberIOS
    buildVersion=$version_ios
  fi
  echo "$type App $appName ($osName) $type $buildVersion+$buildNumber"
  copyAssets $appName $osName
  getFlutterLibs $buildVersion $buildNumber
  changeAppName $appName $buildVersion $buildNumber $osName $type $version_db

  # flutter clean
  # flutter pub get
  # sleep 5
  if [[ $type == 'build' ]]; then
    if [[ $osName == 'ios' ]]; then
      buildIOS $appName $buildVersion $buildNumber $test
    else
      buildAndroid $appName $packageName $buildVersion $buildNumber $test
    fi
  elif [[ $type == 'run' ]]; then
    echo "vccc"
    # echo "Flutter run"
    # flutter run
  fi
}
#########   name      version_android     version_ios       number_ios      number_android
# compile "toeic" "1.0.0" "1.0.0" "2023080919" "2023080919" 8 $1 $2 $3 $4 $5 $6
compile "ielts" "1.0.0" "1.0.0" "2023080919" "2023080919" 8 $1 $2 $3 $4 $5 $6


endTime=$(date +%s)
totalTime=$(expr $endTime - $startTime)
echo "Total Time: $totalTime"
