-- ====================================================================
-- 📊 PRACTICE SCRIPT: SQL Stored Procedures
-- ====================================================================

-- A Stored Procedure is a prepared SQL code block that you can save, 
-- so the code can be reused over and over again.

-- --------------------------------------------------------------------
-- 1. SETUP SAMPLE DATA
-- --------------------------------------------------------------------
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 85000.00, 15),
('Smartphone', 'Electronics', 45000.00, 30),
('Desk Chair', 'Furniture', 8500.00, 20),
('Coffee Table', 'Furniture', 12000.00, 8),
('Running Shoes', 'Apparel', 4500.00, 50),
('Backpack', 'Apparel', 2500.00, 40);


-- --------------------------------------------------------------------
-- 2. BASIC STORED PROCEDURE (No Parameters)
-- --------------------------------------------------------------------
-- The DELIMITER command is used to change the standard delimiter (semicolon) 
-- to something else (like //) so that we can write semicolons inside the procedure.

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM products;
END //

DELIMITER ;

-- How to call:
CALL GetAllProducts();


-- --------------------------------------------------------------------
-- 3. STORED PROCEDURE WITH "IN" PARAMETER
-- --------------------------------------------------------------------
-- IN parameter: Passes a value into the procedure. The value is read-only inside.

DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN category_name VARCHAR(50))
BEGIN
    SELECT * FROM products 
    WHERE category = category_name;
END //

DELIMITER ;

-- How to call:
CALL GetProductsByCategory('Electronics');
CALL GetProductsByCategory('Furniture');


-- --------------------------------------------------------------------
-- 4. STORED PROCEDURE WITH "OUT" PARAMETER
-- --------------------------------------------------------------------
-- OUT parameter: Returns a value from the procedure back to the caller.

DELIMITER //

CREATE PROCEDURE GetProductCountByCategory(
    IN category_name VARCHAR(50), 
    OUT total_count INT
)
BEGIN
    SELECT COUNT(*) INTO total_count 
    FROM products 
    WHERE category = category_name;
END //

DELIMITER ;

-- How to call:
-- 1. Declare a session variable to store the output (e.g., @apparel_count)
-- 2. Call the procedure
-- 3. Select the session variable to see the result
CALL GetProductCountByCategory('Apparel', @apparel_count);
SELECT @apparel_count AS TotalApparelProducts;


-- --------------------------------------------------------------------
-- 5. STORED PROCEDURE WITH "INOUT" PARAMETER
-- --------------------------------------------------------------------
-- INOUT parameter: Passes a value in, allows the procedure to modify it, 
-- and returns the updated value back to the caller.

DELIMITER //

CREATE PROCEDURE ApplyDiscount(
    INOUT price_value DECIMAL(10,2), 
    IN discount_pct DECIMAL(5,2)
)
BEGIN
    SET price_value = price_value - (price_value * (discount_pct / 100));
END //

DELIMITER ;

-- How to call:
-- 1. Initialize a session variable with the original price
SET @item_price = 1000.00;

-- 2. Call the procedure to apply a 15% discount
CALL ApplyDiscount(@item_price, 15.00);

-- 3. Check the modified value of the session variable (Expected: 850.00)
SELECT @item_price AS DiscountedPrice;


-- --------------------------------------------------------------------
-- 6. MANAGING STORED PROCEDURES (Status & Drop)
-- --------------------------------------------------------------------

-- Show list of all stored procedures in the current database
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

-- Show the creation statement of a specific procedure
SHOW CREATE PROCEDURE GetProductsByCategory;

-- Deleting (dropping) a stored procedure
DROP PROCEDURE IF EXISTS GetAllProducts;
DROP PROCEDURE IF EXISTS GetProductsByCategory;
DROP PROCEDURE IF EXISTS GetProductCountByCategory;
DROP PROCEDURE IF EXISTS ApplyDiscount;

-- Clean up
DROP TABLE products;
