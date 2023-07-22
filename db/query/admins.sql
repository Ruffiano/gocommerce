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
UPDATE admins SET
    first_name = $1,
    last_name = $2,
    email = $3,
    hashed_password = $4,
    phone = $5,
    is_admin = $6
WHERE id = $7 RETURNING *;

-- name: DeleteAdmin :exec
DELETE FROM admins WHERE id = $1;

-- name: ListAdmins :many
SELECT * FROM admins;
