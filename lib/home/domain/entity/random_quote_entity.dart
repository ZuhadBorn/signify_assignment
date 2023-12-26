import 'package:equatable/equatable.dart';

class RandomQuoteEntity extends Equatable {
  final String? sId;
  final String? content;

  const RandomQuoteEntity({
    this.sId,
    this.content,
  });

  @override
  List<Object?> get props => [sId, content];
}
