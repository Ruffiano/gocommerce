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
UPDATE users
SET
  first_name = COALESCE(sqlc.narg(first_name), first_name),
  last_name = COALESCE(sqlc.narg(last_name), last_name),
  hashed_password = COALESCE(sqlc.narg(hashed_password), hashed_password),
  phone = COALESCE(sqlc.narg(phone), phone),
  email = COALESCE(sqlc.narg(email), email),
  otp = COALESCE(sqlc.narg(otp), otp),
  is_email_verified = COALESCE(sqlc.narg(is_email_verified), is_email_verified),
  password_changed_at = COALESCE(sqlc.narg(password_changed_at), password_changed_at),
  updated_at = COALESCE(sqlc.narg(updated_at), updated_at)
WHERE
  id = sqlc.arg(id)
RETURNING *;



-- name: DeleteUser :exec
DELETE FROM users WHERE id $1;

-- name: ListUsers :many
SELECT * FROM users;