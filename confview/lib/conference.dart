import 'package:confview/panorama_view.dart';
import 'package:flutter/material.dart';

class Location{

  final String name;
  List<Tag> tags;

  Location(this.name,this.tags);

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

    Router(List<Location> locations){
      generateRoutes(locations);
    }

    void generateRoutes(List<Location> locations){
      for(Location loc in locations)
        this.views['/' + loc.getName()] = new PanoramaView(tags: loc.getTags());
    }

    Route<dynamic> getRoute(RouteSettings settings) {

      PanoramaView view;

      view = this.views[settings.name];

      if(view == null){
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
      }else
        return  MaterialPageRoute(builder: (_) => view);


      switch (settings.name) {
        case '/Rua':
          return MaterialPageRoute(builder: (_) => PanoramaView(tags:[new Tag("Rotunda",-2,0),new Tag("Carro Cinzento",0.3,0.2),new Tag("Fim de rua",3.5,0)]));
        case '/Rotunda':
          return MaterialPageRoute(builder: (_) => PanoramaView(tags:[new Tag("Rua",-2,0),new Tag("Carro Cinzento",0.3,0.2),new Tag("Fim de rua",3.5,0)]));
        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
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

    widget.locations.add(new Location("Rua", [new Tag("Rotunda",-2,0),new Tag("Carro Cinzento",0.3,0.2),new Tag("Fim de rua",3.5,0)]));
    widget.locations.add(new Location("Rotunda", [new Tag("Rua",-2,0),new Tag("Carro Cinzento",0.3,0.2),new Tag("Fim de rua",3.5,0)]));


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