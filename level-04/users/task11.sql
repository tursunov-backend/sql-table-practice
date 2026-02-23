DELETE FROM users
WHERE id IN (
    SELECT id
    FROM users
    ORDER BY created_at ASC
    LIMIT 5
);