PRAGMA foreign_keys = ON;

-- =========================
-- ADMIN TABLE
-- =========================
CREATE TABLE admin (
    admin_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT UNIQUE,
    password TEXT,
    profile_image TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    reset_token TEXT,
    token_expiry DATETIME,

    -- ENUM replaced with CHECK
    role TEXT DEFAULT 'admin'
        CHECK(role IN ('admin','super_admin')),

    is_approved INTEGER DEFAULT 0,
    created_by INTEGER,
    last_login DATETIME,

    FOREIGN KEY(created_by) REFERENCES admin(admin_id)
);

-- =========================
-- PRODUCTS TABLE
-- =========================
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    category TEXT,
    price REAL,
    image TEXT,
    admin_id INTEGER,
    quantity INTEGER DEFAULT 0,

    FOREIGN KEY(admin_id) REFERENCES admin(admin_id)
);

-- =========================
-- ORDERS TABLE
-- =========================
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    razorpay_order_id TEXT,
    razorpay_payment_id TEXT,
    amount REAL,
    payment_status TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    address_id INTEGER,
    admin_id INTEGER,

    FOREIGN KEY(admin_id) REFERENCES admin(admin_id)
);

-- =========================
-- ORDER ITEMS TABLE
-- =========================
CREATE TABLE order_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    product_name TEXT,
    quantity INTEGER,
    price REAL,

    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

-- =========================
-- USER ADDRESSES TABLE
-- =========================
CREATE TABLE user_addresses (
    address_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    full_name TEXT,
    phone TEXT,
    address_line TEXT,
    city TEXT,
    state TEXT,
    pincode TEXT,
    is_default INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO admin (name, email, password, role, is_approved)
SELECT
    'Super Admin',
    'kavyasrimittapalli@gmail.com',
    'scrypt:32768:8:1$NEkgKhNDqup3bfUx$d71792545953141c5ae52270ea01957e3e5c756ccce3dd9c80ac96324fe1d5c80965e7506b372c1c6ca1c92dab547253c1ce15ce6c94e415965e1728570f6f8b',
    'super_admin',
    1
WHERE NOT EXISTS (
    SELECT 1 FROM admin WHERE email = 'kavyasrimittapalli@gmail.com'
);


-- =========================
-- USERS TABLE (CUSTOMERS)
-- =========================
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT UNIQUE,
    password TEXT,
    profile_image TEXT
);