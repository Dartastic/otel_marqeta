// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_marqeta/otel_marqeta.dart';

/// Traces Marqeta calls with OpenTelemetry.
///
/// `otel_marqeta` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Marqeta call in
/// [tracedMarqeta]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'marqeta-example');

  // Traces a Marqeta call.
  final marqetaId = await tracedMarqeta<String>(
    operation: 'create',
    invoke: () async {
      // Make the Marqeta call here, then report what it returned.
      const id = 'marqeta_8f3a2c';
      return const MarqetaCallResult(
          value: id,
          result: MarqetaResult(
              environment: 'example',
              programShortCode: 'example',
              surface: 'example',
              cardProductToken: 'example',
              cardToken: 'example',
              cardState: 'active',
              cardFulfillmentState: 'active',
              cardLast4: 'example',
              userToken: 'example',
              kycResult: 'example',
              kycReasonCode: 'example',
              transactionToken: 'example',
              transactionType: 'standard',
              transactionState: 'active',
              transactionResponseCode: 'example',
              networkCode: 'example',
              amountMicros: 1999,
              currencyCode: 'usd',
              mcc: 'example',
              merchantCountry: 'example',
              acquirerCountry: 'example',
              gpaOrderState: 'active',
              disputeState: 'active',
              statusCode: 201,
              errorCode: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedMarqeta create returned $marqetaId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutMarqetaInstrumentationAsync.
  await runWithoutMarqetaInstrumentationAsync(
    () => tracedMarqeta<String>(
      operation: 'create',
      invoke: () async {
        const id = 'marqeta_8f3a2c';
        return const MarqetaCallResult(
            value: id,
            result: MarqetaResult(
                environment: 'example',
                programShortCode: 'example',
                surface: 'example',
                cardProductToken: 'example',
                cardToken: 'example',
                cardState: 'active',
                cardFulfillmentState: 'active',
                cardLast4: 'example',
                userToken: 'example',
                kycResult: 'example',
                kycReasonCode: 'example',
                transactionToken: 'example',
                transactionType: 'standard',
                transactionState: 'active',
                transactionResponseCode: 'example',
                networkCode: 'example',
                amountMicros: 1999,
                currencyCode: 'usd',
                mcc: 'example',
                merchantCountry: 'example',
                acquirerCountry: 'example',
                gpaOrderState: 'active',
                disputeState: 'active',
                statusCode: 201,
                errorCode: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
