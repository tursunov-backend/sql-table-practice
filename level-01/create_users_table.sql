CREATE TYPE user_role AS ENUM (
    'admin',
    'manager',
    'customer'
);

CREATE TYPE user_status AS ENUM (
    'active',
    'blocked',
    'pending'
);

CREATE TABLE users (
    id bigserial NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    role user_role NOT NULL,
    status user_status NOT NULL DEFAULT 'pending',
    is_verified BOOLEAN DEFAULT false,
    login_attempts INTEGER DEFAULT 0,
    last_login_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),

    CONSTRAINT login_attempts_check CHECK (login_attempts >= 0),
    CONSTRAINT birth_date_check CHECK (birth_date IS NULL OR birth_date < current_date),
    CONSTRAINT username_check CHECK (char_length(username) >= 3)
);