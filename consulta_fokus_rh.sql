-- Selecionar os 5 maiores salários da empresa FOKUS --
SELECT * fROM HistoricoEmprego 
WHERE datatermino IS NULL
ORDER BY salario DESC
limit 5;

-- Filtrar os cursos com nome "O poder" na tabela treinamento --
SELECT curso from Treinamento
WHERE curso LIKE 'O poder%';

-- Filtrar professores que não estão mais trabalhando --
SELECT * FROM HistoricoEmprego
WHERE cargo = 'Professor' AND 
datatermino NOTNULL;

-- Achar profissionais dermatologistas ou oftalmologistas sem importar se estão trabalhando ou não --
SELECT * FROM HistoricoEmprego
WHERE cargo = 'Dermatologista' OR cargo = 'Oftalmologista';

-- Otimização da busca de diferentes colaboradores pelo IN --
SELECT * fROM HistoricoEmprego
WHERE cargo IN ('Oftalmologista', 'Dermatologista', 'Professor');

-- Apresentar todos os cargos exceto Oftalmologista, Dermatologista e Professor --
SELECT * fROM HistoricoEmprego
WHERE cargo NOT IN ('Oftalmologista', 'Dermatologista', 'Professor');

-- Encontrar dois cursos da tabela de treinamento com apenas o começo dos nomes --
SELECT * from Treinamento
WHERE (curso Like 'O direito%' and instituicao = 'da Rocha') 
OR (curso LIKE 'O conforto%' AND instituicao = 'das Neves'); 

-- Descobrindo o mês de maior faturamente da história da empresa -- 
SELECT mes, MAX(faturamento_bruto) FROM faturamento;

-- Descobrindo o mês de menor faturamente da história da empresa -- 
SELECT mes, MIN(faturamento_bruto) FROM faturamento;

-- Soma dos novos clientes de 2023 --
SELECT SUM(numero_novos_clientes) as 'Novos clientes 2023' FROM faturamento
WHERE mes LIKE '%2023';

-- Descobrindo a média do lucro da empresa --
SELECt AVG(lucro_liquido) FROM faturamento;

-- Descobrindo a média das despesas da empresa --
SELECt AVG(despesas) FROM faturamento;

--Verificar a quantidade de pessoas desempregadas --
SELECT COUNT(*) FROM HistoricoEmprego
WHERE datatermino NOTNULL;

--Saber quantas pessoas estão de férias --
SELECT COUNT(*) FROM Licencas 
WHERE tipolicenca = 'férias';

--Para identificar os tipos de parentescos nos trabalhadores --
SELECT parentesco FROM Dependentes
GROUP BY parentesco;

--Para identificar a quantidade de parentescos nos trabalhadores --
SELECT parentesco, COUNT(*) FROM Dependentes
GROUP BY parentesco;

--Identificar quais são as instituições com os cursos mais procurados --
SELECT instituicao, COUNT (curso) FROM Treinamento
GROUP BY instituicao
HAVING COUNT (curso) > 2;

-- Saber quais são as profissões que mais são procuradas ==
SELECT cargo, COUNT (*) qtd 
FROM HistoricoEmprego
GROUP BY cargo
HAVING qtd >= 2;

--Saber se os campos de CPF estão preenchidos com 11 dígitos --
SELECT nome, LENGTH(cpf) qtd
FROM Colaboradores
WHERE qtd = 11;

-- Verificar se todos os colaboradores estão sendo contados na busca pelo CPF
SELECT COUNT(*), LENGTH(cpf) qtd
FROM Colaboradores
WHERE qtd = 11;

-- Ver os dados de uma maneira mais dinâmica, com textos formulados
-- Concatenação de campos e texto
SELECT ('A pessoa colaboradora' ||  nome || ' de CPF ' || cpf || 'possui o seguinte endereço: ' || endereco) 
		As texto FROM Colaboradores;

-- transformar todas as letras em maiúsculas ou minúsculas
SELECT UPPER('A pessoa colaboradora' ||  nome || ' de CPF ' || cpf || 'possui o seguinte endereço: ' || endereco) 
		As texto FROM Colaboradores;
-- ou:
SELECT LOWER('A pessoa colaboradora' ||  nome || ' de CPF ' || cpf || 'possui o seguinte endereço: ' || endereco) 
		As texto FROM Colaboradores;
        
-- Ver a data de início da liçenca das pessoas colaboradoras no formato ano e mês:
SELECT * FROM Licencas;
SELECT id_colaborador, STRFTIME('%Y/%m', datainicio) FROM Licencas;
                            
-- Qual o intervalo de tempo cada pessoa colaboradora ficou com contrato registrado na base de dados:
SELECT id_colaborador, JULIANDAY (datatermino) - JULIANDAY (datacontratacao)
FROM HistoricoEmprego
Where datatermino NOTNULL;

-- Ver a média do faturamento bruto e com casas décimais
SELECT AVG (faturamento_bruto), ROUND (AVG(faturamento_bruto),2) From faturamento;

-- Redondamento para cima
SELECT CEIL(faturamento_bruto), CEIL(despesas) FROM faturamento;

-- Arredondamento para baixo
SELECT CEIL(faturamento_bruto), FLOOR(despesas) FROM faturamento;

-Função de conversão - Ver a coluna do faturamento bruto com o texto
SELECT ('O Faturamento bruto médio foi de:' || CAST(ROUND(AVG(faturamento_bruto),2) AS TEXT)) FROM faturamento;

-- Criando classificações e condições de acordo com uma categoria:
SELECT id_colaborador, cargo, salario,
CASE
WHEN salario < 3000 THEN 'Baixo'
WHEN salario BETWEEN 3000 and 6000 THEN 'Médio'
ELSE 'Alto'
END as categoria_salario 
FROM HistoricoEmprego;

-- Mudar o nome de uma tabela de dados:
ALTER TABLE HistoricoEmprego RENAME TO CargosColaboradores;