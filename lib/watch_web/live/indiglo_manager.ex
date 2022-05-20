defmodule WatchWeb.IndigloManager do
  use GenServer

  def init(ui) do
    :gproc.reg({:p, :l, :ui_event})
    {:ok, %{ui_pid: ui, st: IndigloOff}}
  end

  def handle_info(:"top-right", %{ui_pid: ui, st: IndigloOff} = state) do
    GenServer.cast(ui, :set_indiglo)
    {:noreply, state |> Map.put(:st, IndigloOn)}
  end

  def handle_info(:"top-right", %{ui_pid: ui, st: IndigloOn} = state) do
    GenServer.cast(ui, :unset_indiglo)
    {:noreply, state |> Map.put(:st, IndigloOff)}
  end


  def handle_info(_event, state) do
    {:noreply, state}
  end
end
