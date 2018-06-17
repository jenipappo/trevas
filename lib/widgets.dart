import 'package:flutter/material.dart';

class MyImagePerson extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Container(
      width: 48.0,
      height: 48.0,

      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage('https://firebasestorage.googleapis.com/v0/b/trevas-71c90.appspot.com/o/Joseph.png?alt=media&token=c627a296-327a-4955-8b26-1ad48c328d1c'),

        ),
        borderRadius: new BorderRadius.all(new Radius.circular(56.0)),
        border: new Border.all(

        width: 2.0,
        ),
      ),

      /*
      decoration: new BoxDecoration(

        image: new DecorationImage(
          image: new ExactAssetImage('assets/joseph.png'), //new Image.network('https://firebasestorage.googleapis.com/v0/b/trevas-71c90.appspot.com/o/Joseph.png?alt=media&token=c627a296-327a-4955-8b26-1ad48c328d1c')
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(56.0)),
        border: new Border.all(

          width: 2.0,
        ),
      ), */
    );

      //Container(
        //       child: image);
  }
}


class MyAppBarText extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var XP = 400;
    var level = 3;
    return Container(
      child: new Row(
        children: [
      new Expanded(
      child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            child: new Text(
              'Auron Redcliff',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Text(
            'XP = $XP Level: $level',
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    )
    ])
    );
  }
}


/*
class LeadingWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(
        child: new Row(
            children: [
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      child: new IconButton(
                        icon: new Icon(Icons.arrow_left),
                        tooltip: 'Air it',

                      ),
                    ),
                    new MyImagePerson(),
                  ],
                ),
              )
            ])
    );
  }
}

*/