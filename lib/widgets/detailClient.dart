import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:next_project/utils/constants.dart';
Widget detailClient(){
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
        child: SingleChildScrollView(
            child: DataTable(
              decoration: new BoxDecoration(
                  color: Color(Constants.colorGrey),
                ),
              headingRowColor: MaterialStateColor.resolveWith((states) => Color(Constants.colorBlue)),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Documento',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Emisión',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Vence',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Valor',
                style: TextStyle( color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Opción',
                style: TextStyle( color: Colors.white),
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Mohit')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Akshay')),
                DataCell(Text('25')),
                DataCell(Text('Software Developer')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Akshay')),
                DataCell(Text('25')),
                DataCell(Text('Software Developer')),
                DataCell(Text('23')),
                DataCell(Text('Associate Software Developer')),
              ],
            ),

          ],
        ))
        );
}