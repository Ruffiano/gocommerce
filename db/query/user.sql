-- name: CreateUser
INSERT INTO users (
    first_name,
    last_name,
    email,
    password,
    phone,
    is_admin,
    otp,
    is_blocked,
    created_at,
    updated_at
) VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
) RETURNING *;

-- name: GetUserByID
SELECT * FROM users WHERE id = $1;

-- name: UpdateUser
UPDATE user SET
    first_name = $1,
    last_name = $2,
    email = $3,
    password = $4,
    phone = $5,
    is_admin = $6,
    otp 