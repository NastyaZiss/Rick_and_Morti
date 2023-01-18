import 'package:ca_api_morti/core/error/failure.dart';
import 'package:ca_api_morti/core/usecases/usecase.dart';
import 'package:ca_api_morti/feature/domain/entities/person_entity.dart';
import 'package:ca_api_morti/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class getAllPersons extends UseCase<List<PersonEntity, PagePersonParams>> {
  final PersonRepository personRepository;

  getAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}
// getPersonBy заменила на call,
// так как в дарте метод кул, можно будет не писать
// Object.call() or Object()

class PagePersonParams extends Equatable {
  final int page;

  PagePersonParams({required this.page});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
