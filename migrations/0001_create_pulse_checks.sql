CREATE TABLE pulse_checks (
  checked_at INTEGER PRIMARY KEY,
  outcome TEXT NOT NULL CHECK (outcome IN ('ok', 'error')),
  signature_count INTEGER CHECK (signature_count >= 0),
  petition_status TEXT,
  is_closed INTEGER CHECK (is_closed IN (0, 1)),
  closing_at TEXT,
  error_code TEXT,
  CHECK (
    (outcome = 'ok' AND signature_count IS NOT NULL AND petition_status IS NOT NULL AND is_closed IS NOT NULL AND closing_at IS NOT NULL AND error_code IS NULL)
    OR
    (outcome = 'error' AND signature_count IS NULL AND petition_status IS NULL AND is_closed IS NULL AND closing_at IS NULL AND error_code IS NOT NULL)
  )
) STRICT;

CREATE INDEX pulse_checks_outcome_checked_at
ON pulse_checks (outcome, checked_at DESC);
