import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/model/GameScreenModel.dart';
import 'package:http/http.dart' as http;

class DetailWidget extends StatefulWidget {
  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  bool isLoader = false;
  GameScreenModel gameScreenModels;
  @override
  void initState() {
    super.initState();
    gameScreenModels = GameScreenModel();
    _apiCall();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoader) {
      return CircularProgressIndicator();
    } else {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            var apiData = gameScreenModels?.data?.tournaments;

            return gameScreenModels?.data?.tournaments == null
                ? Container()
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        /*Network Image quality was high, for which app was crashing. SO I have use the local image for reference.*/
                        child: Image.asset(
                          'asset/logo/game.tcLogo.png',
                        ),
                      ),
                      Positioned.fill(
                        top: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Flexible(
                                  child: ListTile(
                                    title: Text(
                                      apiData[index].name,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    subtitle: Text(apiData[index].gameName),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      );
    }
  }

  /* API Call */
  _apiCall() async {
    /*I am still learning and I have very less idea about pagination api call.*/
    String url =
        "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all";
    setState(() {
      isLoader = true;
    });
    http.Response response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = jsonDecode(response.body);
      GameScreenModel gameScreenModel = GameScreenModel.fromJson(json);
      setState(() {
        gameScreenModels = gameScreenModel;
        isLoader = false;
      });
      return gameScreenModel;
    } else {
      setState(() {
        isLoader = false;
      });
      print("Failed to load data,");
    }
  }
}
