import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'link_list.dart';

const String CREATE_LINK_MUTATION = '''
  mutation PostMutation(
    \$url: String!
    \$name: String!
    \$status: String!
  ) {
    createLink(url: \$url, name: \$name, status: \$status) {
      id
      url
      name
      status
    }
  }
''';

class CreateLinkScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final urlController = useTextEditingController();
    final nameController = useTextEditingController();
    final statusController = useTextEditingController();

    final createLinkMutation = useMutation(
      MutationOptions(
        document: gql(CREATE_LINK_MUTATION),
        onCompleted: (_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LinkListScreen()),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Link'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'The URL for the link'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createLinkMutation.runMutation({
                  'url': urlController.text,
                  'name': nameController.text,
                  'status': statusController.text,
                });
              },
              child: Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
