import 'package:signify_demo_app/home/domain/entity/random_quote_entity.dart';


abstract class RandomQuoteState {}

class RandomQuoteInitialState extends RandomQuoteState {}

class RandomQuoteLoadingState extends RandomQuoteState {}

class RandomQuoteLoadedState extends RandomQuoteState {
  final RandomQuoteEntity randomQuoteData;

  RandomQuoteLoadedState(this.randomQuoteData);
}

class RandomQuoteErrorState extends RandomQuoteState {
  final String error;
  final String quote;

  RandomQuoteErrorState(this.error , this.quote);
}
