-- name: CreateUser :one
INSERT INTO users (
    first_name,
    last_name,
    email,
    hashed_password,
    phone,
    otp
) VALUES (
    $1, $2, $3, $4, $5, $6
) RETURNING *;

-- name: GetUserByID :one
SELECT * FROM users 
WHERE id = $1 LIMIT 1;

-- name: UpdateUser :one
UPDATE users SET
    first_name = $1,
    last_name = $2,
    hashed_password = $3,
    phone = $4,
    otp = $5,
    password_changed_at = $6,
    updated_at = $7
WHERE id = $8 RETURNING *;

-- name: DeleteUser :exec
DELETE FROM users WHERE id $1;

-- name: ListUsers :many
SELECT * FROM users;