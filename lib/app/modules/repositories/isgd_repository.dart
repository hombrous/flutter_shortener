import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_shortener/app/modules/models/isgd_model.dart';
import 'package:flutter_shortener/app/modules/models/urls_view_model.dart';

class IsGdRepository {
  var dio;

  Future<dynamic> shortingUrl(String longUrl) async {
    dio = Dio();
    try {
      Response response =
          await dio.get('https://is.gd/create.php?format=json&url=$longUrl');

      var res = await json.decode(response.data);

      IsGdModel shortResponse = IsGdModel.fromJson(res);

      if (longUrl.isNotEmpty && shortResponse.shorturl != null) {
        final urls =
            UrlsViewModel(longUrl: longUrl, shortUrl: shortResponse.shorturl);
        return urls;
      } else {
        print(shortResponse.errormessage);
        return shortResponse.errormessage;
      }
    } catch (e) {
      print('Esse é o Erro: $e');
    }

    print('Fim do processo!');
  }
}
