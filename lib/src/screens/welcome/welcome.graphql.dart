import 'package:graphql/client.dart';
import '../../utils/graphql_client.dart';

Future<dynamic> getAllUserQuery() async {
  const String readRepositories = r'''
query Query {users(firstName:"palani"){firstName, lastName, id, email}}
''';
  QueryOptions options = QueryOptions(document: gql(readRepositories));
  final QueryResult result = await client.query(options);
  return result;
}
