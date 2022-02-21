import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'toast.dart';

Future<void> intentView(String uri) async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_VIEW,
    data: uri,
  );
  await intent.launch();
}

Future<void> weixinQr() async => await intentView("weixin://qr");

Future<void> browerWeb(String url) async => await intentView(url);

Future<void> openApp(String packageName, String componentName) async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_MAIN,
    package: packageName,
    componentName: componentName,
  );
  await intent.launch();
}

Future<void> callPhone(String tel) async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_DIAL,
    data: "tel:$tel",
  );
  await intent.launch();
}

Future<void> toCallPanel() async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_CALL_BUTTON,
  );
  await intent.launch();
}

Future<void> sendSms(String tel, String sms) async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_SENDTO,
    data: "smsto:$tel",
    arguments: {"sms_body": sms},
  );
  await intent.launch();
}

Future<void> musicControl() async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_MUSIC_SERVICE_COMMAND,
    arguments: {"command": "togglepause"},
  );
  try {
    await intent.sendBroadcast();
    showToast("播放/暂停 音乐");
  } catch (e) {
    print(e);
  }
}

Future<void> playMusic(String musicUri) async {
  if (!Platform.isAndroid) return;
  final AndroidIntent intent = AndroidIntent(
    action: ACTION_VIEW,
    data: musicUri,
    type: "audio/mp3",
  );
  try {
    await intent.launch();
    showToast("播放音乐");
  } catch (e) {
    print(e);
  }
}

final String ACTION_MUSIC_SERVICE_COMMAND =
    "com.android.music.musicservicecommand";
final String ACTION_MUSIC_SERVICE_TOGGLEPAUSE =
    "com.android.music.musicservicecommand.togglepause";
final String ACTION_AIRPLANE_MODE_CHANGED =
    "android.intent.action.AIRPLANE_MODE";
final String ACTION_ALL_APPS = "android.intent.action.ALL_APPS";
final String ACTION_ANSWER = "android.intent.action.ANSWER";
final String ACTION_APPLICATION_PREFERENCES =
    "android.intent.action.APPLICATION_PREFERENCES";
final String ACTION_APPLICATION_RESTRICTIONS_CHANGED =
    "android.intent.action.APPLICATION_RESTRICTIONS_CHANGED";
final String ACTION_APP_ERROR = "android.intent.action.APP_ERROR";
final String ACTION_ASSIST = "android.intent.action.ASSIST";
final String ACTION_ATTACH_DATA = "android.intent.action.ATTACH_DATA";
final String ACTION_AUTO_REVOKE_PERMISSIONS =
    "android.intent.action.AUTO_REVOKE_PERMISSIONS";
final String ACTION_BATTERY_CHANGED = "android.intent.action.BATTERY_CHANGED";
final String ACTION_BATTERY_LOW = "android.intent.action.BATTERY_LOW";
final String ACTION_BATTERY_OKAY = "android.intent.action.BATTERY_OKAY";
final String ACTION_BOOT_COMPLETED = "android.intent.action.BOOT_COMPLETED";
final String ACTION_BUG_REPORT = "android.intent.action.BUG_REPORT";
final String ACTION_CALL = "android.intent.action.CALL";
final String ACTION_CALL_BUTTON = "android.intent.action.CALL_BUTTON";
final String ACTION_CAMERA_BUTTON = "android.intent.action.CAMERA_BUTTON";
final String ACTION_CARRIER_SETUP = "android.intent.action.CARRIER_SETUP";
final String ACTION_CHOOSER = "android.intent.action.CHOOSER";
final String ACTION_CLOSE_SYSTEM_DIALOGS =
    "android.intent.action.CLOSE_SYSTEM_DIALOGS";
final String ACTION_CONFIGURATION_CHANGED =
    "android.intent.action.CONFIGURATION_CHANGED";
final String ACTION_CREATE_DOCUMENT = "android.intent.action.CREATE_DOCUMENT";
final String ACTION_CREATE_REMINDER = "android.intent.action.CREATE_REMINDER";
final String ACTION_CREATE_SHORTCUT = "android.intent.action.CREATE_SHORTCUT";
final String ACTION_DATE_CHANGED = "android.intent.action.DATE_CHANGED";
final String ACTION_DEFAULT = "android.intent.action.VIEW";
final String ACTION_DEFINE = "android.intent.action.DEFINE";
final String ACTION_DELETE = "android.intent.action.DELETE";

final String ACTION_DEVICE_STORAGE_LOW =
    "android.intent.action.DEVICE_STORAGE_LOW";

final String ACTION_DEVICE_STORAGE_OK =
    "android.intent.action.DEVICE_STORAGE_OK";
final String ACTION_DIAL = "android.intent.action.DIAL";
final String ACTION_DOCK_EVENT = "android.intent.action.DOCK_EVENT";
final String ACTION_DREAMING_STARTED = "android.intent.action.DREAMING_STARTED";
final String ACTION_DREAMING_STOPPED = "android.intent.action.DREAMING_STOPPED";
final String ACTION_EDIT = "android.intent.action.EDIT";
final String ACTION_EXTERNAL_APPLICATIONS_AVAILABLE =
    "android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE";
final String ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE =
    "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE";
final String ACTION_FACTORY_TEST = "android.intent.action.FACTORY_TEST";
final String ACTION_GET_CONTENT = "android.intent.action.GET_CONTENT";
final String ACTION_GET_RESTRICTION_ENTRIES =
    "android.intent.action.GET_RESTRICTION_ENTRIES";
final String ACTION_GTALK_SERVICE_CONNECTED =
    "android.intent.action.GTALK_CONNECTED";
final String ACTION_GTALK_SERVICE_DISCONNECTED =
    "android.intent.action.GTALK_DISCONNECTED";
final String ACTION_HEADSET_PLUG = "android.intent.action.HEADSET_PLUG";
final String ACTION_INPUT_METHOD_CHANGED =
    "android.intent.action.INPUT_METHOD_CHANGED";
final String ACTION_INSERT = "android.intent.action.INSERT";
final String ACTION_INSERT_OR_EDIT = "android.intent.action.INSERT_OR_EDIT";
final String ACTION_INSTALL_FAILURE = "android.intent.action.INSTALL_FAILURE";

final String ACTION_INSTALL_PACKAGE = "android.intent.action.INSTALL_PACKAGE";
final String ACTION_LOCALE_CHANGED = "android.intent.action.LOCALE_CHANGED";
final String ACTION_LOCKED_BOOT_COMPLETED =
    "android.intent.action.LOCKED_BOOT_COMPLETED";
final String ACTION_MAIN = "android.intent.action.MAIN";
final String ACTION_MANAGED_PROFILE_ADDED =
    "android.intent.action.MANAGED_PROFILE_ADDED";
final String ACTION_MANAGED_PROFILE_AVAILABLE =
    "android.intent.action.MANAGED_PROFILE_AVAILABLE";
final String ACTION_MANAGED_PROFILE_REMOVED =
    "android.intent.action.MANAGED_PROFILE_REMOVED";
final String ACTION_MANAGED_PROFILE_UNAVAILABLE =
    "android.intent.action.MANAGED_PROFILE_UNAVAILABLE";
final String ACTION_MANAGED_PROFILE_UNLOCKED =
    "android.intent.action.MANAGED_PROFILE_UNLOCKED";
final String ACTION_MANAGE_NETWORK_USAGE =
    "android.intent.action.MANAGE_NETWORK_USAGE";
final String ACTION_MANAGE_PACKAGE_STORAGE =
    "android.intent.action.MANAGE_PACKAGE_STORAGE";
final String ACTION_MEDIA_BAD_REMOVAL =
    "android.intent.action.MEDIA_BAD_REMOVAL";
final String ACTION_MEDIA_BUTTON = "android.intent.action.MEDIA_BUTTON";
final String ACTION_MEDIA_CHECKING = "android.intent.action.MEDIA_CHECKING";
final String ACTION_MEDIA_EJECT = "android.intent.action.MEDIA_EJECT";
final String ACTION_MEDIA_MOUNTED = "android.intent.action.MEDIA_MOUNTED";
final String ACTION_MEDIA_NOFS = "android.intent.action.MEDIA_NOFS";
final String ACTION_MEDIA_REMOVED = "android.intent.action.MEDIA_REMOVED";
final String ACTION_MEDIA_SCANNER_FINISHED =
    "android.intent.action.MEDIA_SCANNER_FINISHED";

final String ACTION_MEDIA_SCANNER_SCAN_FILE =
    "android.intent.action.MEDIA_SCANNER_SCAN_FILE";
final String ACTION_MEDIA_SCANNER_STARTED =
    "android.intent.action.MEDIA_SCANNER_STARTED";
final String ACTION_MEDIA_SHARED = "android.intent.action.MEDIA_SHARED";
final String ACTION_MEDIA_UNMOUNTABLE =
    "android.intent.action.MEDIA_UNMOUNTABLE";
final String ACTION_MEDIA_UNMOUNTED = "android.intent.action.MEDIA_UNMOUNTED";
final String ACTION_MY_PACKAGE_REPLACED =
    "android.intent.action.MY_PACKAGE_REPLACED";
final String ACTION_MY_PACKAGE_SUSPENDED =
    "android.intent.action.MY_PACKAGE_SUSPENDED";
final String ACTION_MY_PACKAGE_UNSUSPENDED =
    "android.intent.action.MY_PACKAGE_UNSUSPENDED";

final String ACTION_NEW_OUTGOING_CALL =
    "android.intent.action.NEW_OUTGOING_CALL";
final String ACTION_OPEN_DOCUMENT = "android.intent.action.OPEN_DOCUMENT";
final String ACTION_OPEN_DOCUMENT_TREE =
    "android.intent.action.OPEN_DOCUMENT_TREE";
final String ACTION_PACKAGES_SUSPENDED =
    "android.intent.action.PACKAGES_SUSPENDED";
final String ACTION_PACKAGES_UNSUSPENDED =
    "android.intent.action.PACKAGES_UNSUSPENDED";
final String ACTION_PACKAGE_ADDED = "android.intent.action.PACKAGE_ADDED";
final String ACTION_PACKAGE_CHANGED = "android.intent.action.PACKAGE_CHANGED";
final String ACTION_PACKAGE_DATA_CLEARED =
    "android.intent.action.PACKAGE_DATA_CLEARED";
final String ACTION_PACKAGE_FIRST_LAUNCH =
    "android.intent.action.PACKAGE_FIRST_LAUNCH";
final String ACTION_PACKAGE_FULLY_REMOVED =
    "android.intent.action.PACKAGE_FULLY_REMOVED";

final String ACTION_PACKAGE_INSTALL = "android.intent.action.PACKAGE_INSTALL";
final String ACTION_PACKAGE_NEEDS_VERIFICATION =
    "android.intent.action.PACKAGE_NEEDS_VERIFICATION";
final String ACTION_PACKAGE_REMOVED = "android.intent.action.PACKAGE_REMOVED";
final String ACTION_PACKAGE_REPLACED = "android.intent.action.PACKAGE_REPLACED";
final String ACTION_PACKAGE_RESTARTED =
    "android.intent.action.PACKAGE_RESTARTED";
final String ACTION_PACKAGE_VERIFIED = "android.intent.action.PACKAGE_VERIFIED";
final String ACTION_PASTE = "android.intent.action.PASTE";
final String ACTION_PICK = "android.intent.action.PICK";
final String ACTION_PICK_ACTIVITY = "android.intent.action.PICK_ACTIVITY";
final String ACTION_POWER_CONNECTED =
    "android.intent.action.ACTION_POWER_CONNECTED";
final String ACTION_POWER_DISCONNECTED =
    "android.intent.action.ACTION_POWER_DISCONNECTED";
final String ACTION_POWER_USAGE_SUMMARY =
    "android.intent.action.POWER_USAGE_SUMMARY";
final String ACTION_PROCESS_TEXT = "android.intent.action.PROCESS_TEXT";
final String ACTION_PROVIDER_CHANGED = "android.intent.action.PROVIDER_CHANGED";
final String ACTION_QUICK_CLOCK = "android.intent.action.QUICK_CLOCK";
final String ACTION_QUICK_VIEW = "android.intent.action.QUICK_VIEW";
final String ACTION_REBOOT = "android.intent.action.REBOOT";
final String ACTION_RUN = "android.intent.action.RUN";
final String ACTION_SCREEN_OFF = "android.intent.action.SCREEN_OFF";
final String ACTION_SCREEN_ON = "android.intent.action.SCREEN_ON";
final String ACTION_SEARCH = "android.intent.action.SEARCH";
final String ACTION_SEARCH_LONG_PRESS =
    "android.intent.action.SEARCH_LONG_PRESS";
final String ACTION_SEND = "android.intent.action.SEND";
final String ACTION_SENDTO = "android.intent.action.SENDTO";
final String ACTION_SEND_MULTIPLE = "android.intent.action.SEND_MULTIPLE";
final String ACTION_SET_WALLPAPER = "android.intent.action.SET_WALLPAPER";
final String ACTION_SHOW_APP_INFO = "android.intent.action.SHOW_APP_INFO";
final String ACTION_SHUTDOWN = "android.intent.action.ACTION_SHUTDOWN";
final String ACTION_SYNC = "android.intent.action.SYNC";
final String ACTION_SYSTEM_TUTORIAL = "android.intent.action.SYSTEM_TUTORIAL";
final String ACTION_TIMEZONE_CHANGED = "android.intent.action.TIMEZONE_CHANGED";
final String ACTION_TIME_CHANGED = "android.intent.action.TIME_SET";
final String ACTION_TIME_TICK = "android.intent.action.TIME_TICK";
final String ACTION_TRANSLATE = "android.intent.action.TRANSLATE";
final String ACTION_UID_REMOVED = "android.intent.action.UID_REMOVED";

final String ACTION_UMS_CONNECTED = "android.intent.action.UMS_CONNECTED";
final String ACTION_UMS_DISCONNECTED = "android.intent.action.UMS_DISCONNECTED";

final String ACTION_UNINSTALL_PACKAGE =
    "android.intent.action.UNINSTALL_PACKAGE";
final String ACTION_USER_BACKGROUND = "android.intent.action.USER_BACKGROUND";
final String ACTION_USER_FOREGROUND = "android.intent.action.USER_FOREGROUND";
final String ACTION_USER_INITIALIZE = "android.intent.action.USER_INITIALIZE";
final String ACTION_USER_PRESENT = "android.intent.action.USER_PRESENT";
final String ACTION_USER_UNLOCKED = "android.intent.action.USER_UNLOCKED";
final String ACTION_VIEW = "android.intent.action.VIEW";
final String ACTION_VIEW_LOCUS = "android.intent.action.VIEW_LOCUS";
final String ACTION_VIEW_PERMISSION_USAGE =
    "android.intent.action.VIEW_PERMISSION_USAGE";
final String ACTION_VOICE_COMMAND = "android.intent.action.VOICE_COMMAND";

final String ACTION_WALLPAPER_CHANGED =
    "android.intent.action.WALLPAPER_CHANGED";
final String ACTION_WEB_SEARCH = "android.intent.action.WEB_SEARCH";
final String CATEGORY_ACCESSIBILITY_SHORTCUT_TARGET =
    "android.intent.category.ACCESSIBILITY_SHORTCUT_TARGET";
final String CATEGORY_ALTERNATIVE = "android.intent.category.ALTERNATIVE";
final String CATEGORY_APP_BROWSER = "android.intent.category.APP_BROWSER";
final String CATEGORY_APP_CALCULATOR = "android.intent.category.APP_CALCULATOR";
final String CATEGORY_APP_CALENDAR = "android.intent.category.APP_CALENDAR";
final String CATEGORY_APP_CONTACTS = "android.intent.category.APP_CONTACTS";
final String CATEGORY_APP_EMAIL = "android.intent.category.APP_EMAIL";
final String CATEGORY_APP_FILES = "android.intent.category.APP_FILES";
final String CATEGORY_APP_GALLERY = "android.intent.category.APP_GALLERY";
final String CATEGORY_APP_MAPS = "android.intent.category.APP_MAPS";
final String CATEGORY_APP_MARKET = "android.intent.category.APP_MARKET";
final String CATEGORY_APP_MESSAGING = "android.intent.category.APP_MESSAGING";
final String CATEGORY_APP_MUSIC = "android.intent.category.APP_MUSIC";
final String CATEGORY_BROWSABLE = "android.intent.category.BROWSABLE";
final String CATEGORY_CAR_DOCK = "android.intent.category.CAR_DOCK";
final String CATEGORY_CAR_MODE = "android.intent.category.CAR_MODE";
final String CATEGORY_DEFAULT = "android.intent.category.DEFAULT";
final String CATEGORY_DESK_DOCK = "android.intent.category.DESK_DOCK";
final String CATEGORY_DEVELOPMENT_PREFERENCE =
    "android.intent.category.DEVELOPMENT_PREFERENCE";
final String CATEGORY_EMBED = "android.intent.category.EMBED";
final String CATEGORY_FRAMEWORK_INSTRUMENTATION_TEST =
    "android.intent.category.FRAMEWORK_INSTRUMENTATION_TEST";
final String CATEGORY_HE_DESK_DOCK = "android.intent.category.HE_DESK_DOCK";
final String CATEGORY_HOME = "android.intent.category.HOME";
final String CATEGORY_INFO = "android.intent.category.INFO";
final String CATEGORY_LAUNCHER = "android.intent.category.LAUNCHER";
final String CATEGORY_LEANBACK_LAUNCHER =
    "android.intent.category.LEANBACK_LAUNCHER";
final String CATEGORY_LE_DESK_DOCK = "android.intent.category.LE_DESK_DOCK";
final String CATEGORY_MONKEY = "android.intent.category.MONKEY";
final String CATEGORY_OPENABLE = "android.intent.category.OPENABLE";
final String CATEGORY_PREFERENCE = "android.intent.category.PREFERENCE";
final String CATEGORY_SAMPLE_CODE = "android.intent.category.SAMPLE_CODE";
final String CATEGORY_SECONDARY_HOME = "android.intent.category.SECONDARY_HOME";
final String CATEGORY_SELECTED_ALTERNATIVE =
    "android.intent.category.SELECTED_ALTERNATIVE";
final String CATEGORY_TAB = "android.intent.category.TAB";
final String CATEGORY_TEST = "android.intent.category.TEST";
final String CATEGORY_TYPED_OPENABLE = "android.intent.category.TYPED_OPENABLE";
final String CATEGORY_UNIT_TEST = "android.intent.category.UNIT_TEST";
final String CATEGORY_VOICE = "android.intent.category.VOICE";
final String CATEGORY_VR_HOME = "android.intent.category.VR_HOME";

final String EXTRA_ALARM_COUNT = "android.intent.extra.ALARM_COUNT";
final String EXTRA_ALLOW_MULTIPLE = "android.intent.extra.ALLOW_MULTIPLE";

final String EXTRA_ALLOW_REPLACE = "android.intent.extra.ALLOW_REPLACE";
final String EXTRA_ALTERNATE_INTENTS = "android.intent.extra.ALTERNATE_INTENTS";
final String EXTRA_ASSIST_CONTEXT = "android.intent.extra.ASSIST_CONTEXT";
final String EXTRA_ASSIST_INPUT_DEVICE_ID =
    "android.intent.extra.ASSIST_INPUT_DEVICE_ID";
final String EXTRA_ASSIST_INPUT_HINT_KEYBOARD =
    "android.intent.extra.ASSIST_INPUT_HINT_KEYBOARD";
final String EXTRA_ASSIST_PACKAGE = "android.intent.extra.ASSIST_PACKAGE";
final String EXTRA_ASSIST_UID = "android.intent.extra.ASSIST_UID";
final String EXTRA_AUTO_LAUNCH_SINGLE_CHOICE =
    "android.intent.extra.AUTO_LAUNCH_SINGLE_CHOICE";
final String EXTRA_BCC = "android.intent.extra.BCC";
final String EXTRA_BUG_REPORT = "android.intent.extra.BUG_REPORT";
final String EXTRA_CC = "android.intent.extra.CC";

final String EXTRA_CHANGED_COMPONENT_NAME =
    "android.intent.extra.changed_component_name";
final String EXTRA_CHANGED_COMPONENT_NAME_LIST =
    "android.intent.extra.changed_component_name_list";
final String EXTRA_CHANGED_PACKAGE_LIST =
    "android.intent.extra.changed_package_list";
final String EXTRA_CHANGED_UID_LIST = "android.intent.extra.changed_uid_list";
final String EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER =
    "android.intent.extra.CHOOSER_REFINEMENT_INTENT_SENDER";
final String EXTRA_CHOOSER_TARGETS = "android.intent.extra.CHOOSER_TARGETS";
final String EXTRA_CHOSEN_COMPONENT = "android.intent.extra.CHOSEN_COMPONENT";
final String EXTRA_CHOSEN_COMPONENT_INTENT_SENDER =
    "android.intent.extra.CHOSEN_COMPONENT_INTENT_SENDER";
final String EXTRA_COMPONENT_NAME = "android.intent.extra.COMPONENT_NAME";
final String EXTRA_CONTENT_ANNOTATIONS =
    "android.intent.extra.CONTENT_ANNOTATIONS";
final String EXTRA_CONTENT_QUERY = "android.intent.extra.CONTENT_QUERY";
final String EXTRA_DATA_REMOVED = "android.intent.extra.DATA_REMOVED";
final String EXTRA_DOCK_STATE = "android.intent.extra.DOCK_STATE";
final int EXTRA_DOCK_STATE_CAR = 2;
final int EXTRA_DOCK_STATE_DESK = 1;
final int EXTRA_DOCK_STATE_HE_DESK = 4;
final int EXTRA_DOCK_STATE_LE_DESK = 3;
final int EXTRA_DOCK_STATE_UNDOCKED = 0;
final String EXTRA_DONT_KILL_APP = "android.intent.extra.DONT_KILL_APP";
final String EXTRA_DURATION_MILLIS = "android.intent.extra.DURATION_MILLIS";
final String EXTRA_EMAIL = "android.intent.extra.EMAIL";
final String EXTRA_EXCLUDE_COMPONENTS =
    "android.intent.extra.EXCLUDE_COMPONENTS";
final String EXTRA_FROM_STORAGE = "android.intent.extra.FROM_STORAGE";
final String EXTRA_HTML_TEXT = "android.intent.extra.HTML_TEXT";
final String EXTRA_INDEX = "android.intent.extra.INDEX";
final String EXTRA_INITIAL_INTENTS = "android.intent.extra.INITIAL_INTENTS";
final String EXTRA_INSTALLER_PACKAGE_NAME =
    "android.intent.extra.INSTALLER_PACKAGE_NAME";
final String EXTRA_INTENT = "android.intent.extra.INTENT";
final String EXTRA_KEY_EVENT = "android.intent.extra.KEY_EVENT";
final String EXTRA_LOCAL_ONLY = "android.intent.extra.LOCAL_ONLY";
final String EXTRA_LOCUS_ID = "android.intent.extra.LOCUS_ID";
final String EXTRA_MIME_TYPES = "android.intent.extra.MIME_TYPES";
final String EXTRA_NOT_UNKNOWN_SOURCE =
    "android.intent.extra.NOT_UNKNOWN_SOURCE";
final String EXTRA_ORIGINATING_URI = "android.intent.extra.ORIGINATING_URI";
final String EXTRA_PACKAGE_NAME = "android.intent.extra.PACKAGE_NAME";
final String EXTRA_PHONE_NUMBER = "android.intent.extra.PHONE_NUMBER";
final String EXTRA_PROCESS_TEXT = "android.intent.extra.PROCESS_TEXT";
final String EXTRA_PROCESS_TEXT_READONLY =
    "android.intent.extra.PROCESS_TEXT_READONLY";
final String EXTRA_QUICK_VIEW_FEATURES =
    "android.intent.extra.QUICK_VIEW_FEATURES";
final String EXTRA_QUIET_MODE = "android.intent.extra.QUIET_MODE";
final String EXTRA_REFERRER = "android.intent.extra.REFERRER";
final String EXTRA_REFERRER_NAME = "android.intent.extra.REFERRER_NAME";
final String EXTRA_REMOTE_INTENT_TOKEN =
    "android.intent.extra.remote_intent_token";
final String EXTRA_REPLACEMENT_EXTRAS =
    "android.intent.extra.REPLACEMENT_EXTRAS";
final String EXTRA_REPLACING = "android.intent.extra.REPLACING";
final String EXTRA_RESTRICTIONS_BUNDLE =
    "android.intent.extra.restrictions_bundle";
final String EXTRA_RESTRICTIONS_INTENT =
    "android.intent.extra.restrictions_intent";
final String EXTRA_RESTRICTIONS_LIST = "android.intent.extra.restrictions_list";
final String EXTRA_RESULT_RECEIVER = "android.intent.extra.RESULT_RECEIVER";
final String EXTRA_RETURN_RESULT = "android.intent.extra.RETURN_RESULT";

final String EXTRA_SHORTCUT_ICON = "android.intent.extra.shortcut.ICON";

final String EXTRA_SHORTCUT_ICON_RESOURCE =
    "android.intent.extra.shortcut.ICON_RESOURCE";
final String EXTRA_SHORTCUT_ID = "android.intent.extra.shortcut.ID";

final String EXTRA_SHORTCUT_INTENT = "android.intent.extra.shortcut.INTENT";

final String EXTRA_SHORTCUT_NAME = "android.intent.extra.shortcut.NAME";
final String EXTRA_SHUTDOWN_USERSPACE_ONLY =
    "android.intent.extra.SHUTDOWN_USERSPACE_ONLY";
final String EXTRA_SPLIT_NAME = "android.intent.extra.SPLIT_NAME";
final String EXTRA_STREAM = "android.intent.extra.STREAM";
final String EXTRA_SUBJECT = "android.intent.extra.SUBJECT";
final String EXTRA_SUSPENDED_PACKAGE_EXTRAS =
    "android.intent.extra.SUSPENDED_PACKAGE_EXTRAS";
final String EXTRA_TEMPLATE = "android.intent.extra.TEMPLATE";
final String EXTRA_TEXT = "android.intent.extra.TEXT";
final String EXTRA_TIME = "android.intent.extra.TIME";
final String EXTRA_TIMEZONE = "time-zone";
final String EXTRA_TITLE = "android.intent.extra.TITLE";
final String EXTRA_UID = "android.intent.extra.UID";
final String EXTRA_USER = "android.intent.extra.USER";
final int FILL_IN_ACTION = 1;
final int FILL_IN_CATEGORIES = 4;
final int FILL_IN_CLIP_DATA = 128;
final int FILL_IN_COMPONENT = 8;
final int FILL_IN_DATA = 2;
final int FILL_IN_IDENTIFIER = 256;
final int FILL_IN_PACKAGE = 16;
final int FILL_IN_SELECTOR = 64;
final int FILL_IN_SOURCE_BOUNDS = 32;
final int FLAG_ACTIVITY_BROUGHT_TO_FRONT = 4194304;
final int FLAG_ACTIVITY_CLEAR_TASK = 32768;
final int FLAG_ACTIVITY_CLEAR_TOP = 67108864;

final int FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET = 524288;
final int FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS = 8388608;
final int FLAG_ACTIVITY_FORWARD_RESULT = 33554432;
final int FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY = 1048576;
final int FLAG_ACTIVITY_LAUNCH_ADJACENT = 4096;
final int FLAG_ACTIVITY_MATCH_EXTERNAL = 2048;
final int FLAG_ACTIVITY_MULTIPLE_TASK = 134217728;
final int FLAG_ACTIVITY_NEW_DOCUMENT = 524288;
final int FLAG_ACTIVITY_NEW_TASK = 268435456;
final int FLAG_ACTIVITY_NO_ANIMATION = 65536;
final int FLAG_ACTIVITY_NO_HISTORY = 1073741824;
final int FLAG_ACTIVITY_NO_USER_ACTION = 262144;
final int FLAG_ACTIVITY_PREVIOUS_IS_TOP = 16777216;
final int FLAG_ACTIVITY_REORDER_TO_FRONT = 131072;
final int FLAG_ACTIVITY_REQUIRE_DEFAULT = 512;
final int FLAG_ACTIVITY_REQUIRE_NON_BROWSER = 1024;
final int FLAG_ACTIVITY_RESET_TASK_IF_NEEDED = 2097152;
final int FLAG_ACTIVITY_RETAIN_IN_RECENTS = 8192;
final int FLAG_ACTIVITY_SINGLE_TOP = 536870912;
final int FLAG_ACTIVITY_TASK_ON_HOME = 16384;
final int FLAG_DEBUG_LOG_RESOLUTION = 8;
final int FLAG_DIRECT_BOOT_AUTO = 256;
final int FLAG_EXCLUDE_STOPPED_PACKAGES = 16;
final int FLAG_FROM_BACKGROUND = 4;
final int FLAG_GRANT_PERSISTABLE_URI_PERMISSION = 64;
final int FLAG_GRANT_PREFIX_URI_PERMISSION = 128;
final int FLAG_GRANT_READ_URI_PERMISSION = 1;
final int FLAG_GRANT_WRITE_URI_PERMISSION = 2;
final int FLAG_INCLUDE_STOPPED_PACKAGES = 32;
final int FLAG_RECEIVER_FOREGROUND = 268435456;
final int FLAG_RECEIVER_NO_ABORT = 134217728;
final int FLAG_RECEIVER_REGISTERED_ONLY = 1073741824;
final int FLAG_RECEIVER_REPLACE_PENDING = 536870912;
final int FLAG_RECEIVER_VISIBLE_TO_INSTANT_APPS = 2097152;
final String METADATA_DOCK_HOME = "android.dock_home";
final int URI_ALLOW_UNSAFE = 4;
final int URI_ANDROID_APP_SCHEME = 2;
final int URI_INTENT_SCHEME = 1;
