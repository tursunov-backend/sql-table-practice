DELETE FROM products
WHERE status IN ('inactive', 'archived') AND stock_quantity = 0 ;