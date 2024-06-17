import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:html/parser.dart';

import 'index.dart';
import 'package:intl/intl.dart';

class ClientUltis {
  static String convertStatus(int status) {
    String message = "";
    switch (status) {
      case Configs.FAILED:
        {
          message = "Đăng nhập thất bại";
          break;
        }
      case Configs.WRONG_PWD:
        {
          message = "Sai mật khẩu";
          break;
        }
      case Configs.ACCOUNT_IS_USED:
        {
          message = "Tài khoản đã được sử dụng";
          break;
        }

      case Configs.TOKEN_VALID:
        {
          message = "Phiên đăng nhập hết hạn";
          break;
        }

      case Configs.ACCOUNT_WAIT_FOR_VERIFY:
        {
          message = "ACCOUNT_WAIT_FOR_VERIFY ";
          break;
        }
      case Configs.ACCOUNT_NOT_EXISTS:
        {
          message = "Tài khoản không tồn tại";
          break;
        }
    }
    return message;
  }

  static String getIdsFromList(List<dynamic> list) {
    String data = '';
    int index = 0;
    for (var q in list) {
      if (index > 0) {
        data += ',';
      }
      data += "${q}";
      index++;
    }
    data += '';
    return data;
  }

  static String convertIntToTime(int t) {
    int timeCeil = (t / 1000).ceil(); //giay
    String time = "";
    if (timeCeil < 60) {
      time = "${timeCeil}s";
    } else {
      if (timeCeil >= 60 && timeCeil <= 60 * 60) {
        int minute = timeCeil ~/ 60;
        int second = ((t - minute * 60 * 1000) / 1000).ceil();
        if (second > 0)
          time = "${minute}m" + second.toString() + "s";
        else
          time = "${minute}m";
      }
    }
    return time;
  }

  static String removeHtmlTag(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? "";

    return parsedString;
  }

  static List<T> pickRandomItemsAsList<T>(List<T> items, int count) =>
      (items.toList()..shuffle()).take(count).toList();
  static String convertDateComment(int date) {
    String time = "";
    int toDayDate = DateTime.now().millisecondsSinceEpoch;
    int second = (toDayDate / 1000 - date / 1000).round();

    if (second < 60) {
      time = "1 minute ago";
    } else if (second >= 60 && second < 60 * 60) {
      int minute = second ~/ 60;
      time = "$minute ${minute > 1 ? "minutes ago" : "minute ago"}";
    } else if (second >= 60 * 60 && second < 24 * 60 * 60) {
      int hour = second ~/ (60 * 60);
      // int minute = (second % (60 * 60)) ~/ 60;
      time = "$hour hour ago";
    } else {
      DateTime t = DateTime.fromMillisecondsSinceEpoch(date);
      String formattedDate = DateFormat('dd/MM/yyyy').format(t);
      time = formattedDate;
    }
    return time;
  }

  static List<String> stringToListString(String data) {
    data = data.replaceAll("  ", " ");
    List<String> s = [];
    s = data
        .replaceAll(RegExp('\\n'), ' ')
        .replaceAll(RegExp(r'-'), ' ')
        .split(" ")
      ..removeWhere((element) => element == " ");
    return s;
  }

  static bool textCompareTo({required String text1, required String text2}) {
    int checkCompare = text1
        .toLowerCase()
        .replaceAll(RegExp('[^A-Za-z0-9]'), '')
        .compareTo(text2.toLowerCase().replaceAll(RegExp('[^A-Za-z0-9]'), ''));
    return (checkCompare < 0 || checkCompare > 0) ? false : true;
  }

  static Future<List<FileSystemEntity>> dirContents(Directory dir) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen((file) => files.add(file),
        // should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }

  static String getFileName(String path) {
    return path.split("/").last;
  }

  static String getTimeCreteFile(String path) {
    final stat = FileStat.statSync(path);
    DateFormat("hh:mm");
    Duration diff =
        getStartDate(DateTime.now()).difference(getStartDate(stat.accessed));

    String createDate = "";
    if (diff.inHours < 24) {
      createDate = "Today at ${DateFormat("HH:mm").format(stat.accessed)}";
    } else {
      createDate = DateFormat('yyyy-MM-dd HH:mm').format(stat.accessed);
    }
    return createDate;
  }

  static DateTime getStartDate(DateTime time) {
    DateTime date = DateTime(time.year, time.month, time.day);
    return date;
  }

  static String getTimeAudio(Duration duration, {bool hasHour = true}) {
    if (hasHour) {
      return "${duration.inHours.remainder(24).toString().padLeft(2, "0")}:${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
    } else {
      return "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
    }
  }

  static double percentProgressBar(Duration a, Duration b) {
    if (a.inSeconds != 0 && b.inSeconds != 0) return a.inSeconds / b.inSeconds;
    return 0;
  }

  static String generateTopicProgressId(
      int courseId, int topicId, String userId) {
    return courseId.toString() + "_" + topicId.toString() + "_" + userId;
  }

  static String generateCardProgressId(
      int courseId, int cardId, String userId) {
    return courseId.toString() + "_" + cardId.toString() + "_" + userId;
  }

  static int percentCompareDocs(
      {required List<String> doc1, required List<String> doc2}) {
    int per = 0;
    int count = 0;
    for (int i = 0; i < doc1.length; i++) {
      if (textCompareTo(text1: doc1[i], text2: doc2[i])) {
        count++;
      }
    }
    per = ((count / doc1.length) * 100).toInt();
    print("progresspass $per");
    return per;
  }

  static double percentToStar(int per) {
    double start = 0;
    if (per >= 80 && per <= 85) {
      start = 1;
    } else {
      if (per >= 85 && per <= 90) {
        start = 2;
      } else {
        if (per >= 90 && per <= 95) {
          start = 3;
        } else {
          if (per >= 95 && per < 100) {
            start = 4;
          }
          if (per >= 100) start = 5;
        }
      }
    }
    return start;
  }

  static bool checkListSame(List<String> a, List<String> b) {
    bool check = false;
    List<String> c = [];
    if (a.length >= b.length) {
      c = a;
    } else
      c = b;
    int count = 0;
    for (int i = 0; i < c.length; i++) {
      if (!textCompareTo(text1: a[i], text2: b[i])) {
        check = false;
        return check;
      } else {
        count++;
      }
    }
    if (count == c.length) check = true;
    return check;
  }

  static String listStringToText(List<String> data) {
    String text = "";
    data.forEach((element) {
      text += element + " ";
    });
    return text.trim();
  }

  static String getLinkVideo(String description) {
    String url = "";
    var document = parse(description);
    if (document.getElementsByTagName("img").isNotEmpty) {
      url = document
          .getElementsByTagName("img")[0]
          .attributes["src-video-js"]
          .toString();
    }
    print("url video ${url.trim()} ");
    return url.trim();
  }

  static List<Color> converProgressToColor(int progress) {
    List<Color> colors = [];
    if (progress == 0) {
      colors = [Color(0xffDCE2EE), Color(0xffFFFFFF)];
    } else if (progress <= 50) {
      colors = [Color(0xffDEAEF4), Color(0xff815BEF)];
    } else {
      if (progress > 50 && progress < 100) {
        colors = [Color(0xff2087FF), Color(0xff73ACEE)];
      } else
        colors = [Color(0xff7EE2A6), Color.fromARGB(255, 40, 193, 101)];
    }
    return colors;
  }

  static String myCardDataId(
      {required String userId, required int courseId, required int topicId}) {
    return userId + "_" + topicId.toString() + "_" + courseId.toString();
  }

  static String intToTime(int t) {
    if (t == -1) return "--/--";
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(t);

    // Định dạng thời gian
    DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
}
