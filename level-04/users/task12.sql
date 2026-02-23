DELETE FROM users
WHERE login_attempts BETWEEN 5 AND 10 AND status = 'blocked';