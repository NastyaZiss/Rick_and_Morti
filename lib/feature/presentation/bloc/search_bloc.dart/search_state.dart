import 'package:ca_api_morti/feature/domain/entities/person_entity.dart';
import 'package:ca_api_morti/feature/domain/usecase/search_person.dart';
import 'package:equatable/equatable.dart';

abstract  class PersonSearchState extends Equatable{
  const PersonSearchState();

  @override
  List<Object> get props => [];
}

class PersonEmpty extends PersonSearchState{}

class PersonSearchLoading extends PersonSearchState{}

class PersonSearchLoaded extends PersonSearchState{
  final List<PersonEntity> persons;

  PersonSearchLoaded(this.persons);

  @override
  List<Object> get props => [persons];
}

class PersonSearchError extends PersonSearchState{
  final Stream messege;

  PersonSearchError({required this.messege});

   @override
  List<Object> get props => [messege];
}