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