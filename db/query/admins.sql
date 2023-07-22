-- name: CreateAdmin :one
INSERT INTO admins (
    first_name,
    last_name,
    email,
    hashed_password,
    phone,
    is_admin
) VALUES (
    $1, $2, $3, $4, $5, $6
) RETURNING *;

-- name: GetAdminByID :one
SELECT * FROM admins 
WHERE id = $1 LIMIT 1;

-- name: UpdateAdmin :one
UPDATE admins
SET
    first_name = COALESCE(sqlc.narg(first_name), first_name),
    last_name = COALESCE(sqlc.narg(last_name), last_name),
    email = COALESCE(sqlc.narg(email), email),  
    hashed_password = COALESCE(sqlc.narg(hashed_password), hashed_password),
    phone = COALESCE(sqlc.narg(phone), phone),
    is_admin = COALESCE(sqlc.narg(is_admin), is_admin)
WHERE
    id = sqlc.arg(id)
RETURNING *;

-- name: DeleteAdmin :exec
DELETE FROM admins WHERE id = $1;

-- name: ListAdmins :many
SELECT * FROM admins;
