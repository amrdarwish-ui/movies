import 'dart:ui';
import 'package:movies/Services/api.dart';
import 'package:movies/Services/url_luncher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class Reveiw extends StatefulWidget {
  int id;
  String image;
  String name;
  String keyy;
  String overview;
  Reveiw(
      {this.keyy,
      @required this.id,
      @required this.name,
      @required this.image,
      this.overview});

  @override
  _ReveiwState createState() => _ReveiwState(id: id, name: name, image: image);
}

class _ReveiwState extends State<Reveiw> {
  int id;
  String name;
  String image;
  _ReveiwState({this.id, this.name, this.image});
  YoutubePlayerController _playerController;

  @override
  void initState() {
    print("id = $id");
    print(widget.keyy);
    runYoutubePlayer();

    super.initState();
  }

  @override
  void deactivate() {
    _playerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  void runYoutubePlayer() {
    var url = "https://www.youtube.com/watch?v=${widget.keyy}";
    _playerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: true,
        ));
  }

  UrlLuncher luncher = UrlLuncher();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff07080F),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xff303352),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://www.themoviedb.org/t/p/w600_and_h900_bestv2$image"))),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff303352),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Watch trailer",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: YoutubePlayer(
                            controller: _playerController,
                            onReady: () {
                              _playerController.play();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Container(
                    child: Text(
                      "$name",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.overview}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          luncher.lunch("https://egar.egybest.run/explore/?q=$name");
        },
        elevation: 10,
        backgroundColor: Color(0xff303352),
        label: Text(
          "Watch on egybest",
          style: TextStyle(fontSize: 16),
        ),
        autofocus: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
