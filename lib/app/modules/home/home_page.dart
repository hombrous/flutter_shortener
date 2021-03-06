import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shortener/app/modules/models/urls_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Flutter Shortener"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (url) => controller.setLongUrl(url),
                    decoration:
                        InputDecoration(labelText: 'https://example.com'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: RaisedButton(
                  onPressed: () => controller.getUrls(controller.longUrl),
                  child: Text('Gerar link'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return controller.urlsList.isEmpty
                    ? Center(
                        child: Text('Coleção de links vazia!'),
                      )
                    : ListView.builder(
                        itemCount: controller.urlsList.length,
                        itemBuilder: (context, index) {
                          List<UrlsModel> urls = controller.urlsList[index];
                          return ListTile(
                            title: Text(urls[index].shortUrl),
                            subtitle: Text(urls[index].longUrl),
                          );
                        });
              },
            ),
          ),
        ],
      ),
    );
  }
}
