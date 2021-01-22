import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
                  onPressed: () {
                    controller.getList(controller.longUrl);
                  },
                  child: Text('Gerar link'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
          Expanded(
            child: controller.urlsList.isEmpty
                ? Center(
                    child: Text('Adicionar links!'),
                  )
                : Observer(
                    builder: (_) {
                      return ListView.builder(
                          itemCount: controller.urlsList.length,
                          itemBuilder: (context, index) {
                            var url = controller.urlsList[index];
                            return ListTile(
                              title: Text(url.shortUrl),
                              subtitle: Text(url.longUrl),
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