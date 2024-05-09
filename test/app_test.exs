defmodule AppTest do
  use ExUnit.Case
  doctest App

  @registro1 %{
    banco: "001",
    convenio: "0500940144816060680935031",
    dataVencimento: "21/08/2032",
    moeda: "9",
    valor: "1,00"
  }
  @registro2 %{
    banco: "002",
    convenio: "0500940144816060680935031",
    dataVencimento: "22/08/2032",
    moeda: "8",
    valor: "2,00"
  }

  @mapa1 %{
    codigoDeBarras: "00193373700000001000500940144816060680935031",
    linhaDigitavel: "00190.50095 40144.816069 06809.350314 3 37370000000100",
    boleto: @registro1
  }
  @mapa2 %{
    codigoDeBarras: "00281373800000002000500940144816060680935031",
    linhaDigitavel: "00280.50094 40144.816069 06809.350314 1 37380000000200",
    boleto: @registro2
  }

  test "app.codificador" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert App.codificador("test/input_test.txt") == [@mapa1]
        assert App.codificador("test/input_test2.txt") == [@mapa1, @mapa2]
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("app.codificador: #{tempo_em_milissegundos} ms")
  end

  test "app.decodificador" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert App.decodificador("test/input_codigos_test.txt") == [@mapa1]
        assert App.decodificador("test/input_codigos2_test.txt") == [@mapa1, @mapa1]
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("app.decodificador: #{tempo_em_milissegundos} ms")
  end
end
