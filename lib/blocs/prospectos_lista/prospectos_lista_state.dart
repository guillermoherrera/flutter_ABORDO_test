part of 'prospectos_lista_bloc.dart';

@immutable
abstract class ProspectosObtenerListaState{
  final ProspectosObtenerLista? prospectosLista;

  const ProspectosObtenerListaState({
    this.prospectosLista 
    });
}

class ProspectosObtenerListaInitialState extends ProspectosObtenerListaState{
  const ProspectosObtenerListaInitialState(): super(prospectosLista: null);
}

class ProspectosObtenerListaSetState extends ProspectosObtenerListaState{
  final ProspectosObtenerLista prospectosListaNew;
  const ProspectosObtenerListaSetState(this.prospectosListaNew): super(prospectosLista: prospectosListaNew);
}
