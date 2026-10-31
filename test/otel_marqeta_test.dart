// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry/testing.dart';
import 'package:otel_marqeta/otel_marqeta.dart';
import 'package:test/test.dart';

void main() {
  late TestHarness harness;
  late InMemorySpanExporter spans;

  setUpAll(() async {
    harness = await maybeInitializeOtelForTest(
      serviceName: 'otel_marqeta-test',
    );
    spans = harness.spans;
  });

  setUp(() => harness.clear());

  Map<String, Object> attrsOf(Span s) =>
      {for (final a in s.attributes.toList()) a.key: a.value};

  test('card.create records product + state', () async {
    await tracedMarqeta<String>(
      operation: 'cards.create',
      invoke: () async => const MarqetaCallResult(
        value: 'ok',
        result: MarqetaResult(
          cardProductToken: 'cp_default',
          cardToken: 'card_1',
          cardState: 'ACTIVE',
          cardFulfillmentState: 'ISSUED',
          cardLast4: '4242',
        ),
      ),
    );
    final a = attrsOf(spans.findSpanByName('marqeta cards.create')!);
    expect(a['marqeta.card.state'], 'ACTIVE');
    expect(a['marqeta.card.fulfillment_state'], 'ISSUED');
  });

  test('transaction DECLINED does not set span error', () async {
    await tracedMarqeta<String>(
      operation: 'transactions.simulate',
      invoke: () async => const MarqetaCallResult(
        value: 'ok',
        result: MarqetaResult(
          transactionType: 'authorization',
          transactionState: 'DECLINED',
          transactionResponseCode: '1016',
          amountMicros: 25000000,
          currencyCode: 'USD',
          mcc: '5411',
        ),
      ),
    );
    // Business outcome, not a span-level error.
    expect(
      spans.findSpanByName('marqeta transactions.simulate')!.status,
      isNot(SpanStatusCode.Error),
    );
  });

  test('KYC FAILURE sets span error', () async {
    await tracedMarqeta<String>(
      operation: 'users.kyc',
      invoke: () async => const MarqetaCallResult(
        value: 'ok',
        result: MarqetaResult(
          kycResult: 'FAILURE',
          kycReasonCode: '1101',
        ),
      ),
    );
    expect(
      spans.findSpanByName('marqeta users.kyc')!.status,
      SpanStatusCode.Error,
    );
  });

  test('suppression skips spans', () async {
    await runWithoutMarqetaInstrumentationAsync(() async {
      await tracedMarqeta<String>(
        operation: 'ping',
        invoke: () async => const MarqetaCallResult(value: 'v'),
      );
    });
    expect(spans.findSpansStartingWith('marqeta '), isEmpty);
  });
}
