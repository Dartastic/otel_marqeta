// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_marqeta_suppression.dart';

class MarqetaResult {
  /// Creates a result.
  const MarqetaResult({
    this.environment,
    this.programShortCode,
    this.surface,
    this.cardProductToken,
    this.cardToken,
    this.cardState,
    this.cardFulfillmentState,
    this.cardLast4,
    this.userToken,
    this.kycResult,
    this.kycReasonCode,
    this.transactionToken,
    this.transactionType,
    this.transactionState,
    this.transactionResponseCode,
    this.networkCode,
    this.amountMicros,
    this.currencyCode,
    this.mcc,
    this.merchantCountry,
    this.acquirerCountry,
    this.gpaOrderState,
    this.disputeState,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? environment;
  final String? programShortCode;
  final String? surface;
  final String? cardProductToken;
  final String? cardToken;
  final String? cardState;
  final String? cardFulfillmentState;
  final String? cardLast4;
  final String? userToken;
  final String? kycResult;
  final String? kycReasonCode;
  final String? transactionToken;
  final String? transactionType;
  final String? transactionState;
  final String? transactionResponseCode;
  final String? networkCode;
  final int? amountMicros;
  final String? currencyCode;
  final String? mcc;
  final String? merchantCountry;
  final String? acquirerCountry;
  final String? gpaOrderState;
  final String? disputeState;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

/// What a traced call returned: the value for the caller plus fields
/// recorded on the span.
class MarqetaCallResult<T> {
  /// Creates a call result.
  const MarqetaCallResult({required this.value, this.result});

  /// The value returned to the caller.
  final T value;
  final MarqetaResult? result;
}

Future<T> tracedMarqeta<T>({
  required String operation,
  required Future<MarqetaCallResult<T>> Function() invoke,
  APITracer? tracer,
}) async {
  if (marqetaInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTelAPI.tracerProvider().getTracer('otel_marqeta');
  final span = t.startSpan('marqeta $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.system', 'marqeta')]));
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('marqeta.environment', res.environment!)
        ]));
      }
      if (res.programShortCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.program.short_code', res.programShortCode!)
        ]));
      }
      if (res.surface != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.surface', res.surface!)]));
      }
      if (res.cardProductToken != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.card_product.token', res.cardProductToken!)
        ]));
      }
      if (res.cardToken != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.card.token', res.cardToken!)]));
      }
      if (res.cardState != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.card.state', res.cardState!)]));
      }
      if (res.cardFulfillmentState != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.card.fulfillment_state', res.cardFulfillmentState!)
        ]));
      }
      if (res.cardLast4 != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.card.last4', res.cardLast4!)]));
      }
      if (res.userToken != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.user.token', res.userToken!)]));
      }
      if (res.kycResult != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.kyc.result', res.kycResult!)]));
      }
      if (res.kycReasonCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('marqeta.kyc.reason_code', res.kycReasonCode!)
        ]));
      }
      if (res.transactionToken != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.transaction.token', res.transactionToken!)
        ]));
      }
      if (res.transactionType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.transaction.type', res.transactionType!)
        ]));
      }
      if (res.transactionState != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.transaction.state', res.transactionState!)
        ]));
      }
      if (res.transactionResponseCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.transaction.response_code', res.transactionResponseCode!)
        ]));
      }
      if (res.networkCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('marqeta.network.code', res.networkCode!)
        ]));
      }
      if (res.amountMicros != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('marqeta.amount.micros', res.amountMicros!)
        ]));
      }
      if (res.currencyCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.currency', res.currencyCode!)]));
      }
      if (res.mcc != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.mcc', res.mcc!)]));
      }
      if (res.merchantCountry != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.merchant.country', res.merchantCountry!)
        ]));
      }
      if (res.acquirerCountry != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'marqeta.acquirer.country', res.acquirerCountry!)
        ]));
      }
      if (res.gpaOrderState != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('marqeta.gpa_order.state', res.gpaOrderState!)
        ]));
      }
      if (res.disputeState != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('marqeta.dispute.state', res.disputeState!)
        ]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('http.response.status_code', res.statusCode!)
        ]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('marqeta.error.code', res.errorCode!)]));
      }
      // Failed transactions are business outcomes for non-DECLINED states;
      // span error only on HTTP/API errors and KYC FAILURE.
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.kycResult == 'FAILURE';
      if (fail) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              ErrorAttributes.errorType.key, res.errorCode ?? 'marqeta.error')
        ]));
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
