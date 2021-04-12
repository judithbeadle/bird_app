import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../classes/bird.dart';
import '../library/globals.dart' as globals;

newGame() {
  print('new Game');
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Bird> uniqueBirds = globals.birdList;

  // state var, which bird(s) is/are currently selected?
  // this will be used to compare slugs
  List _selectedCards = [];
  List _matchedCards = [];
  List _cardsToReturn = []; // list of indexes
  String _message = 'Finde die Vogelpaare';

  // pass this to child widget
  checkDeck(card) {
    setState(() {
      _selectedCards.add(card);
    });
  }

  resetReturned() {
    // reset list of index of cards to return
    // this method is passed down to tile widget
    setState(() {
      _cardsToReturn = [];
    });
  }

  addMatched() {
    // add cards to matched cards
    _selectedCards.forEach((card) {
      _matchedCards.add(card);
      _message = 'Paar gefunden: ${_selectedCards[0].bird.title}';
    });
    // remove cards from current selection
    _selectedCards = [];
  }

  returnCards() {
    List _tempCardsToReturn = [];
    // list of indexes of non-matching cards to be turned back
    _selectedCards.forEach((card) {
      _tempCardsToReturn.add(card.index);
    });
    setState(() {
      _selectedCards = [];
      _message = 'Versuch\'s nochmal, \nDiese Vögel sind kein Paar.';
      _cardsToReturn = _tempCardsToReturn;
    });
  }

  compareCards() {
    // compare the slugs of the two turned over cards
    _selectedCards[0].bird.slug == _selectedCards[1].bird.slug
        ? addMatched()
        : returnCards();
  }

  @override
  Widget build(BuildContext context) {
    List<Bird> doubleUp(List<Bird> list) {
      List<Bird> doubleList = [];
      list.forEach((bird) {
        var newBirds = List.filled(2, bird);
        newBirds[0].setSex('m');
        newBirds[1].setSex('f');
        newBirds.forEach((newBird) {
          doubleList.add(newBird);
        });
      });
      return doubleList;
    }

    List birdCards = doubleUp(uniqueBirds);

    if (_selectedCards.length == 2) {
      compareCards();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Vogel Memory'),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: birdCards.length,
                      itemBuilder: (context, index) {
                        return Tile(
                          index: index,
                          bird: birdCards[index],
                          updateDeck: checkDeck,
                          emptyCardsToReturn: resetReturned,
                          // check if card is in array of non matching cards
                          // and pass to bool of card for turning back
                          needsReturning: _cardsToReturn.contains(index),
                        );
                      }))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(_message),
          ),
        ],
      )),
    );
  }
}

class Tile extends StatefulWidget {
  final int index;
  final Bird bird;
  final updateDeck;
  final turnBack;
  final emptyCardsToReturn;
  bool needsReturning;

  // states in here, isVisible...
  Tile({
    @required this.index,
    @required this.bird,
    this.needsReturning,
    this.updateDeck,
    this.emptyCardsToReturn,
    this.turnBack,
    Key key,
  }) : super(key: key);
  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  // to use from Tile: widget.index, widget.card etc
  // "widget." = "this." for widgets
  bool _active = true;

  void changeVisibility() {
    setState(() {
      _active = !_active;
    });
    if (cardKey.currentState.isFront == true) {
      widget.updateDeck(widget);
    }
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    String activeString = _active ? 'Active' : 'Inactive';
    if (widget.needsReturning == true) {
      // delay the automatic flip back to allow user to remember
      Future.delayed(const Duration(seconds: 2), () {
        if (cardKey.currentState.isFront == false) {
          widget.emptyCardsToReturn();
          cardKey.currentState.toggleCard();
        }
      });
    }

    return FlipCard(
      key: cardKey,
      flipOnTouch: _active,
      onFlip: changeVisibility, // state change here

      front: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          image: DecorationImage(
            image: AssetImage('../assets/images/card-back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      back: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          image: DecorationImage(
            image: AssetImage('../assets/images/${widget.bird.slug}-large.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.topRight,
          child: IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              tooltip: 'mehr Erfahren',
              onPressed: () {
                Navigator.pushNamed(context, '/detail', arguments: widget.bird);
              }),
        ),
      ),
    );
  }
}
