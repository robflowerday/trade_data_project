-- This query s used in main.py, but has been separated
-- for ease of use.

SELECT
    trades.instrument_id,
    date_trunc('second', "event_timestamp") AS when_timestamp,

    valuedata_5s.gamma AS gamma_5s,
    valuedata_1m.gamma AS gamma_1m,
    valuedata_30m.gamma AS gamma_30m,
    valuedata_60m.gamma AS gamma_60m,

    valuedata_5s.vega AS vega_5s,
    valuedata_1m.vega AS vega_1m,
    valuedata_30m.vega AS vega_30m,
    valuedata_60m.vega AS vega_60m,

    valuedata_5s.theta AS theta_5s,
    valuedata_1m.theta AS theta_1m,
    valuedata_30m.theta AS theta_30m,
    valuedata_60m.theta AS theta_60m
FROM trades

LEFT OUTER JOIN valuedata valuedata_5s
ON trades.instrument_id=valuedata_5s.instrument_id
AND valuedata_5s.when_timestamp=date_trunc('second', "event_timestamp") + INTERVAL '5 seconds'

LEFT OUTER JOIN valuedata valuedata_1m
ON trades.instrument_id=valuedata_1m.instrument_id
AND valuedata_1m.when_timestamp=date_trunc('second', "event_timestamp") + INTERVAL '1 minute'

LEFT OUTER JOIN valuedata valuedata_30m
ON trades.instrument_id=valuedata_30m.instrument_id
AND valuedata_30m.when_timestamp=date_trunc('second', "event_timestamp") + INTERVAL '30 minutes'

LEFT OUTER JOIN valuedata valuedata_60m
ON trades.instrument_id=valuedata_60m.instrument_id
AND valuedata_60m.when_timestamp=date_trunc('second', "event_timestamp") + INTERVAL '1 hour';
