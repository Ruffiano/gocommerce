// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.19.1
// source: addresses.sql

package db

import (
	"context"
	"database/sql"
)

const createAddress = `-- name: CreateAddress :one
INSERT INTO addresses (
    userid,
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
) RETURNING addressid, userid, name, phoneno, houseno, area, landmark, city, pincode, district, state, country, defaultadd
`

type CreateAddressParams struct {
	Userid     sql.NullInt32 `json:"userid"`
	Name       string        `json:"name"`
	Phoneno    string        `json:"phoneno"`
	Houseno    string        `json:"houseno"`
	Area       string        `json:"area"`
	Landmark   string        `json:"landmark"`
	City       string        `json:"city"`
	Pincode    string        `json:"pincode"`
	District   string        `json:"district"`
	State      string        `json:"state"`
	Country    string        `json:"country"`
	Defaultadd sql.NullBool  `json:"defaultadd"`
}

func (q *Queries) CreateAddress(ctx context.Context, arg CreateAddressParams) (Address, error) {
	row := q.db.QueryRowContext(ctx, createAddress,
		arg.Userid,
		arg.Name,
		arg.Phoneno,
		arg.Houseno,
		arg.Area,
		arg.Landmark,
		arg.City,
		arg.Pincode,
		arg.District,
		arg.State,
		arg.Country,
		arg.Defaultadd,
	)
	var i Address
	err := row.Scan(
		&i.Addressid,
		&i.Userid,
		&i.Name,
		&i.Phoneno,
		&i.Houseno,
		&i.Area,
		&i.Landmark,
		&i.City,
		&i.Pincode,
		&i.District,
		&i.State,
		&i.Country,
		&i.Defaultadd,
	)
	return i, err
}

const deleteAddress = `-- name: DeleteAddress :exec
DELETE FROM addresses WHERE addressid = $1
`

func (q *Queries) DeleteAddress(ctx context.Context, addressid int32) error {
	_, err := q.db.ExecContext(ctx, deleteAddress, addressid)
	return err
}

const getAddressByID = `-- name: GetAddressByID :one
SELECT addressid, userid, name, phoneno, houseno, area, landmark, city, pincode, district, state, country, defaultadd FROM addresses 
WHERE addressid = $1 LIMIT 1
`

func (q *Queries) GetAddressByID(ctx context.Context, addressid int32) (Address, error) {
	row := q.db.QueryRowContext(ctx, getAddressByID, addressid)
	var i Address
	err := row.Scan(
		&i.Addressid,
		&i.Userid,
		&i.Name,
		&i.Phoneno,
		&i.Houseno,
		&i.Area,
		&i.Landmark,
		&i.City,
		&i.Pincode,
		&i.District,
		&i.State,
		&i.Country,
		&i.Defaultadd,
	)
	return i, err
}

const listAddresses = `-- name: ListAddresses :many
SELECT addressid, userid, name, phoneno, houseno, area, landmark, city, pincode, district, state, country, defaultadd FROM addresses
`

func (q *Queries) ListAddresses(ctx context.Context) ([]Address, error) {
	rows, err := q.db.QueryContext(ctx, listAddresses)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []Address{}
	for rows.Next() {
		var i Address
		if err := rows.Scan(
			&i.Addressid,
			&i.Userid,
			&i.Name,
			&i.Phoneno,
			&i.Houseno,
			&i.Area,
			&i.Landmark,
			&i.City,
			&i.Pincode,
			&i.District,
			&i.State,
			&i.Country,
			&i.Defaultadd,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const updateAddress = `-- name: UpdateAddress :one
UPDATE addresses SET
    userid = $1,
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
WHERE addressid = $13 RETURNING addressid, userid, name, phoneno, houseno, area, landmark, city, pincode, district, state, country, defaultadd
`

type UpdateAddressParams struct {
	Userid     sql.NullInt32 `json:"userid"`
	Name       string        `json:"name"`
	Phoneno    string        `json:"phoneno"`
	Houseno    string        `json:"houseno"`
	Area       string        `json:"area"`
	Landmark   string        `json:"landmark"`
	City       string        `json:"city"`
	Pincode    string        `json:"pincode"`
	District   string        `json:"district"`
	State      string        `json:"state"`
	Country    string        `json:"country"`
	Defaultadd sql.NullBool  `json:"defaultadd"`
	Addressid  int32         `json:"addressid"`
}

func (q *Queries) UpdateAddress(ctx context.Context, arg UpdateAddressParams) (Address, error) {
	row := q.db.QueryRowContext(ctx, updateAddress,
		arg.Userid,
		arg.Name,
		arg.Phoneno,
		arg.Houseno,
		arg.Area,
		arg.Landmark,
		arg.City,
		arg.Pincode,
		arg.District,
		arg.State,
		arg.Country,
		arg.Defaultadd,
		arg.Addressid,
	)
	var i Address
	err := row.Scan(
		&i.Addressid,
		&i.Userid,
		&i.Name,
		&i.Phoneno,
		&i.Houseno,
		&i.Area,
		&i.Landmark,
		&i.City,
		&i.Pincode,
		&i.District,
		&i.State,
		&i.Country,
		&i.Defaultadd,
	)
	return i, err
}