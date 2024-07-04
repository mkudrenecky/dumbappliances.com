defmodule Dumbappliances.Appliances do
  @moduledoc """
  The Appliances context.
  """

  import Ecto.Query, warn: false
  alias Dumbappliances.Repo

  alias Dumbappliances.Appliances.Appliance

  @doc """
  Returns the list of appliances.

  ## Examples

      iex> list_appliances()
      [%Appliance{}, ...]

  """
  def list_appliances do
    Repo.all(Appliance)
  end

  @doc """
  Gets a single appliance.

  Raises `Ecto.NoResultsError` if the Appliance does not exist.

  ## Examples

      iex> get_appliance!(123)
      %Appliance{}

      iex> get_appliance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appliance!(id), do: Repo.get!(Appliance, id)

  @doc """
  Creates a appliance.

  ## Examples

      iex> create_appliance(%{field: value})
      {:ok, %Appliance{}}

      iex> create_appliance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appliance(attrs \\ %{}) do
    %Appliance{}
    |> Appliance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a appliance.

  ## Examples

      iex> update_appliance(appliance, %{field: new_value})
      {:ok, %Appliance{}}

      iex> update_appliance(appliance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appliance(%Appliance{} = appliance, attrs) do
    appliance
    |> Appliance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a appliance.

  ## Examples

      iex> delete_appliance(appliance)
      {:ok, %Appliance{}}

      iex> delete_appliance(appliance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appliance(%Appliance{} = appliance) do
    Repo.delete(appliance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appliance changes.

  ## Examples

      iex> change_appliance(appliance)
      %Ecto.Changeset{data: %Appliance{}}

  """
  def change_appliance(%Appliance{} = appliance, attrs \\ %{}) do
    Appliance.changeset(appliance, attrs)
  end
end
