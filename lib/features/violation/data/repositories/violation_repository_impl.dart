import 'package:slts_enforcer_app/core/api/app_api.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import 'package:slts_enforcer_app/core/utils/connectivity_helper.dart';
import 'package:slts_enforcer_app/core/utils/retry.dart';
import 'package:slts_enforcer_app/features/violation/data/models/create_violation_request.dart';
import 'package:slts_enforcer_app/features/violation/data/models/list_item_model.dart';
import 'package:slts_enforcer_app/features/violation/data/models/run_plate_request.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';
import 'package:slts_enforcer_app/features/violation/presentation/providers/violation_form_state.dart';
// import 'package:slts_enforcer_app/core/errors/failures.dart';
import '../../domain/repositories/violation_repository.dart';

class ViolationRepositoryImpl implements ViolationRepository {
  final AppApi _api;
  ViolationRepositoryImpl(this._api);

  @override
  Future<void> createViolation(CreateViolationRequest req) async {
    // 1) ensure we have connectivity
    await ensureConnected();

    // 3) retry the whole call on transient errors
    await retry<void>(() async {
      final resp = await _api.createViolation(req);
      if (resp.message.toLowerCase() != 'success') {
        throw UnexpectedFailure(
          rawMessage: 'Create violation failed: ${resp.message}',
        );
      }
    });
  }

  @override
  Future<List<Violation>> runPlateNumber(String plate) async {
    await ensureConnected();
    final request = RunPlateRequest(search: plate);

    return await retry<List<Violation>>(() async {
      final response = await _api.runPlateNumber(request);
      if (response.message.toLowerCase() != 'success') {
        throw UnexpectedFailure(rawMessage: response.message);
      }

      if (response.data.isEmpty) {
        throw UnexpectedFailure(rawMessage: 'No violations found');
      }

      return response.data.map((m) => m.toEntity()).toList();
    }, attempts: 2);
  }

  List<DropdownOption> _toOptions(
    List<ListItemModel> data, {
    required int Function(ListItemModel) id,
    required String Function(ListItemModel) name,
  }) {
    return data.map((m) => DropdownOption(id(m), name(m))).toList();
  }

  @override
  Future<List<DropdownOption>> fetchVehicleBrandList() async {
    await ensureConnected();
    final resp = await _api.getVehicleBrandList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.vehicleBrandId!,
      name: (m) => m.vehicleBrandName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchVehicleColorList() async {
    await ensureConnected();
    final resp = await _api.getVehicleColorList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.vehicleColorId!,
      name: (m) => m.vehicleColorName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchVehicleTypeList() async {
    await ensureConnected();
    final resp = await _api.getVehicleTypeList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.vehicleTypeId!,
      name: (m) => m.vehicleTypeName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchPlateTypeList() async {
    await ensureConnected();
    final resp = await _api.getPlateTypeList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.plateTypeId!,
      name: (m) => m.plateTypeName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchPlateColorList() async {
    await ensureConnected();
    final resp = await _api.getPlateColorList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.plateColorId!,
      name: (m) => m.plateColorName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchOffenceList() async {
    await ensureConnected();
    final resp = await _api.getOffenceList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.offenceId!,
      name: (m) => m.offenceName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchEventTypeList() async {
    await ensureConnected();
    final resp = await _api.getEventTypeList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.eventTypeId!,
      name: (m) => m.eventTypeName!,
    );
  }

  @override
  Future<List<DropdownOption>> fetchZoneList() async {
    await ensureConnected();
    final resp = await _api.getZoneList();
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(models, id: (m) => m.zoneId!, name: (m) => m.zoneName!);
  }

  @override
  Future<List<DropdownOption>> fetchCommandListForZone(int zoneId) async {
    await ensureConnected();
    final resp = await _api.getCommandList(zoneId);
    if (resp.message.toLowerCase() != 'success') {
      throw UnexpectedFailure(rawMessage: resp.message);
    }

    final raw = resp.data as List<dynamic>;
    final models = raw
        .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _toOptions(
      models,
      id: (m) => m.commandId!,
      name: (m) => m.commandName!,
    );
  }
}
