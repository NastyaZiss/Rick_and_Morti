import 'package:ca_api_morti/core/error/failure.dart';
import 'package:ca_api_morti/core/failure.dart'as Failure;
import 'package:ca_api_morti/core/failure.dart';
import 'package:ca_api_morti/feature/domain/usecase/search_person.dart';
import 'package:ca_api_morti/feature/presentation/bloc/search_bloc.dart/search_events.dart';
import 'package:ca_api_morti/feature/presentation/bloc/search_bloc.dart/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/failure.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPersons;
  PersonSearchBloc({required this.searchPersons}) : super(PersonEmpty());

  @override
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event)
  async*{
    if(event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    
    }
  }
  
  Stream<PersonSearchState?> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson = await SearchPerson.search(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold((failure) => PersonSearchError(messege: _mapFailureToMessege(failure)),
    (person) => PersonSearchLoaded(persons: person));
  }
}


String _mapFailureToMessege(Failure failure) {
  switch (failure.runtimeType){
    case ServerFailure:
    return 'Server Failure';
    case CacheFailure:
    return 'CacheFailure';
    default:
    return 'Unexpected error';
  }
}