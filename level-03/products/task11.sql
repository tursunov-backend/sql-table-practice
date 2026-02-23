UPDATE products
SET discount_price = price * 0.8
WHERE id IN (
    SELECT id
    FROM products
    ORDER BY price DESC
    LIMIT 3
);