
-- Creating SCHEMA ledger

--Index for statement reads
------journal_lines(account_id, created_at DESC)
--Index for entry lookup
------journal_lines(journal_entry_id)



CREATE SCHEMA IF NOT EXISTS ledger;

-- Creating TABLE ledger.account
CREATE TABLE IF NOT EXISTS ledger.accounts (
    account_id      UUID PRIMARY KEY,
    currency        CHAR(3) NOT NULL CHECK (currency ~ '^[A-Z]{3}$'),
    status          TEXT NOT NULL CHECK (status IN ('ACTIVE', 'SUSPENDED', 'CLOSED')),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);


-- Creating table ledger.journal_entries
CREATE TABLE IF NOT EXISTS ledger.journal_entries (
    journal_entry_id UUID PRIMARY KEY,
    request_id       TEXT NOT NULL UNIQUE,
    status         TEXT NOT NULL CHECK (status IN ('PENDING', 'POSTED', 'FAILED')),
    currency      CHAR(3) NOT NULL CHECK (currency ~ '^[A-Z]{3}$'),
    created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
    );


-- Creating journal_lines table
CREATE TABLE IF NOT EXISTS ledger.journal_lines (
    journal_line_id  UUID PRIMARY KEY,
    journal_entry_id UUID NOT NULL REFERENCES ledger.journal_entries(journal_entry_id) ON DELETE RESTRICT,
    account_id       UUID NOT NULL REFERENCES ledger.accounts(account_id) ON DELETE RESTRICT,
    amount           NUMERIC(20, 2) NOT NULL CHECK (amount <> 0),
    created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);




