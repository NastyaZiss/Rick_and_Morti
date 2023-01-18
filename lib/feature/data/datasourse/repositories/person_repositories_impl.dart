import 'package:ca_api_morti/core/error/exceptoin.dart';
import 'package:ca_api_morti/core/platform/network_info.dart';
import 'package:ca_api_morti/feature/data/datasourse/person_local_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:ca_api_morti/feature/domain/entities/person_entity.dart';
import 'package:ca_api_morti/core/error/failure.dart';
import '../../../domain/repositories/person_repository.dart';
import '../models/person_model.dart';
import '../person_remote_data_source.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSorce;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSorce,
      required this.localDataSource,
      required this.networkInfo});
  
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async{
    return await _getPersons(() {
      return remoteDataSorce.getAllPersons(page);
    });
  }
  
  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSorce.searchPerson(query);
    });
  }

    Future<Either<Failure, List<PersonModel>>>_getPersons(Future<List<PersonModel>> Function() getPersons) async{
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    }else{
      try{
          final LocationPerson = await localDataSource.getLastPersonsFromCache();
          return Right(LocationPerson);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }



   // @override
  // Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remotePerson = await remoteDataSorce.getAllPersons(page);
  //       localDataSource.personsToCache(remotePerson);
  //       return Right(remotePerson);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   }else{
  //     try{
  //         final LocationPerson = await localDataSource.getLastPersonsFromCache();
  //         return Right(LocationPerson);
  //     } on CacheException{
  //       return Left(CacheFailure());
  //     }
  //   }
  // }

  // @override
  // Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remotePerson = await remoteDataSorce.searchPerson(query);
  //       localDataSource.personsToCache(remotePerson);
  //       return Right(remotePerson);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   }else{
  //     try{
  //         final LocationPerson = await localDataSource.getLastPersonsFromCache();
  //         return Right(LocationPerson);
  //     } on CacheException{
  //       return Left(CacheFailure());
  //     }
  //   }
  // }