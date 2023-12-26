import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signify_demo_app/core/network/network_info.dart';
import 'package:signify_demo_app/core/usecase/usecase.dart';
import 'package:signify_demo_app/core/utilities/strings.dart';
import 'package:signify_demo_app/home/domain/use_cases/random_quote_use_case.dart';
import 'package:signify_demo_app/home/presentation/bloc/random_quote_event.dart';
import 'package:signify_demo_app/home/presentation/bloc/random_quote_state.dart';

import '../../../core/utilities/common.dart';

class RandomQuoteBloc extends Bloc<RandomQuoteEvent, RandomQuoteState> {
  final GetRandomQuoteUseCase getRandomQuoteUseCase;
  final NetworkInfo networkInfo;


  //hardCoded Strings
  var listOfQuotes = ['Once a new technology rolls over you, if you’re not part of the steamroller, you’re part of the road. – Stewart Brand.',
    'Engineering is the closest thing to magic that exists in the world. – Elon Musk',
    'Our business is about technology, yes. But it’s also about operations and customer relationships. – Michael Dell',
    'The real danger is not that computers will begin to think like men, but that men will begin to think like computers. – Sydney Harris' ,
    'One machine can do the work of fifty ordinary men. No machine can do the work of one extraordinary man. – Elbert Hubbard' ,
    'For me, it matters that we drive technology as an equalizing force, as an enabler for everyone around the world. – Sundar Pichai' ,
    'The Web as I envisaged it, we have not seen it yet. The future is still so much bigger than the past. – Tim Berners-Lee'  ,
    'Our industry does not respect tradition – it only respects innovation.” – Satya Nadella',
    'The key to success for everything in business, science, and technology is to never follow the others. – Masaru Ibuka'];


  RandomQuoteBloc(this.getRandomQuoteUseCase, this.networkInfo)
      : super(RandomQuoteInitialState()) {
    on<RandomQuoteEvent>((event, emit) async {
      if (await networkInfo.isConnected) {
        emit(RandomQuoteLoadingState());
        final randomQuote = await getRandomQuoteUseCase.call(NoParams());

        randomQuote
            .fold((failure) => emit(RandomQuoteErrorState(failure.message, "")),
                (success) {
          emit(RandomQuoteLoadedState(success));
        });
      } else {
        var quotes = getRandomElement(listOfQuotes);
        print(quotes);

        emit(RandomQuoteErrorState(AppStrings.noInternetError , quotes));
      }
    });
  }
}
