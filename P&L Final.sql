-- Creating a procedure and defining the variable needed as input

DELIMITER $$
  DROP PROCEDURE IF EXISTS H_Accounting.t15;
CREATE PROCEDURE H_Accounting.t15(varCalendarYear SMALLINT)
BEGIN

-- Declaring all the variables for actual year data and giving them default value 0

DECLARE varTotalRevenues DOUBLE DEFAULT 0;
DECLARE varTotalReturns DOUBLE DEFAULT 0;
DECLARE varTotalCosts DOUBLE DEFAULT 0;
DECLARE varTotalAdminExpen DOUBLE DEFAULT 0;
DECLARE varTotalSellExpen DOUBLE DEFAULT 0;
DECLARE varTotalOtherExpen DOUBLE DEFAULT 0;
DECLARE varTotalOtherInc DOUBLE DEFAULT 0;
DECLARE varTotalIncTax DOUBLE DEFAULT 0;
DECLARE varOtherTax DOUBLE DEFAULT 0;

-- Declare all the variables for previous year data and giving them default value 0

DECLARE varTotalRevenuesPY DOUBLE DEFAULT 0;
DECLARE varTotalReturnsPY DOUBLE DEFAULT 0;
DECLARE varTotalCostsPY DOUBLE DEFAULT 0;
DECLARE varTotalAdminExpenPY DOUBLE DEFAULT 0;
DECLARE varTotalSellExpenPY DOUBLE DEFAULT 0;
DECLARE varTotalOtherExpenPY DOUBLE DEFAULT 0;
DECLARE varTotalOtherIncPY DOUBLE DEFAULT 0;
DECLARE varTotalIncTaxPY DOUBLE DEFAULT 0;
DECLARE varOtherTaxPY DOUBLE DEFAULT 0;

-- Inserting all the necessary data into the previously declared variables

SELECT (CASE WHEN SUM(jeli.credit) IS NULL THEN 0
			 ELSE SUM(jeli.credit)END) 
		INTO varTotalRevenues
		FROM H_Accounting.journal_entry_line_item AS jeli
			INNER JOIN H_Accounting.`account` AS ac 
			ON ac.account_id = jeli.account_id
			INNER JOIN H_Accounting.journal_entry  AS je 
			ON je.journal_entry_id = jeli.journal_entry_id
			INNER JOIN H_Accounting.statement_section AS ss 
			ON ss.statement_section_id = ac.profit_loss_section_id      
	WHERE ss.statement_section_code = "REV"
	AND YEAR(je.entry_date) = varCalendarYear;

SELECT 
	(CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalReturns
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "RET"
	AND YEAR(je.entry_date) = varCalendarYear;

SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalCosts
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "COGS"
	AND YEAR(je.entry_date) = varCalendarYear;
    
SELECT (CASE
    WHEN SUM(jeli.debit) IS NULL THEN 0
    ELSE SUM(jeli.debit)
    END) INTO varTotalAdminExpen
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "GEXP"
	AND YEAR(je.entry_date) = varCalendarYear;
    
    SELECT (CASE
    WHEN SUM(jeli.debit) IS NULL THEN 0
    ELSE SUM(jeli.debit)
    END) INTO varTotalSellExpen
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "SEXP"
	AND YEAR(je.entry_date) = varCalendarYear;
    
SELECT (CASE
    WHEN SUM(jeli.debit) IS NULL THEN 0
    ELSE SUM(jeli.debit)
    END) INTO varTotalOtherExpen
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "OEXP"
	AND YEAR(je.entry_date) = varCalendarYear;
    
    SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalOtherInc
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "OI"
	AND YEAR(je.entry_date) = varCalendarYear;
    
    
    SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalIncTax
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "INCTAX"
	AND YEAR(je.entry_date) = varCalendarYear;
    
SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varOtherTax
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "OTHTAX"
	AND YEAR(je.entry_date) = varCalendarYear;
    
-- Inserting the necessary data into all variables for previous year
    
-- Previous year
    
SELECT (CASE WHEN SUM(jeli.credit) IS NULL THEN 0
			 ELSE SUM(jeli.credit)END) 
INTO varTotalRevenuesPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "REV"
	AND YEAR(je.entry_date) = varCalendarYear - 1;

SELECT 
	(CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalReturnsPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "RET"
	AND YEAR(je.entry_date) = varCalendarYear - 1;

SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalCostsPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "COGS"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
SELECT (CASE
    WHEN SUM(jeli.debit) IS NULL THEN 0
    ELSE SUM(jeli.debit)
    END) INTO varTotalAdminExpenPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "GEXP"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
    SELECT (CASE
    WHEN SUM(jeli.debit) IS NULL THEN 0
    ELSE SUM(jeli.debit)
    END) INTO varTotalSellExpenPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "SEXP"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
SELECT (CASE
    WHEN SUM(jeli.debit) IS NULL THEN 0
    ELSE SUM(jeli.debit)
    END) INTO varTotalOtherExpenPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "OEXP"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
    SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalOtherIncPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "OI"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
    
    SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varTotalIncTaxPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "INCTAX"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
SELECT (CASE
    WHEN SUM(jeli.credit) IS NULL THEN 0
    ELSE SUM(jeli.credit)
    END) INTO varOtherTaxPY
FROM H_Accounting.journal_entry_line_item AS jeli
INNER JOIN H_Accounting.`account` AS ac 
	ON ac.account_id = jeli.account_id
INNER JOIN H_Accounting.journal_entry  AS je 
	ON je.journal_entry_id = jeli.journal_entry_id
INNER JOIN H_Accounting.statement_section AS ss 
	ON ss.statement_section_id = ac.profit_loss_section_id      
WHERE ss.statement_section_code = "OTHTAX"
	AND YEAR(je.entry_date) = varCalendarYear - 1;
    
    
 -- Using my temporary table, dropping and creating it and defining the columns for the profit and loss statement   

 DROP TABLE IF EXISTS H_Accounting.selangovan_tmp;

CREATE TABLE H_Accounting.selangovan_tmp
(profit_loss_line_number INT, 
 label VARCHAR(50), 
     amount VARCHAR(50),
		percentage_change VARCHAR(50)
);

-- Inserting all the rows, one by one, to make the final table for the P and L statement

INSERT INTO H_Accounting.selangovan_tmp
   (profit_loss_line_number, label, amount, percentage_change)
VALUES (1, 'PROFIT AND LOSS STATEMENT', "In '000s of USD","% change");

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (2, '', '', '');

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (3, 'Total Revenues', format(varTotalRevenues / 1000, 2),format((varTotalRevenues - varTotalRevenuesPY)/NULLIF(varTotalRevenuesPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (4, 'Total Returns, Refunds, Discounts', format(varTotalReturns / 1000, 2),format((varTotalReturns - varTotalReturnsPY)/NULLIF(varTotalReturnsPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (5, 'Total Costs of Goods and Services', format(varTotalCosts / 1000, 2),format((varTotalCosts - varTotalCostsPY)/NULLIF(varTotalCostsPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (6, 'Gross Margins', format((varTotalRevenues - varTotalReturns - varTotalCosts) / 1000, 2),format(((varTotalRevenues - varTotalReturns - varTotalCosts) - (varTotalRevenuesPY - varTotalReturnsPY - varTotalCostsPY))/NULLIF((varTotalRevenuesPY - varTotalReturnsPY - varTotalCostsPY),0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (7, 'Administrative Expenses', format((varTotalAdminExpen) / 1000, 2),format((varTotalAdminExpen - varTotalAdminExpenPY)/NULLIF(varTotalAdminExpenPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (8, 'Selling Expenses', format((varTotalSellExpen) / 1000, 2),format((varTotalSellExpen - varTotalSellExpenPY)/NULLIF(varTotalSellExpenPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (9, 'Other Expenses', format((varTotalOtherExpen) / 1000, 2),format((varTotalOtherExpen - varTotalOtherExpenPY)/NULLIF(varTotalOtherExpenPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (10, 'Other income', format((varTotalOtherInc) / 1000, 2),format((varTotalOtherInc - varTotalOtherIncPY)/NULLIF(varTotalOtherIncPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (11, 'Earning before tax', format((varTotalRevenues - varTotalReturns - varTotalCosts -varTotalAdminExpen -varTotalSellExpen -varTotalOtherExpen + varTotalOtherInc)/ 1000, 2),format(((varTotalRevenues - varTotalReturns - varTotalCosts -varTotalAdminExpen -varTotalSellExpen -varTotalOtherExpen + varTotalOtherInc) - (varTotalRevenuesPY - varTotalReturnsPY - varTotalCostsPY -varTotalAdminExpenPY -varTotalSellExpenPY -varTotalOtherExpenPY + varTotalOtherIncPY))/NULLIF((varTotalRevenuesPY - varTotalReturnsPY - varTotalCostsPY -varTotalAdminExpenPY -varTotalSellExpenPY -varTotalOtherExpenPY + varTotalOtherIncPY),0)*100,2));


INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (12, 'Income Tax', format((varTotalIncTax) / 1000, 2),format((varTotalIncTax - varTotalIncTaxPY)/NULLIF(varTotalIncTaxPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (13, 'Other Tax', format((varOtherTax) / 1000, 2),format((varOtherTax - varOtherTaxPY)/NULLIF(varOtherTaxPY,0)*100,2));

INSERT INTO H_Accounting.selangovan_tmp
(profit_loss_line_number, label, amount, percentage_change)
VALUES  (14, 'Earning after tax', format((varTotalRevenues - varTotalReturns - varTotalCosts -varTotalAdminExpen -varTotalSellExpen -varTotalOtherExpen + varTotalOtherInc - varTotalIncTax - varOtherTax)/ 1000, 2),format(((varTotalRevenues - varTotalReturns - varTotalCosts -varTotalAdminExpen -varTotalSellExpen -varTotalOtherExpen + varTotalOtherInc - varTotalIncTax - varOtherTax) - (varTotalRevenuesPY - varTotalReturnsPY - varTotalCostsPY -varTotalAdminExpenPY -varTotalSellExpenPY -varTotalOtherExpenPY + varTotalOtherIncPY - varTotalIncTaxPY - varOtherTaxPY))/NULLIF((varTotalRevenuesPY - varTotalReturnsPY - varTotalCostsPY -varTotalAdminExpenPY -varTotalSellExpenPY -varTotalOtherExpenPY + varTotalOtherIncPY - varTotalIncTaxPY - varOtherTaxPY),0)*100,2));



    
END $$
DELIMITER ;



-- Calling the created procedure, and inputting the year needed for the pofit and loss statement. Selecting the temp table to get the profit and loss statement as output.

CALL H_Accounting.t15 (2016);

SELECT * FROM H_Accounting.selangovan_tmp;