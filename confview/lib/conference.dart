import 'package:confview/panorama_view.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class Location{

  final String name;
  PanoramaViewImage image;
  List<Tag> tags;

  Location(this.name,this.image,this.tags);

  void addTag(Tag t){
    tags.add(t);
  }

  List<Tag> getTags(){
    return this.tags;
  }

  String getName(){
    return this.name;
  }

}

class PanoramaViewImage{
  String imageUrl;
  NetworkImage networkImage;
  double width;
  double height;
  bool loaded;
  PanoramaViewImage(this.imageUrl){
    this.networkImage = null;
    this.width = null;
    this.height = null;
    this.loaded = false;
  }

}

class Tag {
  final String text;
  final double x;
  final double y;
  Tag(this.text,this.x,this.y);

  Alignment getAlignment(){
    return Alignment(x,y);
  }
  String getText(){
    return text;
  }

}



class Router {


    Map<String,PanoramaView> views = new Map<String,PanoramaView>();

    PanoramaView previous;

    Router(List<Location> locations){
      generateRoutes(locations);
      previous = null;
    }

    void generateRoutes(List<Location> locations){
      for(Location loc in locations)
        this.views['/' + loc.getName()] = new PanoramaView(panoramaImage: loc.image,tags: loc.getTags());
    }

    Route<dynamic> getRoute(RouteSettings settings) {
      PanoramaView view;

      /*print(settings.name);
      this.views.forEach((key, value) {
        print('key: $key, value: $value');
      });*/


      view = this.views[settings.name];

      if(view == null){
        if(previous != null)
          return MaterialPageRoute(builder: (_) => previous);
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
      }else {
        previous = view;
        return MaterialPageRoute(builder: (_) => view);
      }

  }
}

class Conference extends StatefulWidget{

  Conference({Key key}) : super(key : key);

  List<Location> locations = new List<Location>();

  @override
  _ConferenceState createState() => _ConferenceState();

}

class _ConferenceState extends State<Conference> {

  Router router;

  @override
  initState() {
    super.initState();

    widget.locations.add(new Location("Praia",
        new PanoramaViewImage("https://upload.wikimedia.org/wikipedia/commons/3/3e/Croatia_Ribarica_beach_panorama_360.jpg"),
        [new Tag("India",-2,0),new Tag("Cidade",0.3,0.2),new Tag("Rua",3.5,0)]));

    widget.locations.add(new Location("India",
        new PanoramaViewImage("https://l13.alamy.com/360/PN0HYA/ganesh-pol-amber-palace-rajasthan-india-PN0HYA.jpg"),
          [new Tag("Praia",-2,0),new Tag("Cidade",0.3,0.2),new Tag("Rua",3.5,0)]));

    widget.locations.add(new Location("Rua",
        new PanoramaViewImage("https://saffi3d.files.wordpress.com/2011/08/commercial_area_cam_v004.jpg"),
        [new Tag("India",-2,0),new Tag("Cidade",0.3,0.2),new Tag("Praia",3.5,0)]));

    widget.locations.add(new Location("Cidade",
        new PanoramaViewImage("https://c1.staticflickr.com/5/4302/35137573294_1287bfd0ae_k.jpg"),
        [new Tag("India",-2,0),new Tag("Rua",0.3,0.2),new Tag("Cidade2",3.5,0)]));

    widget.locations.add(new Location("Cidade2",
        new PanoramaViewImage("https://d36tnp772eyphs.cloudfront.net/blogs/1/2006/11/360-panorama-matador-seo.jpg"),
        [new Tag("Cidade",-2,0)]));


    router = new Router(widget.locations);

  }


  @override
  Widget build(BuildContext context) {

    //return PanoramaView(tags: [new Tag("Rotunda",-2,0),new Tag("Carro Cinzento",0.3,0.2),new Tag("Fim de rua",3.5,0)]);
    return MaterialApp(
      onGenerateRoute: router.getRoute,
      initialRoute: '/Rua',
    );

  }

}