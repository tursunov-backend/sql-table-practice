SELECT * FROM users WHERE last_login_at>= now() - INTERVAL '7 days'
AND status = 'active' ORDER BY created_at DESC;