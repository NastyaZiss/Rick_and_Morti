import 'dart:convert';

import 'package:ca_api_morti/core/error/exceptoin.dart';
import 'package:ca_api_morti/feature/data/datasourse/models/person_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource{
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?page=1')

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl('https://rickandmortyapi.com/api/character/?name=$query')

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'});
    if(response.statusCode==200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List).map((person)=> PersonModel.fromJson(person)).toList();
    } else {
      throw ServerException();
    }
  }
}