defmodule DumbappliancesWeb.ApplianceLive.FormComponent do
  use DumbappliancesWeb, :live_component

  alias Dumbappliances.Appliances

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage appliance records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="appliance-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:brand]} type="text" label="Brand" />
        <.input field={@form[:category]} type="text" label="Category" />
        <.input field={@form[:contributor]} type="text" label="Contributor" />
        <.input field={@form[:public]} type="checkbox" label="Public" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Appliance</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{appliance: appliance} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Appliances.change_appliance(appliance))
     end)}
  end

  @impl true
  def handle_event("validate", %{"appliance" => appliance_params}, socket) do
    changeset = Appliances.change_appliance(socket.assigns.appliance, appliance_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"appliance" => appliance_params}, socket) do
    save_appliance(socket, socket.assigns.action, appliance_params)
  end

  defp save_appliance(socket, :edit, appliance_params) do
    case Appliances.update_appliance(socket.assigns.appliance, appliance_params) do
      {:ok, appliance} ->
        notify_parent({:saved, appliance})

        {:noreply,
         socket
         |> put_flash(:info, "Appliance updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_appliance(socket, :new, appliance_params) do
    case Appliances.create_appliance(appliance_params) do
      {:ok, appliance} ->
        notify_parent({:saved, appliance})

        {:noreply,
         socket
         |> put_flash(:info, "Appliance created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
