package db

import (
	"context"
	"database/sql"
	"testing"
	"time"

	"github.com/ruffiano/gocommerce/util"

	"github.com/stretchr/testify/require"
)

func createRandomAdmin(t *testing.T) Admin {
	hashedPassword, err := util.HashPassword(util.RandomString(6))
	require.NoError(t, err)

	arg := CreateAdminParams{
		FirstName:      util.RandomOwner(),
		LastName:       util.RandomOwner(),
		Email:          util.RandomEmail(),
		HashedPassword: hashedPassword,
		Phone:          util.RandomInt32(100000000, 999999999),
		IsAdmin:        true,
	}

	admin, err := testQueries.CreateAdmin(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, admin)

	require.Equal(t, arg.FirstName, admin.FirstName)
	require.Equal(t, arg.LastName, admin.LastName)
	require.Equal(t, arg.HashedPassword, admin.HashedPassword)
	require.Equal(t, arg.Email, admin.Email)
	require.Equal(t, arg.Phone, admin.Phone)
	require.Equal(t, arg.IsAdmin, admin.IsAdmin)

	require.NotZero(t, admin.CreatedAt)

	return admin
}

func TestCreateAdmin(t *testing.T) {
	createRandomAdmin(t)
}

func TestGetAdmin(t *testing.T) {
	admin1 := createRandomAdmin(t)
	admin2, err := testQueries.GetAdminByID(context.Background(), admin1.ID)
	require.NoError(t, err)
	require.NotEmpty(t, admin2)

	require.Equal(t, admin1.FirstName, admin2.FirstName)
	require.Equal(t, admin1.LastName, admin2.LastName)
	require.Equal(t, admin1.HashedPassword, admin2.HashedPassword)
	require.Equal(t, admin1.Email, admin2.Email)
	require.Equal(t, admin1.IsAdmin, admin2.IsAdmin)
	require.WithinDuration(t, admin1.CreatedAt, admin2.CreatedAt, time.Second)
}

func TestUpdateAdminOnlyFirstName(t *testing.T) {
	oldAdmin := createRandomAdmin(t)

	newFirstName := util.RandomOwner()
	updatedAdmin, err := testQueries.UpdateAdmin(context.Background(), UpdateAdminParams{
		ID: oldAdmin.ID,
		FirstName: sql.NullString{
			String: newFirstName,
			Valid:  true,
		},
	})

	require.NoError(t, err)
	require.NotEqual(t, oldAdmin.FirstName, updatedAdmin.FirstName)
	require.Equal(t, newFirstName, updatedAdmin.FirstName)
	require.Equal(t, oldAdmin.Email, updatedAdmin.Email)
	require.Equal(t, oldAdmin.HashedPassword, updatedAdmin.HashedPassword)
}

func TestUpdateAdminOnlyEmail(t *testing.T) {
	oldAdmin := createRandomAdmin(t)

	newEmail := util.RandomEmail()
	updatedAdmin, err := testQueries.UpdateAdmin(context.Background(), UpdateAdminParams{
		ID: oldAdmin.ID,
		Email: sql.NullString{
			String: newEmail,
			Valid:  true,
		},
	})

	require.NoError(t, err)
	require.NotEqual(t, oldAdmin.Email, updatedAdmin.Email)
	require.Equal(t, newEmail, updatedAdmin.Email)
	require.Equal(t, oldAdmin.FirstName, updatedAdmin.FirstName)
	require.Equal(t, oldAdmin.HashedPassword, updatedAdmin.HashedPassword)
}

func TestUpdateAdminOnlyPassword(t *testing.T) {
	oldAdmin := createRandomUser(t)

	newPassword := util.RandomString(6)
	newHashPassword, err := util.HashPassword(newPassword)
	require.NoError(t, err)

	updatedAdmin, err := testQueries.UpdateAdmin(context.Background(), UpdateAdminParams{
		ID: oldAdmin.ID,
		HashedPassword: sql.NullString{
			String: newHashPassword,
			Valid:  true,
		},
	})

	require.NoError(t, err)
	require.NotEqual(t, oldAdmin.HashedPassword, updatedAdmin.HashedPassword)
	require.Equal(t, newHashPassword, updatedAdmin.HashedPassword)
	require.NotEqual(t, oldAdmin.FirstName, updatedAdmin.FirstName)
	require.NotEqual(t, oldAdmin.Email, updatedAdmin.Email)
}

func TestUpdateAdminAllFields(t *testing.T) {
	oldAdmin := createRandomAdmin(t)

	newFirstName := util.RandomOwner()
	newEmail := util.RandomEmail()
	newPassword := util.RandomString(6)
	newHashPassword, err := util.HashPassword(newPassword)
	require.NoError(t, err)

	updatedAdmin, err := testQueries.UpdateAdmin(context.Background(), UpdateAdminParams{
		ID: oldAdmin.ID,
		FirstName: sql.NullString{
			String: newFirstName,
			Valid:  true,
		},
		Email: sql.NullString{
			String: newEmail,
			Valid:  true,
		},
		HashedPassword: sql.NullString{
			String: newHashPassword,
			Valid:  true,
		},
	})

	require.NoError(t, err)
	require.NotEqual(t, oldAdmin.HashedPassword, updatedAdmin.HashedPassword)
	require.Equal(t, newHashPassword, updatedAdmin.HashedPassword)

	require.NotEqual(t, oldAdmin.FirstName, updatedAdmin.FirstName)
	require.Equal(t, newFirstName, updatedAdmin.FirstName)

	require.NotEqual(t, oldAdmin.Email, updatedAdmin.Email)
	require.Equal(t, newEmail, updatedAdmin.Email)
}
