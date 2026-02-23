UPDATE users
SET status = 'active'
WHERE id IN (
    SELECT id
    FROM users
    ORDER BY status = 'pending'
    LIMIT 10
);