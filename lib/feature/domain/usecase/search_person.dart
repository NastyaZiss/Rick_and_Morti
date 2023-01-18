import 'package:ca_api_morti/core/error/failure.dart';
import 'package:ca_api_morti/core/usecases/usecase.dart';
import 'package:ca_api_morti/feature/domain/entities/person_entity.dart';
import 'package:ca_api_morti/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
