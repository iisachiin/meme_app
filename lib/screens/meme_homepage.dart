import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/models/meme_modal.dart';
import 'package:meme_app/widget/meme_card.dart';
import 'package:meme_app/services/meme_services.dart';

class MemeHomepage extends StatefulWidget {
  const MemeHomepage({super.key});

  @override
  State<MemeHomepage> createState() => _MemeHomepageState();
}

class _MemeHomepageState extends State<MemeHomepage> {
  List<Meme> memes = [];
  bool isLoading = true;
  Color backgroundColor = Colors.deepPurple;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
  fetchmemes();
  }


Future<void> fetchmemes() async {
  final fetchmemes = await MemeServices.fetchmemes(context);
setState(() {
  memes = fetchmemes ?? [];
  isLoading = false;
});
}



void updateBackgroundColor (Color color) {
  setState(() {
    backgroundColor = color;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meme App"),
        centerTitle: true,
        backgroundColor: backgroundColor.withOpacity(0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ 
              backgroundColor.withOpacity(0.8),
              backgroundColor.withOpacity(0.4),
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : memes.isEmpty
            ? Center(child: Text('No memes Available'))
            : ListView.builder(
                itemCount: memes.length,
                itemBuilder: (context, index) {
                  final meme = memes[index];
                  return MemeCard(title: meme.title, imageUrl: meme.url, ups: meme.ups, postLink: meme.postLink, onColorExtracted: updateBackgroundColor);
                },
              ),
      ),
    );
  }
}
