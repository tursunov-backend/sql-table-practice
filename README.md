# 1-BOSQICH — CREATE TABLE

---

# TASK 1 — `users` jadvali

## 1. ENUM turlarini yarating

### `user_role`

Qiymatlar:

* admin
* manager
* customer

### `user_status`

Qiymatlar:

* active
* blocked
* pending

---

## 2. `users` jadvalini yarating

Quyidagi ustunlar bilan:

| Ustun          | Tip          | Talab                |
| -------------- | ------------ | -------------------- |
| id             | bigserial    | PRIMARY KEY          |
| username       | varchar(50)  | NOT NULL, UNIQUE     |
| email          | varchar(255) | NOT NULL, UNIQUE     |
| phone          | varchar(20)  | UNIQUE               |
| password_hash  | varchar(255) | NOT NULL             |
| first_name     | varchar(100) | NOT NULL             |
| last_name      | varchar(100) | NOT NULL             |
| birth_date     | date         | NULL bo‘lishi mumkin |
| role           | user_role    | NOT NULL             |
| status         | user_status  | DEFAULT 'pending'    |
| is_verified    | boolean      | DEFAULT false        |
| login_attempts | integer      | DEFAULT 0            |
| last_login_at  | timestamptz  | NULL bo‘lishi mumkin |
| created_at     | timestamptz  | DEFAULT now()        |
| updated_at     | timestamptz  | DEFAULT now()        |

### CHECK shartlar:

1. `login_attempts >= 0`
2. `birth_date IS NULL OR birth_date < current_date`
3. `char_length(username) >= 3`

---

# TASK 2 — `products` jadvali

## 1. ENUM turlarini yarating

### `product_status`

* draft
* active
* inactive
* archived

### `product_condition`

* new
* used

---

## 2. `products` jadvalini yarating

| Ustun          | Tip               | Talab                |
| -------------- | ----------------- | -------------------- |
| id             | bigserial         | PRIMARY KEY          |
| name           | varchar(200)      | NOT NULL             |
| slug           | varchar(200)      | NOT NULL, UNIQUE     |
| description    | text              | NULL bo‘lishi mumkin |
| price          | numeric(12,2)     | NOT NULL             |
| discount_price | numeric(12,2)     | NULL bo‘lishi mumkin |
| stock_quantity | integer           | DEFAULT 0            |
| condition      | product_condition | NULL bo‘lishi mumkin |
| status         | product_status    | DEFAULT 'draft'      |
| is_featured    | boolean           | DEFAULT false        |
| created_at     | timestamptz       | DEFAULT now()        |
| updated_at     | timestamptz       | DEFAULT now()        |

### CHECK shartlar:

1. `price > 0`
2. `discount_price IS NULL OR discount_price < price`
3. `stock_quantity >= 0`

---

# 2-BOSQICH — SELECT

---

# SELECT TASKLAR — `users`

1. Barcha userlarni barcha ustunlari bilan chiqaring.
2. Faqat `id`, `username`, `email` ustunlarini chiqaring.
3. Faqat `status = 'active'` bo‘lgan userlarni chiqaring.
4. `is_verified = true` bo‘lgan userlarni chiqaring.
5. `username = 'john123'` bo‘lgan userni toping.
6. So‘nggi qo‘shilgan 10 ta userni chiqaring (`ORDER BY created_at DESC LIMIT 10`).
7. `last_login_at IS NOT NULL` bo‘lgan userlarni chiqaring.
8. `birth_date IS NOT NULL` bo‘lgan userlarni chiqaring.
9. Oxirgi 7 kun ichida login qilgan va `status = 'active'` bo‘lgan userlarni `created_at` bo‘yicha kamayish tartibida chiqaring.
10. `created_at` sanasi `2023-01-01` va `2023-12-31` oralig‘ida (`BETWEEN`) bo‘lgan userlarni chiqaring.
11. `role IN ('admin', 'manager')` bo‘lgan userlarni chiqaring.
12. `email` domeni `gmail.com` bo‘lgan userlarni chiqaring (`LIKE` orqali).
13. `username` kichik-katta harfdan qat’i nazar `ali` bilan boshlanadigan userlarni chiqaring (`ILIKE`).
14. Eng oxirgi 20 ta userni chiqaring, keyingi 20 tasini chiqarish uchun `OFFSET 20` ishlating.
15. `status = 'active'` bo‘lgan userlarni `last_name` bo‘yicha A–Z tartibida chiqaring.
16. `created_at BETWEEN now() - interval '30 days' AND now()` bo‘lgan userlarni `ORDER BY created_at DESC LIMIT 15` bilan chiqaring.

---

# SELECT TASKLAR — `products`

1. Barcha productlarni chiqaring.
2. `status = 'active'` bo‘lgan productlarni chiqaring.
3. `stock_quantity > 0` bo‘lgan productlarni chiqaring.
4. `discount_price IS NOT NULL` bo‘lgan productlarni chiqaring.
5. Eng qimmat 5 ta productni chiqaring.
6. `price > 100` bo‘lgan productlarni chiqaring.
7. `name ILIKE '%pro%'` shartiga mos productlarni chiqaring.
8. `status = 'active'`, `stock_quantity > 0` va `price > 500` bo‘lgan productlarni `price` bo‘yicha kamayish tartibida chiqaring.
9. `price BETWEEN 100 AND 500` bo‘lgan productlarni chiqaring.
10. `status IN ('active', 'inactive')` bo‘lgan productlarni chiqaring.
11. `name LIKE 'Pro%'` bo‘lgan productlarni chiqaring.
12. `name ILIKE '%max%'` bo‘lgan productlarni chiqaring.
13. Eng qimmat 10 ta productni chiqaring va keyingi 10 tasini `OFFSET 10` bilan ko‘rsating.
14. `price BETWEEN 200 AND 1000` va `stock_quantity > 0` bo‘lgan productlarni `price ASC` tartibida chiqaring.
15. `created_at` bo‘yicha 3-sahifadagi productlarni chiqaring (har sahifa 25 ta yozuv).

---

# 3-BOSQICH — UPDATE

---

# UPDATE TASKLAR — `users`

1. `username = 'john123'` bo‘lgan userning `status`ini `'active'` ga o‘zgartiring.
2. `email = 'user@example.com'` bo‘lgan userni verified qiling va `updated_at = now()` qiling.
3. `id = 10` bo‘lgan userning `last_login_at` ustunini `now()` ga yangilang.
4. `login_attempts >= 5` bo‘lgan userlarning `status`ini `'blocked'` qiling.
5. `username = 'ali'` bo‘lgan userning `phone` raqamini yangilang.
6. `status = 'blocked'` va `login_attempts = 0` bo‘lgan userlarni `'active'` ga qaytaring va `updated_at` ni `now()` ga yangilang.
7. `created_at BETWEEN '2023-01-01' AND '2023-06-30'` bo‘lgan userlarning `status`ini `'inactive'` ga o‘zgartiring.
8. `role IN ('admin', 'manager')` bo‘lgan userlarning `is_verified` qiymatini `true` qiling.
9. `email LIKE '%@gmail.com'` bo‘lgan userlarning `login_attempts`ini 0 ga tushiring.
10. `username ILIKE 'test%'` bo‘lgan userlarning `status`ini `'blocked'` qiling.
11. Eng oxirgi 5 ta userning `is_verified` qiymatini `true` qiling (`ORDER BY created_at DESC LIMIT 5`).
12. `status = 'pending'` bo‘lgan userlardan faqat 10 tasining `status`ini `'active'` ga o‘zgartiring (`LIMIT` ishlatib).

---

# UPDATE TASKLAR — `products`

1. `slug = 'iphone-15'` bo‘lgan productni `active` qiling.
2. `id = 5` bo‘lgan productning `price`ini yangilang.
3. `id = 10` bo‘lgan productga `discount_price = 900` qo‘ying.
4. `id = 3` bo‘lgan productning `stock_quantity`ini 1 taga kamaytiring.
5. `price > 1000` bo‘lgan productlarni `is_featured = true` qiling.
6. `status = 'active'` va `stock_quantity = 0` bo‘lgan productlarni avtomatik ravishda `status = 'inactive'` ga o‘zgartiring.
7. `price BETWEEN 100 AND 300` bo‘lgan productlarga `discount_price = price * 0.9` qo‘llang.
8. `status IN ('inactive', 'draft')` bo‘lgan productlarni `archived` qiling.
9. `name ILIKE '%old%'` bo‘lgan productlarning `status`ini `'inactive'` ga o‘zgartiring.
10. `created_at BETWEEN '2022-01-01' AND '2022-12-31'` bo‘lgan productlarning `is_featured` qiymatini `false` qiling.
11. Eng qimmat 3 ta productning `discount_price`ini `price * 0.8` qiling (`ORDER BY price DESC LIMIT 3`).
12. `stock_quantity BETWEEN 1 AND 5` bo‘lgan productlarning `status`ini `'inactive'` qiling.

---

# 4-BOSQICH — DELETE

---

# DELETE TASKLAR — `users`

1. `username = 'temp_user'` bo‘lgan userni o‘chiring.
2. `last_login_at IS NULL` bo‘lgan userlarni o‘chiring.
3. `status = 'pending'` bo‘lgan userlarni o‘chiring.
4. `birth_date IS NULL` bo‘lgan userlarni o‘chiring.
5. `created_at < '2022-01-01'` bo‘lgan userlarni o‘chiring.
6. `status = 'blocked'` va `login_attempts >= 10` bo‘lgan userlarni o‘chiring.
7. `created_at BETWEEN '2020-01-01' AND '2020-12-31'` bo‘lgan userlarni o‘chiring.
8. `role IN ('customer')` va `status = 'inactive'` bo‘lgan userlarni o‘chiring.
9. `email LIKE '%@test.com'` bo‘lgan userlarni o‘chiring.
10. `username ILIKE 'temp%'` bo‘lgan userlarni o‘chiring.
11. Eng eski 5 ta userni o‘chiring (`ORDER BY created_at ASC LIMIT 5`).
12. `login_attempts BETWEEN 5 AND 10` va `status = 'blocked'` bo‘lgan userlarni o‘chiring.

---

# DELETE TASKLAR — `products`

1. `status = 'draft'` bo‘lgan productlarni o‘chiring.
2. `stock_quantity = 0` bo‘lgan productlarni o‘chiring.
3. `discount_price IS NULL` bo‘lgan productlarni o‘chiring.
4. `slug = 'old-product'` bo‘lgan productni o‘chiring.
5. `created_at < '2021-01-01'` bo‘lgan productlarni o‘chiring.
6. `status = 'inactive'` va `stock_quantity = 0` bo‘lgan barcha productlarni o‘chiring.
7. `price BETWEEN 50 AND 100` bo‘lgan productlarni o‘chiring.
8. `status IN ('inactive', 'archived')` va `stock_quantity = 0` bo‘lgan productlarni o‘chiring.
9. `name LIKE 'Test%'` bo‘lgan productlarni o‘chiring.
10. `name ILIKE '%demo%'` bo‘lgan productlarni o‘chiring.
11. Eng arzon 3 ta productni o‘chiring (`ORDER BY price ASC LIMIT 3`).
12. `created_at BETWEEN '2019-01-01' AND '2019-12-31'` bo‘lgan productlarni o‘chiring.
