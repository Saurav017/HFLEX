-- THis was just for smoke test of the migration system and initial schema setup. V2 will have real schema.


-- Keep schema explicit (avoid public chaos)
CREATE SCHEMA IF NOT EXISTS ledger;

-- Accounts (example core table)
CREATE TABLE IF NOT EXISTS ledger.account (
  account_id      UUID PRIMARY KEY,
  customer_id     UUID NOT NULL,
  currency        CHAR(3) NOT NULL,
  status          TEXT NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Ledger entries (append-only style)
CREATE TABLE IF NOT EXISTS ledger.entry (
  entry_id        UUID PRIMARY KEY,
  account_id      UUID NOT NULL REFERENCES ledger.account(account_id),
  amount          NUMERIC(20, 2) NOT NULL,
  direction       TEXT NOT NULL CHECK (direction IN ('DEBIT', 'CREDIT')),
  idempotency_key TEXT NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (account_id, idempotency_key)
);

CREATE INDEX IF NOT EXISTS idx_entry_account_created_at
  ON ledger.entry(account_id, created_at);
