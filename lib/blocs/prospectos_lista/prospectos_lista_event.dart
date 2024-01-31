part of 'prospectos_lista_bloc.dart';

@immutable
abstract class ProspectosObtenerListaEvent{}

class NewProspectosObtenerLista extends ProspectosObtenerListaEvent{
  final ProspectosObtenerLista prospectosLista; 
  NewProspectosObtenerLista(this.prospectosLista);
}
