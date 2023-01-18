import 'package:ca_api_morti/feature/domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ca_api_morti/core/error/failure.dart';

//Cоздание методов для доступа к страницам по номерам, и для поиска страниц по номерам

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
//query это параметр имя
