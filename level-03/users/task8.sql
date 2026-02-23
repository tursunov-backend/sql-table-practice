UPDATE users SET is_verified = true WHERE role IN ('admin', 'manager');

