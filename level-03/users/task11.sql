UPDATE users
SET is_verified = TRUE
WHERE id IN (
    SELECT id
    FROM users
    ORDER BY created_at DESC
    LIMIT 5
);