
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:next_project/model/models.dart';
import 'package:next_project/providers/providers.dart';
import 'package:next_project/services/UrlServices.dart';
import 'package:provider/provider.dart';

class DocumentoEstadoProvider extends ChangeNotifier {

  Future<List<DocumentoEstado>> getListDocumentoEstado(BuildContext context,String doc,String bod,String fecIni,String fecFin,String esta ) async {
    try{
      if(doc!='' && bod!='' && fecIni!='' && fecFin!='' && esta!='' ){
        final organization = Provider.of<MultipleProviders>(context,listen: false);
        var server = organization.urlServer +
            UrlServices.urlConsultaDocumento +
            organization.idEmpresa+'/'+organization.codVdd+'/'+doc+'/'+bod+'/'+fecIni+'/'+fecFin+'/'+esta;
        final url = Uri.parse(server);
        final response = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer ' + organization.tocken});
        final resp = SearchDocumentoEstadoResponse.fromJson(response.body);
        return resp.results.toList();
      }else{
        return[];  
      }
    }catch(e){
      print(e.toString());
      return[];
    }
  }
}