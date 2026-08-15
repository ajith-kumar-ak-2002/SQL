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
-- 2. CREATE PROCEDURE, CALL, AND DELIMITER USAGE
-- --------------------------------------------------------------------
-- The DELIMITER command is used to change the standard delimiter (semicolon) 
-- to something else (like //) so that we can write semicolons inside the procedure.

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    -- SELECT inside a procedure
    SELECT * FROM products;
END //

DELIMITER ;

-- How to call a procedure:
CALL GetAllProducts();


-- --------------------------------------------------------------------
-- 3. INSERT, UPDATE, AND DELETE INSIDE PROCEDURES
-- --------------------------------------------------------------------

-- A. INSERT Operation Inside Procedure
DELIMITER //

CREATE PROCEDURE AddNewProduct(
    IN p_name VARCHAR(100),
    IN p_category VARCHAR(50),
    IN p_price DECIMAL(10,2),
    IN p_stock INT
)
BEGIN
    INSERT INTO products (product_name, category, price, stock_quantity)
    VALUES (p_name, p_category, p_price, p_stock);
END //

DELIMITER ;

-- Call the Insert procedure:
CALL AddNewProduct('Tablet', 'Electronics', 25000.00, 25);


-- B. UPDATE Operation Inside Procedure
DELIMITER //

CREATE PROCEDURE UpdateProductStock(
    IN p_id INT,
    IN new_stock INT
)
BEGIN
    UPDATE products 
    SET stock_quantity = new_stock 
    WHERE product_id = p_id;
END //

DELIMITER ;

-- Call the Update procedure:
CALL UpdateProductStock(1, 18); -- Updates Laptop stock to 18


-- C. DELETE Operation Inside Procedure
DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN p_id INT
)
BEGIN
    DELETE FROM products 
    WHERE product_id = p_id;
END //

DELIMITER ;

-- Call the Delete procedure:
CALL DeleteProduct(6); -- Deletes Backpack (ID 6)


-- --------------------------------------------------------------------
-- 4. PARAMETERS IN-DEPTH: IN, OUT, AND INOUT
-- --------------------------------------------------------------------

-- A. IN Parameter (Passes read-only input value to the procedure)
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN category_name VARCHAR(50))
BEGIN
    SELECT * FROM products 
    WHERE category = category_name;
END //

DELIMITER ;

-- Call with IN:
CALL GetProductsByCategory('Electronics');


-- B. OUT Parameter (Returns a value from the procedure back to the caller)
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

-- Call with OUT:
-- 1. Call and pass a session variable to capture output
CALL GetProductCountByCategory('Electronics', @electronics_count);
-- 2. Select variable value to view output
SELECT @electronics_count AS TotalElectronics;


-- C. INOUT Parameter (Passes input value, modifies it, and returns updated value)
DELIMITER //

CREATE PROCEDURE ApplyDiscount(
    INOUT price_value DECIMAL(10,2), 
    IN discount_pct DECIMAL(5,2)
)
BEGIN
    SET price_value = price_value - (price_value * (discount_pct / 100));
END //

DELIMITER ;

-- Call with INOUT:
-- 1. Initialize session variable
SET @item_price = 1000.00;
-- 2. Call procedure
CALL ApplyDiscount(@item_price, 15.00);
-- 3. Query variable (Output: 850.00)
SELECT @item_price AS DiscountedPrice;


-- --------------------------------------------------------------------
-- 5. VARIABLES, SELECT INTO, IF-ELSE, & TRANSACTIONS
-- --------------------------------------------------------------------
-- This procedure simulates purchasing a product:
-- - Uses DECLARE for local variables.
-- - Uses SELECT ... INTO to fetch stock and price.
-- - Uses IF-ELSE to verify stock.
-- - Uses START TRANSACTION, COMMIT, and ROLLBACK to manage changes.

DELIMITER //

CREATE PROCEDURE PurchaseProduct(
    IN p_id INT,
    IN req_quantity INT,
    OUT status_msg VARCHAR(100)
)
BEGIN
    -- Declare local variables inside the procedure
    DECLARE current_stock INT;
    DECLARE item_price DECIMAL(10,2);
    DECLARE total_cost DECIMAL(10,2);

    -- Fetch values using SELECT ... INTO
    SELECT stock_quantity, price 
    INTO current_stock, item_price 
    FROM products 
    WHERE product_id = p_id;

    -- IF-ELSE Conditional Logic
    IF current_stock IS NULL THEN
        SET status_msg = 'Failure: Product does not exist.';
        
    ELSEIF current_stock >= req_quantity THEN
        -- Calculate total cost
        SET total_cost = item_price * req_quantity;
        
        -- Start Transaction Control
        START TRANSACTION;
        
        -- Deduct stock
        UPDATE products 
        SET stock_quantity = stock_quantity - req_quantity 
        WHERE product_id = p_id;
        
        -- Check logic: If total cost is too high (e.g., limit of 150,000 for safety), rollback!
        IF total_cost > 150000.00 THEN
            ROLLBACK;
            SET status_msg = 'Transaction Rolled Back: Purchase exceeds safety limit of 150,000.';
        ELSE
            COMMIT;
            SET status_msg = CONCAT('Success! Purchased ', req_quantity, ' items. Total Cost: ', total_cost);
        END IF;
        
    ELSE
        SET status_msg = CONCAT('Failure: Not enough stock. Available: ', current_stock);
    END IF;
END //

DELIMITER ;

-- How to call:
-- Case 1: Valid purchase
CALL PurchaseProduct(2, 5, @msg1);
SELECT @msg1;

-- Case 2: Insufficient stock
CALL PurchaseProduct(3, 100, @msg2);
SELECT @msg2;

-- Case 3: Exceeds safety transaction limit (triggers rollback)
CALL PurchaseProduct(1, 2, @msg3); -- Laptop is 85,000 * 2 = 170,000
SELECT @msg3;


-- --------------------------------------------------------------------
-- 6. MANAGING & DROP PROCEDURES
-- --------------------------------------------------------------------

-- Show all stored procedures in the current database
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

-- Show the creation query for a specific procedure
SHOW CREATE PROCEDURE GetAllProducts;

-- DROP PROCEDURE Examples:
DROP PROCEDURE IF EXISTS GetAllProducts;
DROP PROCEDURE IF EXISTS AddNewProduct;
DROP PROCEDURE IF EXISTS UpdateProductStock;
DROP PROCEDURE IF EXISTS DeleteProduct;
DROP PROCEDURE IF EXISTS GetProductsByCategory;
DROP PROCEDURE IF EXISTS GetProductCountByCategory;
DROP PROCEDURE IF EXISTS ApplyDiscount;
DROP PROCEDURE IF EXISTS PurchaseProduct;

-- Clean up table
DROP TABLE products;
