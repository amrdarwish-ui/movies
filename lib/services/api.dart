import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:movies/Models/Movie.dart';
import 'package:movies/Pages/Home.dart';

class Api {
  Future<List<Movie>> getMovie(int pageNumber) async {
    String apikey = "f04342b213d1dcadca727ce7312d3baf";
    var url =
        "https://api.themoviedb.org/3/movie/popular?api_key=$apikey&language=en-US&page=$pageNumber";
    var response = await http.get(url);
    var responsebody = json.decode(response.body)["results"];
    List<Movie> list = [];
    for (var i in responsebody) {
      Movie movie = Movie(
          id: i["id"],
          vote_average: i["vote_average"],
          title: i["title"],
          overview: i["overview"],
          poster_path: i["poster_path"]);

      print(movie.id);
      list.add(movie);
    }
    return list;
  }

  Future<String> getVideo(int id) async {
    String apikey = "f04342b213d1dcadca727ce7312d3baf";
    var url =
        "https://api.themoviedb.org/3/movie/$id/videos?api_key=$apikey&language=en-US";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responsebody = json.decode(response.body)["results"][0];
      Home.keyy = responsebody["key"];
      print(Home.keyy);
      return Home.keyy;
    } else {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>no");
    }
  }
}
