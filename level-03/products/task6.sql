UPDATE products
SET status = 'inactive'
WHERE status = 'active' AND stock_quantity = 0;