
CREATE TABLE dim_date (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    full_date DATE,
    month INT,
    year INT
);
CREATE TABLE dim_store (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(50)
);
CREATE TABLE dim_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE fact_sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,
    units_sold INT,
    unit_price DECIMAL(10,2),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);



INSERT INTO dim_date (full_date, month, year)
SELECT DISTINCT 
    CASE 
		WHEN date LIKE '__/__/____' 
        THEN STR_TO_DATE(date, '%d/%m/%Y')
        
        WHEN date LIKE '____-__-__' 
        THEN STR_TO_DATE(date, '%Y-%m-%d')
	
		WHEN date LIKE '__-__-____' 
        THEN STR_TO_DATE(date, '%d-%m-%Y')
	END AS clean_date,
	
    MONTH(
        CASE 
            WHEN date LIKE '____-__-__' THEN STR_TO_DATE(date, '%Y-%m-%d')
            WHEN date LIKE '__/__/____' THEN STR_TO_DATE(date, '%d/%m/%Y')
            WHEN date LIKE '__-__-____' THEN STR_TO_DATE(date, '%d-%m-%Y')
        END
    ),

    YEAR(
        CASE 
            WHEN date LIKE '____-__-__' THEN STR_TO_DATE(date, '%Y-%m-%d')
            WHEN date LIKE '__/__/____' THEN STR_TO_DATE(date, '%d/%m/%Y')
            WHEN date LIKE '__-__-____' THEN STR_TO_DATE(date, '%d-%m-%Y')
        END
    )

FROM retail_transactions
WHERE date IS NOT NULL;




INSERT INTO dim_store (store_name, store_city)
SELECT DISTINCT 
    COALESCE(store_name, 'Unknown'),
    COALESCE(store_city, 'Unknown')
FROM retail_transactions;


INSERT INTO dim_store (store_name, store_city)
SELECT store_name, COALESCE(MAX(NULLIF(store_city, '')),'Unknown')
AS store_city
FROM retail_transactions
GROUP BY store_name;

INSERT INTO dim_product (product_name, category)
SELECT DISTINCT 
    product_name,
    LOWER(category)
FROM retail_transactions;


INSERT INTO fact_sales (
    date_id, store_id, product_id, units_sold, unit_price
)
SELECT 
    d.date_id,
    s.store_id,
    p.product_id,
    r.units_sold,
    r.unit_price
FROM retail_transactions r

JOIN dim_date d 
    ON (
        CASE 
            WHEN r.date LIKE '____-__-__' THEN STR_TO_DATE(r.date, '%Y-%m-%d')
            WHEN r.date LIKE '__/__/____' THEN STR_TO_DATE(r.date, '%d/%m/%Y')
            WHEN r.date LIKE '__-__-____' THEN STR_TO_DATE(r.date, '%d-%m-%Y')
        END
    ) = d.full_date

JOIN dim_store s 
    ON r.store_name = s.store_name

JOIN dim_product p 
    ON r.product_name = p.product_name;
    
    
    
    

