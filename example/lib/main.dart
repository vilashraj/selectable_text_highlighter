
import 'package:flutter/material.dart';
import 'package:selectable_text_highlighter/selectable_text_highlighter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen1(),
    );
  }
}
class Screen1 extends StatefulWidget {

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List<HighlightedOffset> offsets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Highlight Selection Demo'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: offsets.isEmpty ? 
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note, size: 60,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No Text Highlighted', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              )
              :ListView.separated(
                itemBuilder: (context, position){
                  return Dismissible(
                    key: Key(offsets[position].start.toString()),
                    onDismissed: (direction){
                      setState(() {
                        offsets.removeAt(position);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: Text(offsets[position].highlightedText));
                }, 
                separatorBuilder: (context, position){
                  return Divider(color: Colors.black87,);
                }, itemCount: offsets.length)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Center(child: Icon(Icons.arrow_forward_ios),),onPressed: ()async{
        offsets = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(offsets: offsets)));
        setState(() {
          
        });
      },),
    );
  }
}
class MyHomePage extends StatefulWidget {
  
  final List<HighlightedOffset>? offsets;

  MyHomePage({Key? key, this.offsets}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String paragraph = '''     
  
  Miusov, as a man man of breeding and deilcacy, could not but feel some inwrd qualms, when he reached the Father Superior's with Ivan: he felt ashamed of havin lost his temper. He felt that he ought to have disdaimed that despicable wretch, Fyodor Pavlovitch, too much to have been upset by him in Father Zossima's cell, and so to have forgotten himself. "Teh monks were not to blame, in any case," he reflceted, on the steps. "And if they're decent people here (and the Father Superior, I understand, is a nobleman) why not be friendly and courteous withthem? I won't argue, I'll fall in with everything, I'll win them by politness, and show them that I've nothing to do with that Aesop, thta buffoon, that Pierrot, and have merely been takken in over this affair, just as they have."

              He determined to drop his litigation with the monastry, and relinguish his claims to the wood-cuting and fishery rihgts at once. He was the more ready to do this becuase the rights had becom much less valuable, and he had indeed the vaguest idea where the wood and river in quedtion were.

              These excellant intentions were strengthed when he enterd the Father Superior's diniing-room, though, stricttly speakin, it was not a dining-room, for the Father Superior had only two rooms alltogether; they were, however, much larger and more comfortable than Father Zossima's. But tehre was was no great luxury about the furnishng of these rooms eithar. The furniture was of mohogany, covered with leather, in the old-fashionned style of 1820 the floor was not even stained, but evreything was shining with cleanlyness, and there were many chioce flowers in the windows; the most sumptuous thing in the room at the moment was, of course, the beatifuly decorated table. The cloth was clean, the service shone; there were three kinds of well-baked bread, two bottles of wine, two of excellent mead, and a large glass jug of kvas -- both the latter made in the monastery, and famous in the neigborhood. There was no vodka. Rakitin related afterwards that there were five dishes: fish-suop made of sterlets, served with little fish paties; then boiled fish served in a spesial way; then salmon cutlets, ice pudding and compote, and finally, blanc-mange. 
            ''';
            
  int tempBaseOffset = 0;
  int tempExtentOffset = 0;
  List<HighlightedOffset> offsets = [];
  
  @override
  void initState() {
    offsets = widget.offsets ?? [];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop(offsets);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('CHAPTER 1'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SelectableHighlighterText(
                text: paragraph,
                preHighlightedTexts: widget.offsets ?? [],
                onHighlightedCallback: (list){
                  setState(() {
                    offsets = list;
                  });
                },
              )
            ),          
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
