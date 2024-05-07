defmodule EntradaSaidaTest do
	use ExUnit.Case
	doctest EntradaSaida
	@registro1 %{banco: "001", convenio: "0500940144816060680935031", dataVencimento: "21/08/2032", moeda: "9", valor: "1,00"}
	@registro2 %{banco: "002", convenio: "0500940144816060680935031", dataVencimento: "22/08/2032", moeda: "8", valor: "2,00"}
	@codigo "00193373700000001000500940144816060680935031"
	
	test "es.lerRegistros" do
	{tempo_em_microssegundos, _} = :timer.tc(fn ->
			assert EntradaSaida.lerRegistros("test/input_test.txt") == [@registro1]
			assert EntradaSaida.lerRegistros("test/input_test2.txt") == [@registro1, @registro2]
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("es.lerRegistros: #{tempo_em_milissegundos} ms") 
	end

	test "es.lerCodigos" do
	{tempo_em_microssegundos, _} = :timer.tc(fn ->
			assert EntradaSaida.lerCodigos("test/input_codigos_test.txt") == [@codigo]
			assert EntradaSaida.lerCodigos("test/input_codigos2_test.txt") == [@codigo, @codigo]
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("es.lerCodigos: #{tempo_em_milissegundos} ms") 
	end

end
