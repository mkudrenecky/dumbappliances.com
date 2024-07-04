defmodule Dumbappliances.AppliancesTest do
  use Dumbappliances.DataCase

  alias Dumbappliances.Appliances

  describe "appliances" do
    alias Dumbappliances.Appliances.Appliance

    import Dumbappliances.AppliancesFixtures

    @invalid_attrs %{name: nil, public: nil, category: nil, url: nil, brand: nil, contributor: nil}

    test "list_appliances/0 returns all appliances" do
      appliance = appliance_fixture()
      assert Appliances.list_appliances() == [appliance]
    end

    test "get_appliance!/1 returns the appliance with given id" do
      appliance = appliance_fixture()
      assert Appliances.get_appliance!(appliance.id) == appliance
    end

    test "create_appliance/1 with valid data creates a appliance" do
      valid_attrs = %{name: "some name", public: true, category: "some category", url: "some url", brand: "some brand", contributor: "some contributor"}

      assert {:ok, %Appliance{} = appliance} = Appliances.create_appliance(valid_attrs)
      assert appliance.name == "some name"
      assert appliance.public == true
      assert appliance.category == "some category"
      assert appliance.url == "some url"
      assert appliance.brand == "some brand"
      assert appliance.contributor == "some contributor"
    end

    test "create_appliance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appliances.create_appliance(@invalid_attrs)
    end

    test "update_appliance/2 with valid data updates the appliance" do
      appliance = appliance_fixture()
      update_attrs = %{name: "some updated name", public: false, category: "some updated category", url: "some updated url", brand: "some updated brand", contributor: "some updated contributor"}

      assert {:ok, %Appliance{} = appliance} = Appliances.update_appliance(appliance, update_attrs)
      assert appliance.name == "some updated name"
      assert appliance.public == false
      assert appliance.category == "some updated category"
      assert appliance.url == "some updated url"
      assert appliance.brand == "some updated brand"
      assert appliance.contributor == "some updated contributor"
    end

    test "update_appliance/2 with invalid data returns error changeset" do
      appliance = appliance_fixture()
      assert {:error, %Ecto.Changeset{}} = Appliances.update_appliance(appliance, @invalid_attrs)
      assert appliance == Appliances.get_appliance!(appliance.id)
    end

    test "delete_appliance/1 deletes the appliance" do
      appliance = appliance_fixture()
      assert {:ok, %Appliance{}} = Appliances.delete_appliance(appliance)
      assert_raise Ecto.NoResultsError, fn -> Appliances.get_appliance!(appliance.id) end
    end

    test "change_appliance/1 returns a appliance changeset" do
      appliance = appliance_fixture()
      assert %Ecto.Changeset{} = Appliances.change_appliance(appliance)
    end
  end
end
