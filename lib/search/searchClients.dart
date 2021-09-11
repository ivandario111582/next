import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:next_project/providers/providers.dart';

class ClientSearchDelegate extends SearchDelegate{
  @override 
String get searchFieldLabel=>'Buscar Cliente';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query='';
        },
        icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.arrow_back_ios ),
      onPressed: () => this.close(context, null )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

    Widget _emptyContainer() {
      return Container(
        
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image:DecorationImage(
              image: AssetImage(Constants.backGrountImage),fit:BoxFit.cover),
        )
        );
    }
  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return _emptyContainer();
    }
        final moviesProvider = Provider.of<ClientsProvider>(context, listen: false);
        moviesProvider.getSuggestionsByQuery( query );

          return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: ( _, AsyncSnapshot<List<Cliente>> snapshot) {
          
          if( !snapshot.hasData ) return _emptyContainer();

          final clientes = snapshot.data!;

          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (contex, int index ) {
            final cliente=clientes[index];             
                    return ListTile(
                title: Text( cliente.nombre ?? '' ),
                subtitle: Text( cliente.ruc ?? '' ),
                onTap: () {
                  this.close(context, cliente);
                  //Navigator.pushNamed(context, 'clientForm', arguments: cliente );
                },
              );
            }//=> _ClienteItem( clientes[index])
          );
        },
      );
  }

}
