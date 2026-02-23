DELETE FROM users
WHERE status = 'blocked' AND login_attempts >= 10;