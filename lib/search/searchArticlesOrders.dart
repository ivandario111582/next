import 'package:flutter/material.dart';
import 'package:next_project/model/models.dart';
import 'package:next_project/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:next_project/providers/providers.dart';

class ArticlesOrdersSearchDelegate extends SearchDelegate{
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
        final articuloPedidoProvider = Provider.of<ArticlesOrdersProvider>(context, listen: false);
        articuloPedidoProvider.getSuggestionsByQuery( query,context );

          return StreamBuilder(
        stream: articuloPedidoProvider.suggestionStream,
        builder: ( _, AsyncSnapshot<List<ArticuloPedido>> snapshot) {
          
          if( !snapshot.hasData ) return _emptyContainer();

          final articulosPedidos = snapshot.data!;

          return ListView.builder(
            itemCount: articulosPedidos.length,
            itemBuilder: (contex, int index ) {
            final articuloPedido=articulosPedidos[index];
            final codigo=articuloPedido.codigo;
            //final saldo=articuloPedido.saldo;
            final precio=articuloPedido.precio;
           // final editar=articuloPedido.precEdit;
            final disponible=articuloPedido.disponible;
              return ListTile(
                title: Text( articuloPedido.descripcion ?? '' ),
                subtitle: Text( 'Código: $codigo Saldo: $disponible Precio: $precio '),
                onTap: () {
                  this.close(context, articuloPedido);
                },
              );
            }
          );
        },
      );
  }

}
