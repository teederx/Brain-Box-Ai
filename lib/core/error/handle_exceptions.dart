import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

import '../data/model/custom_error/custom_error.dart';

CustomError handleException(e) {
  try {
    throw e;
  } on FirebaseAuthException catch (e) {
    throw CustomError(
      code: e.code,
      message: e.message ?? 'Invalid Credential',
      plugin: e.plugin,
    );
  } on FirebaseException catch (e) {
    throw CustomError(
      code: e.code,
      message: e.message ?? 'Firebase Error',
      plugin: e.plugin,
    );
  } on DioException catch (e) {
    throw CustomError(
      code: e.response?.statusCode?.toString() ?? 'DioException', //TODO: Change to model specific returns 
      message: e.message.toString(),
      plugin: 'Dio',
    );
  } catch (e) {
    throw CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'Unknown Error',
    );
  }
}