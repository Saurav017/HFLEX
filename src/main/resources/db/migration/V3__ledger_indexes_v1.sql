
CREATE SCHEMA IF NOT EXISTS ledger;

-- Index for statement reads
CREATE INDEX IF NOT EXISTS idx_journal_lines_account_created_at
    ON ledger.journal_lines(account_id, created_at DESC);

-- Index for entry lookup
CREATE INDEX IF NOT EXISTS idx_journal_lines_journal_entry_id
    ON ledger.journal_lines(journal_entry_id);