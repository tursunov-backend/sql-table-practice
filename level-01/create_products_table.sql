CREATE TYPE product_status AS ENUM (
    'draft',
    'active',
    'inactive',
    'archived'

);

CREATE TYPE product_condition AS ENUM (
    'new',
    'used'
);

CREATE TABLE products (
    id bigserial NOT NULL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    slug varchar(200) NOT NULL UNIQUE,
    description TEXT,
    price NUMERIC(12, 2) NOT NULL,
    discount_price NUMERIC(12, 2),
    stock_quantity INTEGER DEFAULT 0,
    condition product_condition,
    status product_status DEFAULT 'draft',
    is_featured BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),

    CONSTRAINT price_check CHECK (price > 0),
    CONSTRAINT discount_price_check CHECK (discount_price IS NULL OR discount_price < price),
    CONSTRAINT stock_quantity_check CHECK (stock_quantity >= 0)
);