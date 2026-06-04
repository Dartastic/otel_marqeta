// Licensed under the Dartastic Pro Software License Agreement.
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';

import 'otel_marqeta_suppression.dart';

class MarqetaResult {
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

class MarqetaCallResult<T> {
  const MarqetaCallResult({required this.value, this.result});
  final T value;
  final MarqetaResult? result;
}

Future<T> tracedMarqeta<T>({
  required String operation,
  required Future<MarqetaCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (marqetaInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_marqeta');
  final span = t.startSpan('marqeta $operation', kind: SpanKind.client);
  try {
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.system', 'marqeta')]));
    span.addAttributes(
        OTel.attributes([OTel.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.environment != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.environment', res.environment!)]));
      }
      if (res.programShortCode != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'marqeta.program.short_code', res.programShortCode!)
        ]));
      }
      if (res.surface != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.surface', res.surface!)]));
      }
      if (res.cardProductToken != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'marqeta.card_product.token', res.cardProductToken!)
        ]));
      }
      if (res.cardToken != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.card.token', res.cardToken!)]));
      }
      if (res.cardState != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.card.state', res.cardState!)]));
      }
      if (res.cardFulfillmentState != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'marqeta.card.fulfillment_state', res.cardFulfillmentState!)
        ]));
      }
      if (res.cardLast4 != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.card.last4', res.cardLast4!)]));
      }
      if (res.userToken != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.user.token', res.userToken!)]));
      }
      if (res.kycResult != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.kyc.result', res.kycResult!)]));
      }
      if (res.kycReasonCode != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('marqeta.kyc.reason_code', res.kycReasonCode!)
        ]));
      }
      if (res.transactionToken != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'marqeta.transaction.token', res.transactionToken!)
        ]));
      }
      if (res.transactionType != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('marqeta.transaction.type', res.transactionType!)
        ]));
      }
      if (res.transactionState != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'marqeta.transaction.state', res.transactionState!)
        ]));
      }
      if (res.transactionResponseCode != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              'marqeta.transaction.response_code', res.transactionResponseCode!)
        ]));
      }
      if (res.networkCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.network.code', res.networkCode!)]));
      }
      if (res.amountMicros != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('marqeta.amount.micros', res.amountMicros!)]));
      }
      if (res.currencyCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.currency', res.currencyCode!)]));
      }
      if (res.mcc != null) {
        span.addAttributes(
            OTel.attributes([OTel.attributeString('marqeta.mcc', res.mcc!)]));
      }
      if (res.merchantCountry != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('marqeta.merchant.country', res.merchantCountry!)
        ]));
      }
      if (res.acquirerCountry != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('marqeta.acquirer.country', res.acquirerCountry!)
        ]));
      }
      if (res.gpaOrderState != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('marqeta.gpa_order.state', res.gpaOrderState!)
        ]));
      }
      if (res.disputeState != null) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString('marqeta.dispute.state', res.disputeState!)
        ]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeInt('http.response.status_code', res.statusCode!)]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTel.attributes(
            [OTel.attributeString('marqeta.error.code', res.errorCode!)]));
      }
      // Failed transactions are business outcomes for non-DECLINED states;
      // span error only on HTTP/API errors and KYC FAILURE.
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400) ||
          res.kycResult == 'FAILURE';
      if (fail) {
        span.addAttributes(OTel.attributes([
          OTel.attributeString(
              ErrorResource.errorType.key, res.errorCode ?? 'marqeta.error')
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
