part of 'prospecto_bloc.dart';

@immutable
abstract class ProspectoEvent{}

class NewProspecto extends ProspectoEvent{
  final Prospecto prospecto; 
  NewProspecto(this.prospecto);
}

class NewProspectoOcr extends ProspectoEvent{
  final Prospecto prospecto;
  NewProspectoOcr(this.prospecto);
}

class ChangeProspectoSexo extends ProspectoEvent{
  final String sexo;
  ChangeProspectoSexo(this.sexo);
}

class ChangeProspectofolioRegistro extends ProspectoEvent{
  final int folio;
  ChangeProspectofolioRegistro(this.folio);
}

class ChangeProspectoIdCliente extends ProspectoEvent{
  final String idCliente;
  ChangeProspectoIdCliente(this.idCliente);
}