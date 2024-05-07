defmodule LinhaDigitavelTest do
	use ExUnit.Case
	doctest LinhaDigitavel

	@codigodebarras [0,0,1,9,3,3,7,3,7,0,0,0,0,0,0,0,1,0,0,0,5,0,0,9,4,0,1,4,4,8,1,6,0,6,0,6,8,0,9,3,5,0,3,1]
	@linhadigitavel [0,0,1,9,0,5,0,0,9,5,4,0,1,4,4,8,1,6,0,6,9,0,6,8,0,9,3,5,0,3,1,4,3,3,7,3,7,0,0,0,0,0,0,0,1,0,0]
	@linhadigitavel_semdv [0,0,1,9,0,5,0,0,9,4,0,1,4,4,8,1,6,0,6,0,6,8,0,9,3,5,0,3,1,3,3,7,3,7,0,0,0,0,0,0,0,1,0,0]
	@linhadigitavel_string "00190.50095 40144.816069 06809.350314 3 37370000000100"
	
	test "ld.dvBloco" do
	{tempo_em_microssegundos, _} = :timer.tc(fn ->
			assert LinhaDigitavel.dvBloco([0,0,1,9,0,5,0,0,9]) == 5 
			assert LinhaDigitavel.dvBloco([4,0,1,4,4,8,1,6,0,6]) == 9
			assert LinhaDigitavel.dvBloco([0,6,8,0,9,3,5,0,3,1]) == 4
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("ld.dvBloco: #{tempo_em_milissegundos} ms") 
	end

	test "ld.ordenar" do
		{tempo_em_microssegundos, _} = :timer.tc(fn ->
				assert LinhaDigitavel.ordenar(@codigodebarras) == @linhadigitavel_semdv
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("ld.ordenar: #{tempo_em_milissegundos} ms")
	end

	test "ld.inserirDvs" do
	{tempo_em_microssegundos, _} = :timer.tc(fn ->
			assert LinhaDigitavel.inserirDvs(@linhadigitavel_semdv) == @linhadigitavel
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("ld.inserirDvs: #{tempo_em_milissegundos} ms") 
	end

	test "ld.toString" do
	{tempo_em_microssegundos, _} = :timer.tc(fn ->
			assert LinhaDigitavel.toString(@linhadigitavel) == @linhadigitavel_string
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("ld.toString: #{tempo_em_milissegundos} ms") 
	end

	test "ld.gerar" do
	{tempo_em_microssegundos, _} = :timer.tc(fn ->
			assert LinhaDigitavel.gerar(@codigodebarras) == @linhadigitavel_string
		end)
		tempo_em_milissegundos = tempo_em_microssegundos / 1000
		IO.puts("ld.gerar: #{tempo_em_milissegundos} ms") 
	end

end