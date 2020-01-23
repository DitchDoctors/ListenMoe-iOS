class SongInfo {
  int op;
  D d;
  String t;

  SongInfo({this.op, this.d, this.t});

  factory SongInfo.fromJson(Map<String, dynamic> parsedJson) {
    return SongInfo(
        op: parsedJson['op'],
        d: D.fromJson(parsedJson['d']),
        t: parsedJson['t']);
  }
}


class D {
  SongArtist artist;
  Song song;
  dynamic requester;
  dynamic event;
  String startTime;
  List<LastPlayed> lastPlayed;
  

  int listeners;
  D(
      {this.song,
      this.requester,
      this.event,
      this.startTime,
      this.lastPlayed,
      this.listeners,
      this.artist});
  factory D.fromJson(Map<String, dynamic> parsedJson) {
    return D(
        song: Song.fromJson(parsedJson['song']),
        artist: SongArtist.fromJson(parsedJson['song']),
        startTime: (parsedJson['startTime']),
        /*requester : parsedJson['requester'],
        event : parsedJson ['event'],
        startTime: parsedJson['startTime'],
        lastPlayed : parsedJson[LastPlayed.fromJson(parsedJson['lastPlayed'])],
        listeners : parsedJson ['listeners']
        */
        );
  }
}

class LastPlayed {
  int id;
  String title;
  List<dynamic> sources;
  List<LastPlayedArtist> artists;
  List<Album> albums;
  int duration;

  LastPlayed({
    this.id,
    this.title,
    this.sources,
    this.artists,
    this.albums,
    this.duration,
  });

  factory LastPlayed.fromJson(Map<String, dynamic> parsedJson) {
    return LastPlayed(
        id: parsedJson['id'],
        title: parsedJson['title'],
        sources: parsedJson['sources'],
        artists: parsedJson['artists'],
        albums: parsedJson['albums'],
        duration: parsedJson['duration']);
  }
}

class Album {
  int id;
  String name;
  dynamic nameRomaji;
  String image;

  Album({
    this.id,
    this.name,
    this.nameRomaji,
    this.image,
  });

  factory Album.fromJson(Map<String, dynamic> parsedJson) {
    return Album(
        id: parsedJson['id'],
        name: parsedJson['name'],
        nameRomaji: parsedJson['nameRomaji'],
        image: parsedJson['image']);
  }
}

class LastPlayedArtist {
  int id;
  String name;
  String nameRomaji;
  String image;

  LastPlayedArtist({
    this.id,
    this.name,
    this.nameRomaji,
    this.image,
  });
}

class Song {
  int id;
  String title;
  List<dynamic> sources;
  List<SongArtist> artists;
  List<Album> albums;
  int duration;

  Song({
    this.id,
    this.title,
    this.sources,
    this.artists,
    this.albums,
    this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        //  id: parsedJson['id'],
        title: parsedJson['title'],
        //   sources : parsedJson ['sources'],
        artists: List<SongArtist>.from(
            parsedJson['artists'].map((x) => SongArtist.fromJson(x))),
        //   albums : parsedJson[Album.fromJson(parsedJson['albums'])],
          duration : parsedJson ['duration']
        );
  }
}

class SongArtist {
  int id;
  String name;
  String nameRomaji;
  String image;

  SongArtist({
    this.id,
    this.name,
    this.nameRomaji,
    this.image,
  });
  factory SongArtist.fromJson(Map<String, dynamic> parsedJson) {
    return SongArtist(
        //   id: parsedJson['id'],
        name: parsedJson['name']);
    //    nameRomaji: parsedJson['nameRomaji'],
    //    image: parsedJson['image']);
  }
}
