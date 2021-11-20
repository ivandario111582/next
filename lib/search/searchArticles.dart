import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:next_project/providers/providers.dart';

class ArticlesSearchDelegate extends SearchDelegate{
  @override 
String get searchFieldLabel=>'Buscar Articulos';

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
        final articuloProvider = Provider.of<ArticlesProvider>(context, listen: false);
        articuloProvider.getSuggestionsByQuery( query,context );

          return StreamBuilder(
        stream: articuloProvider.suggestionStream,
        builder: ( _, AsyncSnapshot<List<Articulo>> snapshot) {
          
          if( !snapshot.hasData ) return _emptyContainer();

          final articulos = snapshot.data!;

          return ListView.builder(
            itemCount: articulos.length,
            itemBuilder: (contex, int index ) {
            final articulo=articulos[index];
            final codigo=articulo.codigo;
            final saldo=articulo.total;
              return ListTile(
                title: Text( articulo.descripcion ?? '' ),
                subtitle: Text( 'Código: $codigo   Saldo: $saldo' ),
                onTap: () {
                  this.close(context, articulo);
                },
              );
            }
          );
        },
      );
  }

}
