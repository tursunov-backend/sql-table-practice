SELECT * FROM products
WHERE status = 'active' AND stock_quantity > 0 AND price > 500
ORDER BY price;