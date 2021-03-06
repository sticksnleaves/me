defmodule Hora.Changeset do
  @moduledoc """
  Utility functions for working with Ecto.Changeset.
  """

  import Ecto.Changeset

  @doc """
  Modifies the changeset by adding a secure password if a change to the password
  has been made.

  ### Example

  ```elixir
  changeset
  |> Hora.Changeset.put_secure_password(:password, :password_digest)
  ```
  """
  @spec put_secure_password(Ecto.Changeset.t, atom(), atom(), list()) :: Ecto.Changeset.t
  def put_secure_password(changeset, password_field_name, crypted_password_field_name, opts \\ []) do
    verify_ecto_dep()

    if password = get_change(changeset, password_field_name) do
      put_change(changeset, crypted_password_field_name, Hora.secure_password(password, opts))
    else
      changeset
    end
  end

  # private

  defp verify_ecto_dep do
    unless Code.ensure_loaded?(Ecto) do
      raise "You tried to use Hora.Changeset, but the Ecto module is not loaded. " <>
        "Please add ecto to your dependencies."
    end
  end
end
