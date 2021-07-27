import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:graphql/client.dart';
import 'package:quotation/src/utils/graphql_client.dart';

Future<dynamic> getAllUserQuery() async {
  const String readRepositories = r'''
query Query {
  users(firstName: "palani") {
    firstName
    lastName
    id
    email
  }
}
''';
  QueryOptions options = QueryOptions(document: gql(readRepositories));
  GraphQLClient client = await getGQLClient();
  final QueryResult result = await client.query(options);
  return result.data;
}

Future<dynamic> loginUser(data) async {
  const String createMutation = r'''
   mutation($input: LoginUser!) {
     login(login: $input) {
        firstName,
    lastName
    email,
    mobile
     }
   }
  ''';

  final MutationOptions options = MutationOptions(
    document: gql(createMutation),
    variables: {"input": data},
  );
  final QueryResult result = await client.mutate(options);
  var res = await handleResponse(result);
  return res;
}
