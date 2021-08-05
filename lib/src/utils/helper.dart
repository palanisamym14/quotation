import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double get windowWidth => MediaQuery.of(_context!).size.width;
double get windowHeight => MediaQuery.of(_context!).size.height;

BuildContext? _context;
// this resolution is iphone 6/7/8
const int _mobileSizeWidth = 375;
const int _mobileSizeHeight = 667;
String convertTime(DateTime date) {
  final retVal = StringBuffer();
  if (date.hour < 10) {
    retVal.write('0');
  }
  retVal.write('${date.hour}:');

  if (date.minute < 10) {
    retVal.write('0');
  }
  retVal.write('${date.minute}');
  if (date.second > 0) {
    retVal.write(':');
    if (date.second < 10) {
      retVal.write('0');
    }
    retVal.write(date.second);
  }
  return retVal.toString();
}

String convertDate(DateTime date) {
  final retVal = StringBuffer('${date.year}-');

  if (date.month < 10) {
    retVal.write('0');
  }
  retVal.write('${date.month}-');

  if (date.day < 10) {
    retVal.write('0');
  }
  retVal.write(date.day);
  return retVal.toString();
}

double scaleWidth(double size) {
  final retVal = size * windowWidth / _mobileSizeWidth;
  return retVal;
}

double scaleHeight(double size) {
  final retVal = size * windowHeight / _mobileSizeHeight;
  return retVal;
}

Container imageFromNetwork(String? imgUrl) {
  if (imgUrl == null || imgUrl.isEmpty) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
      image: AssetImage('no-picture.png'),
      fit: BoxFit.cover,
    )));
  } else {
    return Container(child: Image.network(imgUrl));
  }
}

Container imageFromCache(String? imgUrl) {
  if (imgUrl == null || imgUrl.isEmpty) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
      image: AssetImage('no-picture.png'),
      fit: BoxFit.cover,
    )));
  } else {
    return Container(child: Image.network(imgUrl)
//CachedNetworkImage(
//   imageUrl: imgUrl,
//   placeholder: (context, url) => CircularProgressIndicator(),
//   errorWidget: (context, url, error) => Icon(Icons.error),),
        );
  }
}

Container imageFromCacheProvider(String? imgUrl) {
  if (imgUrl == null || imgUrl.isEmpty) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
      image: AssetImage('no-picture.png'),
      fit: BoxFit.cover,
    )));
  } else {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
      image: NetworkImage(imgUrl), // CachedNetworkImageProvider(imgUrl)
      fit: BoxFit.cover,
    )));
  }
}

void alertDialog(String message,
    {String title = "", VoidCallback? callBack}) async {
  return showDialog(
      context: _context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                if (callBack != null) {
                  callBack();
                }
              },
            ),
          ],
        );
      });
}

Future<bool?> confirmDialog(String message,
    [String title = 'SqfEntity Sample']) async {
  return showDialog<bool>(
    context: _context!,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  );
}

enum Choice { Delete, Update, Recover }
enum OrderBy { NameAsc, NameDesc, PriceAsc, PriceDesc, None }
final NumberFormat priceFormat = NumberFormat('#,##0.#', 'en_US');
