UPDATE users SET status = 'active', updated_at = NOW()
WHERE status = 'blocked' AND login_attempts = 0;
