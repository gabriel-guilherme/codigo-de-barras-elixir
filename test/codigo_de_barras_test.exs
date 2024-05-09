defmodule FatorVencimentoTest do
  use ExUnit.Case
  doctest FatorVencimento

  test "fv.fatorVencimento" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert FatorVencimento.fatorVencimento("03-07-2000") == "1000"
        assert FatorVencimento.fatorVencimento("04/07/2000") == "1001"
        assert FatorVencimento.fatorVencimento("05-07-2000") == "1002"
        assert FatorVencimento.fatorVencimento("01/05/2002") == "1667"
        assert FatorVencimento.fatorVencimento("17/11/2010") == "4789"
        assert FatorVencimento.fatorVencimento("21/02/2025") == "9999"
        assert FatorVencimento.fatorVencimento("22/02/2025") == "1000"
        assert FatorVencimento.fatorVencimento("23-02-2025") == "1001"
        assert FatorVencimento.fatorVencimento("29-04-2024") == "9701"
        assert FatorVencimento.fatorVencimento("10-05-2024") == "9712"
        assert FatorVencimento.fatorVencimento("19-12-2048") == "9701"
        assert FatorVencimento.fatorVencimento("14-10-2049") == "1000"
        assert FatorVencimento.fatorVencimento("15-10-2049") == "1001"
        assert FatorVencimento.fatorVencimento("21/08/2032") == "3737"
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("fv.fatorVencimento: #{tempo_em_milissegundos} ms")
  end

  test "fv.decode" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert FatorVencimento.decode("9999") == "21/02/2025"
        assert FatorVencimento.decode("1000") == "22/02/2025"
        assert FatorVencimento.decode("1001") == "23/02/2025"
        assert FatorVencimento.decode("9701") == "19/12/2048"
        assert FatorVencimento.decode("9704") == "22/12/2048"
        assert FatorVencimento.decode("9709") == "27/12/2048"
        assert FatorVencimento.decode("3737") == "21/08/2032"
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("fv.decode: #{tempo_em_milissegundos} ms")
  end
end

defmodule CodigoDeBarrasTest do
  use ExUnit.Case
  doctest CodigoDeBarras

  @codigo_semdv [
    0,
    0,
    1,
    9,
    3,
    7,
    3,
    7,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    5,
    0,
    0,
    9,
    4,
    0,
    1,
    4,
    4,
    8,
    1,
    6,
    0,
    6,
    0,
    6,
    8,
    0,
    9,
    3,
    5,
    0,
    3,
    1
  ]
  @codigo [
    0,
    0,
    1,
    9,
    3,
    3,
    7,
    3,
    7,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    5,
    0,
    0,
    9,
    4,
    0,
    1,
    4,
    4,
    8,
    1,
    6,
    0,
    6,
    0,
    6,
    8,
    0,
    9,
    3,
    5,
    0,
    3,
    1
  ]
  @codigo_string "00193373700000001000500940144816060680935031"
  @registro %{
    banco: "001",
    convenio: "0500940144816060680935031",
    dataVencimento: "21/08/2032",
    moeda: "9",
    valor: "1,00"
  }
  @linhadigitavel_string "00190.50095 40144.816069 06809.350314 3 37370000000100"
  @codigo_decodificado %{
    boleto: %{
      banco: "001",
      dataVencimento: "21/08/2032",
      moeda: "9",
      convenio: "0500940144816060680935031",
      valor: "1,00"
    },
    linhaDigitavel: "00190.50095 40144.816069 06809.350314 3 37370000000100",
    codigoDeBarras: "00193373700000001000500940144816060680935031"
  }

  test "cb.dvCodigoBarras" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert CodigoDeBarras.dvCodigoBarras(@codigo_semdv) == 3
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("cb.dvCodigoBarras: #{tempo_em_milissegundos} ms")
  end

  test "cb.gerar" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert CodigoDeBarras.gerar(@registro) == @codigo
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("cb.gerar: #{tempo_em_milissegundos} ms")
  end

  test "cb.toString" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert CodigoDeBarras.toString(@codigo) == @codigo_string
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("cb.toString: #{tempo_em_milissegundos} ms")
  end

  test "cb.gerarLinhaDigitavel" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert CodigoDeBarras.gerarLinhaDigitavel(@codigo_string) == @linhadigitavel_string
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("cb.gerarLinhaDigitavel: #{tempo_em_milissegundos} ms")
  end

  test "cb.decodificar" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert CodigoDeBarras.decodificar(@codigo_string) == @codigo_decodificado
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("cb.decodificar: #{tempo_em_milissegundos} ms")
  end

  test "cb.stringParaMoeda" do
    {tempo_em_microssegundos, _} =
      :timer.tc(fn ->
        assert CodigoDeBarras.stringParaMoeda("0000000100") == "1,00"
        assert CodigoDeBarras.stringParaMoeda("000000010") == "0,10"
        assert CodigoDeBarras.stringParaMoeda("00000001") == "0,01"
        assert CodigoDeBarras.stringParaMoeda("00000001000") == "10,00"
      end)

    tempo_em_milissegundos = tempo_em_microssegundos / 1000
    IO.puts("cb.stringParaMoeda: #{tempo_em_milissegundos} ms")
  end
end
