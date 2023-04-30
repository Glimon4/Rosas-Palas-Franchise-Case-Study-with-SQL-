USE H_Accounting;
-- Creating the procedure

DELIMITER $$
 DROP PROCEDURE IF EXISTS H_Accounting.BSsel1;
CREATE PROCEDURE H_Accounting.BSsel1(varCalendarYear SMALLINT)
	
    READS SQL DATA
    
BEGIN

-- Declaring all the variables we need

DECLARE varCurrentAssets DOUBLE DEFAULT 0;
DECLARE varFixedAssets DOUBLE DEFAULT 0;
DECLARE varDeferredAssets DOUBLE DEFAULT 0;
DECLARE varCurrentLiab DOUBLE DEFAULT 0;
DECLARE varLongTermLiab DOUBLE DEFAULT 0;
DECLARE varDeferLiab DOUBLE DEFAULT 0;
DECLARE varEquity DOUBLE DEFAULT 0;


DECLARE varCurrentAssetsPY DOUBLE DEFAULT 0;
DECLARE varFixedAssetsPY DOUBLE DEFAULT 0;
DECLARE varDeferredAssetsPY DOUBLE DEFAULT 0;
DECLARE varCurrentLiabPY DOUBLE DEFAULT 0;
DECLARE varLongTermLiabPY DOUBLE DEFAULT 0;
DECLARE varDeferLiabPY DOUBLE DEFAULT 0;
DECLARE varEquityPY DOUBLE DEFAULT 0;

-- Inserting all necessary data into the previusly declared variables
-- Actual year data
SELECT 
	((CASE 
     WHEN SUM(debit) IS NULL THEN 0
     ELSE SUM(debit) 
     END)
     -
     (CASE 
     WHEN SUM(credit) is null then 0
     ELSE SUM(credit)
    END)) INTO varCurrentAssets
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "CA";

SELECT 
	((CASE 
     WHEN SUM(debit) IS NULL THEN 0
     ELSE SUM(debit) 
     END)
     -
     (CASE 
     WHEN SUM(credit) is null then 0
     ELSE SUM(credit)
    END)) INTO varFixedAssets
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "FA";

SELECT 
	((CASE 
     WHEN SUM(debit) IS NULL THEN 0
     ELSE SUM(debit) 
     END)
     -
     (CASE 
     WHEN SUM(credit) is null then 0
     ELSE SUM(credit)
    END))  INTO varDeferredAssets
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "DA";

SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END)) INTO varCurrentLiab
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "CL";

SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END))INTO varLongTermLiab
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "LLL";

SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END)) INTO varDeferLiab
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "DL";

SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END))INTO varEquity
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear AND ss.statement_section_code = "EQ";



-- Prior year data


SELECT 
	((CASE 
     WHEN SUM(debit) IS NULL THEN 0
     ELSE SUM(debit) 
     END)
     -
     (CASE 
     WHEN SUM(credit) is null then 0
     ELSE SUM(credit)
    END))
    INTO varCurrentAssetsPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = (varCalendarYear - 1) AND ss.statement_section_code = "CA";
    
SELECT 
	((CASE 
     WHEN SUM(debit) IS NULL THEN 0
     ELSE SUM(debit) 
     END)
     -
     (CASE 
     WHEN SUM(credit) is null then 0
     ELSE SUM(credit)
    END)) INTO varFixedAssetsPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear - 1 AND ss.statement_section_code = "FA";

SELECT 
	((CASE 
     WHEN SUM(debit) IS NULL THEN 0
     ELSE SUM(debit) 
     END)
     -
     (CASE 
     WHEN SUM(credit) is null then 0
     ELSE SUM(credit)
    END)) INTO varDeferredAssetsPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear - 1 AND ss.statement_section_code = "DA";
    
SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END)) INTO varCurrentLiabPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear - 1 AND ss.statement_section_code = "CL";
 
SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END)) INTO varLongTermLiabPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear - 1 AND ss.statement_section_code = "LLL";
    
SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END)) INTO varDeferLiabPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear - 1 AND ss.statement_section_code = "DL";

SELECT 
	((CASE 
     WHEN SUM(credit) IS NULL THEN 0
     ELSE SUM(credit) 
     END)
     -
     (CASE 
     WHEN SUM(debit) is null then 0
     ELSE SUM(debit)
    END)) INTO varEquityPY
FROM journal_entry AS j_entry
INNER JOIN journal_entry_line_item AS j_entry_item
ON j_entry.journal_entry_id = j_entry_item.journal_entry_id
INNER JOIN `account` AS a
ON a.account_id = j_entry_item.account_id
INNER JOIN statement_section AS ss
ON ss.statement_section_id = a.balance_sheet_section_id
WHERE YEAR(j_entry.entry_date) = varCalendarYear - 1 AND ss.statement_section_code = "EQ";

 -- Using the temporary table available for me, to make the Balance sheet, Which also includes the formulas to calculate the necessary.
 
	DROP TABLE IF EXISTS H_Accounting.selangovan_tmp;

CREATE TABLE H_Accounting.selangovan_tmp
(profit_loss_line_number INT, 
 label VARCHAR(50), 
     amount VARCHAR(50),
		percent_change VARCHAR(50)
);


INSERT INTO H_Accounting.selangovan_tmp
   (profit_loss_line_number, label, amount, percent_change)
VALUES (1, 'BALANCE SHEET', "In '000s of USD", "% Change");

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (2, '', '', '');

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (3, 'Total Current Assets', format(varCurrentAssets / 1000, 2),format((varCurrentAssets - varCurrentAssetsPY)/NULLIF(varCurrentAssetsPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (4, 'Total Fixed Assets', format(varFixedAssets / 1000, 2),format((varFixedAssets - varFixedAssetsPY)/NULLIF(varFixedAssetsPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (5, 'Total Deferred Assets', format(varDeferredAssets / 1000, 2),format((varDeferredAssets - varDeferredAssetsPY)/NULLIF(varDeferredAssetsPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (5, 'Total Assets', format((varDeferredAssets + varCurrentAssets + varFixedAssets) / 1000, 2),format((varCurrentAssets - varCurrentAssetsPY)/NULLIF(varCurrentAssetsPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (6, '', '', '');

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (7, 'Total Current Liabilities', format(varCurrentLiab / 1000, 2), format((varCurrentLiab - varCurrentLiabPY)/NULLIF(varCurrentLiabPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (8, 'Total Long-Term Liabilities', format(varLongTermLiab / 1000, 2), format((varLongTermLiab - varLongTermLiabPY)/NULLIF(varLongTermLiabPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (9, 'Total Deferred Liabilities', format(varDeferLiab / 1000, 2),format((varDeferLiab - varDeferLiabPY)/NULLIF(varDeferLiabPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (10, 'Total Liabilities', format((varCurrentLiab + varLongTermLiab + varDeferLiab) / 1000, 2),format(((varCurrentLiab + varLongTermLiab + varDeferLiab)-(varCurrentLiabPY + varLongTermLiabPY + varDeferLiabPY)) / 1000, 2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (11, '', '', '');

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percent_change)
VALUES  (12, 'Total Equity', format(varEquity / 1000, 2),format((varEquity - varEquityPY)/NULLIF(varEquityPY,0)*100,2));



END $$
DELIMITER ;

-- Calling the function and inputting the year for which we want the balance sheet. Then selecting the temporary table to view the balance sheet.
CALL H_Accounting.BSsel1(2015);
SELECT * 
FROM H_Accounting.selangovan_tmp;