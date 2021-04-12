import 'views/load.dart';
import 'views/overview.dart';
import 'views/game.dart';
import 'views/detail.dart';

var appRoutes = {
  '/': (context) => LoadScreen(),
  '/overview': (context) => OverviewScreen(),
  '/game': (context) => GameScreen(),
  '/detail': (context) => DetailScreen(),
};
