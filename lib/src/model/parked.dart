import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Parked {
  int id;

  DateTime fechaIngreso;
  DateTime? fechaSalida;
  int valorTotal;
  TipoPago tipoPago;
  Estado estado;
  String patente;
  int estacionamientoId;
  int minutosEstacionado;

  Parked({
    required this.id,
    required this.fechaIngreso,
    required this.fechaSalida,
    required this.valorTotal,
    required this.tipoPago,
    required this.estado,
    required this.patente,
    required this.estacionamientoId,
    required this.minutosEstacionado,
  });

  factory Parked.fromJson(Map<String, dynamic> json) {
    return Parked(
      id: json['id'],
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
      fechaSalida: json['fechaSalida'] != null
          ? DateTime.parse(json['fechaSalida'])
          : null,
      valorTotal: json['valorTotal'],
      tipoPago: TipoPago.values[json['tipoPago']],
      estado: Estado.values[json['estado']],
      patente: json['patente'],
      estacionamientoId: json['estacionamientoId'],
      minutosEstacionado: json['minutosEstacionado'],
    );
  }

  // hacer un factory desde un listado de json
  static List<Parked> fromJsonList(List<dynamic> jsonList) {
    List<Parked> items = [];
    for (var item in jsonList) {
      items.add(Parked.fromJson(item));
    }
    return items;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fechaIngreso': fechaIngreso.toIso8601String(),
        'fechaSalida':
            fechaSalida != null ? fechaSalida!.toIso8601String() : null,
        'valorTotal': valorTotal,
        'tipoPago': tipoPago,
        'estado': estado,
        'patente': patente,
        'estacionamientoId': estacionamientoId,
        'minutosEstacionado': minutosEstacionado,
      };

  fechaIngresoFormatted() {
    return DateFormat('dd/MM/yyyy HH:mm')
        .format(fechaIngreso.subtract(const Duration(hours: 3)));
  }

  fechaSalidaFormatted() {
    return DateFormat('dd/MM/yyyy HH:mm')
        .format(fechaSalida!.subtract(const Duration(hours: 3)));
  }

  String getTipoPago() {
    switch (tipoPago) {
      case TipoPago.efectivo:
        return 'Efectivo';
      case TipoPago.credito:
        return 'Crédito';
      case TipoPago.debito:
        return 'Débito';
      default:
        return '...';
    }
  }

  Widget buildEstado() {
    switch (estado) {
      case Estado.pagado:
        return Text('Pagado',
            style: TextStyle(
              color: Colors.green[300],
            ));
      case Estado.estacionado:
        return Text('Estacionado', style: TextStyle(color: Colors.red[300]));
      case Estado.cancelado:
        return Text('Cancelado', style: TextStyle(color: Colors.orange[300]));
      default:
        return Text('...');
    }
  }
}

enum TipoPago { efectivo, debito, credito }

enum Estado { estacionado, pagado, cancelado }
