part of 'prospecto_bloc.dart';

@immutable
abstract class ProspectoState{
  final bool isFromOcr;
  final Prospecto? prospecto;

  const ProspectoState({
    this.isFromOcr = false,
    this.prospecto 
    });
}

class ProspectoInitialState extends ProspectoState{
  const ProspectoInitialState(): super(isFromOcr: false, prospecto: null);
}

class ProspectoSetState extends ProspectoState{
  final Prospecto prospecto;

  const ProspectoSetState(this.prospecto): super(isFromOcr: false, prospecto: prospecto);
}
class ProspectoOcrSetState extends ProspectoState{
  final Prospecto prospectoOcr;

  const ProspectoOcrSetState(this.prospectoOcr): super(isFromOcr: true, prospecto: prospectoOcr);
}
