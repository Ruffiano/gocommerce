-- name: CreateAddress :one
INSERT INTO addresses (
    user_id,
    name,
    phoneno,
    houseno,
    area,
    landmark,
    city,
    pincode,
    district,
    state,
    country,
    defaultadd
) VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
) RETURNING *;

-- name: GetAddressByID :one
SELECT * FROM addresses 
WHERE addressid = $1 LIMIT 1;

-- name: UpdateAddress :one
UPDATE addresses SET
    user_id = $1,
    name = $2,
    phoneno = $3,
    houseno = $4,
    area = $5,
    landmark = $6,
    city = $7,
    pincode = $8,
    district = $9,
    state = $10,
    country = $11,
    defaultadd = $12
WHERE addressid = $13 RETURNING *;

-- name: DeleteAddress :exec
DELETE FROM addresses WHERE addressid = $1;

-- name: ListAddresses :many
SELECT * FROM addresses;
