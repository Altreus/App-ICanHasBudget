-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sat May 21 00:39:29 2016
-- 

;
BEGIN TRANSACTION;
--
-- Table: accounts
--
CREATE TABLE accounts (
  name text NOT NULL,
  type text NOT NULL,
  PRIMARY KEY (name)
);
--
-- Table: kitties
--
CREATE TABLE kitties (
  name text NOT NULL,
  type text NOT NULL,
  target int NOT NULL DEFAULT 0,
  parent_kitty_name text,
  PRIMARY KEY (name)
);
--
-- Table: transactions
--
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY NOT NULL,
  amount int NOT NULL,
  kitty_name text,
  from_account_name text,
  to_account_name text,
  date date,
  FOREIGN KEY (from_account_name) REFERENCES accounts(name) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (kitty_name) REFERENCES kitties(name) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (to_account_name) REFERENCES accounts(name) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX transactions_idx_from_account_name ON transactions (from_account_name);
CREATE INDEX transactions_idx_kitty_name ON transactions (kitty_name);
CREATE INDEX transactions_idx_to_account_name ON transactions (to_account_name);
COMMIT;
