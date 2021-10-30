import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Pages/Reveiw.dart';
import 'package:movies/Services/Api.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  static String keyy;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff07080F),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff07080F),
        leading: IconButton(
          onPressed: () {
            exit(0);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xff303352),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Top 10",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                future: api.getMovie(1),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "loading",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return CarouselSlider.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index, realIndex) {
                          return GestureDetector(
                            onTap: () async {
                              int id = snapshot.data[index].id;
                              await api.getVideo(id);
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Reveiw(
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].title,
                                    image: snapshot.data[index].poster_path,
                                    keyy: Home.keyy,
                                    overview: snapshot.data[index].overview,
                                  );
                                },
                              ));
                              print("From Navvvvvvvvvv '${Home.keyy}'");
                            },
                            child: Container(
                              height: 200,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xff303352),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://www.themoviedb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].poster_path}"),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color:
                                              Color(0xff303352).withOpacity(.8),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              topRight: Radius.circular(30))),
                                      child: Center(
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Color(0xff303352)
                                                .withOpacity(.8),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                topRight: Radius.circular(15))),
                                        child: Center(
                                            child: Text(
                                          "${snapshot.data[index].vote_average.toString()}/10",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: false,
                            height: 200,
                            pageSnapping: false,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true));
                  }
                },
              ),
            ),
            Text(
              "Best Movies",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FutureBuilder(
                future: api.getMovie(2),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "loading",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              int id = snapshot.data[index].id;
                              await api.getVideo(id);
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Reveiw(
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].title,
                                    image: snapshot.data[index].poster_path,
                                    keyy: Home.keyy,
                                    overview: snapshot.data[index].overview,
                                  );
                                },
                              ));
                              print("From Navvvvvvvvvv '${Home.keyy}'");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 170,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff303352),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].poster_path}"))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff303352),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Rate : ${snapshot.data[index].vote_average.toString()}/10",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FutureBuilder(
                future: api.getMovie(3),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "loading",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              int id = snapshot.data[index].id;
                              await api.getVideo(id);
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Reveiw(
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].title,
                                    image: snapshot.data[index].poster_path,
                                    keyy: Home.keyy,
                                    overview: snapshot.data[index].overview,
                                  );
                                },
                              ));
                              print("From Navvvvvvvvvv '${Home.keyy}'");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 170,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff303352),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].poster_path}"))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff303352),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Rate : ${snapshot.data[index].vote_average.toString()}/10",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FutureBuilder(
                future: api.getMovie(4),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "loading",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              int id = snapshot.data[index].id;
                              await api.getVideo(id);
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Reveiw(
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].title,
                                    image: snapshot.data[index].poster_path,
                                    keyy: Home.keyy,
                                    overview: snapshot.data[index].overview,
                                  );
                                },
                              ));
                              print("From Navvvvvvvvvv '${Home.keyy}'");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 170,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff303352),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].poster_path}"))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff303352),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Rate : ${snapshot.data[index].vote_average.toString()}/10",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FutureBuilder(
                future: api.getMovie(5),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "loading",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              int id = snapshot.data[index].id;
                              await api.getVideo(id);
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Reveiw(
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].title,
                                    image: snapshot.data[index].poster_path,
                                    keyy: Home.keyy,
                                    overview: snapshot.data[index].overview,
                                  );
                                },
                              ));
                              print("From Navvvvvvvvvv '${Home.keyy}'");
                            },
                            //
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 170,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff303352),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].poster_path}"))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff303352),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Rate : ${snapshot.data[index].vote_average.toString()}/10",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FutureBuilder(
                future: api.getMovie(6),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text(
                        "loading",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  } else {
                    return Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              int id = snapshot.data[index].id;
                              await api.getVideo(id);
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Reveiw(
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].title,
                                    image: snapshot.data[index].poster_path,
                                    keyy: Home.keyy,
                                    overview: snapshot.data[index].overview,
                                  );
                                },
                              ));
                              print("From Navvvvvvvvvv '${Home.keyy}'");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 170,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xff303352),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].poster_path}"))),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff303352),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15))),
                                        child: Center(
                                          child: Text(
                                            "Rate : ${snapshot.data[index].vote_average.toString()}/10",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
