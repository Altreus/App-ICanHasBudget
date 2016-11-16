-- Convert schema 'share/ddl/_source/deploy/1/001-auto.yml' to 'share/ddl/_source/deploy/2/001-auto.yml':;

;
BEGIN;

;
CREATE TABLE scheduled_transactions (
  id INTEGER PRIMARY KEY NOT NULL,
  description text NOT NULL,
  amount int NOT NULL,
  next_occurrence date NOT NULL,
  end_date date,
  schedule text
);

;

COMMIT;

