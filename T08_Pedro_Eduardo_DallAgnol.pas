Program T08_Pedro_Eduardo_Dall_Agnol ;
// FEITO POR Pedro Eduardo Dall' Agnol GRR-20240844

USES TARDENOITE;

VAR

arq																									: File Of REGIS;
reg																									: REGIS;
notas																								: Text;
Disciplina																					: Array [1..6] Of string[30];
media																								: Array [1..6] Of Integer;
vet																									: VETOR;
posiv,ii,tot,tc,tt,Hi,err,A,B,C											: Integer;
nota																								: String[28];
numa,num																						: String[4];

Begin
  
  TextBackground(white);  { Mudar a cor de fundo para branco. }
  TextColor(black);       { Mudar a cor das letras para preto. }
  
  ClrScr;
  
  Writeln('    --- = ---');
  Writeln;
  Writeln('Start ');
  Writeln;                  // Inicio do programa T08 ------>
  
  
  // Ewscreve na tela os nomes das disciplinas.
  
  DISCIPLINA[1] := 'L.E.M.                      ';
  DISCIPLINA[2] := 'Matemática                  ';
  DISCIPLINA[3] := 'Lógica                      ';
  DISCIPLINA[4] := 'Conhecimento espec. do cargo';
  DISCIPLINA[5] := 'Informática                 ';
  DISCIPLINA[6] := 'Atualidades                 ';
  
  // Associar as variáveis de arquivo aos nomes de arquivo.
  
  Assign(arq, 'cand.ind');
  Assign(notas, 'notas.txt');
  
  // Abre os arquivos  para a leitura e modificação.
  
  Reset(arq);
  Reset(notas);
  
  // Lê todos os registros do arquivo de candidatos.
  
  Repeat
    Read(arq, reg);
    ii := a + 1;
    vet[ii].pf := a;
    Str(reg.num, num);
    tc := Length(num);
    For b := 1 To 4 - tc Do
    Insert('0', num, 1);  // Garantir que tenha 4 caracteres, padronizar informações.
    vet[ii].cc := num;
    a := a + 1;
  Until(EOF(arq));  			// Continua até o EOF.
  
  tot := ii;
Writeln('Lendo as notas...');
ordem(vet, ii); 				 // Ordena o vetor.

// Processa arq notas.

Repeat
  tt := tt + 1;
  Readln(notas, nota);
  numa := Copy(nota, 1, 4);
  pebin1(vet, numa, tot, posiv);  // Encontra a posição do candidato no vetor ordenado.
  
  Seek(arq, vet[posiv].pf);
  Read(arq, reg);
  
  // Extrai as notas de cada disciplina.
  
  // Nota Disciplina 01
  num := Copy(nota, 5, 8);
  Val(num, Hi, err);
  media[1] := Hi + media[1];
  reg.notas[1] := Hi;
  Hi := 0;
  // Nota Disciplina 02
  num := Copy(nota, 9, 12);
  Val(num, Hi, err);
  media[2] := Hi + media[2];
  reg.notas[2] := Hi;
  Hi := 0;
  // Nota Disciplina 03
  num := Copy(nota, 13, 16);
  Val(num, Hi, err);
  media[3] := Hi + media[3];
  reg.notas[3] := Hi;
  Hi := 0;
  // Nota Disciplina 04
  num := Copy(nota, 17, 20);
  Val(num, Hi, err);
  media[4] := Hi + media[4];
  reg.notas[4] := Hi;
  Hi := 0;                           // Nota Disciplina 05
  
  num := Copy(nota, 21, 24);
  Val(num, Hi, err);
  media[5] := Hi + media[5];
  reg.notas[5] := Hi;
  Hi := 0;
  // Nota Disciplina 06
  num := Copy(nota, 25, 28);
  Val(num, Hi, err);
  media[6] := Hi + media[6];
  reg.notas[6] := Hi;
  Hi := 0;
  
  // Calcula a soma total das notas do candidato.
  
  reg.som := 0;
  For c := 1 To 6 Do
  reg.som := reg.notas[c] + reg.som;
  
  // Atualiza o registro no arquivo.
  
  Seek(ARQ, VET[POSIV].PF);
  Write(ARQ, REG);
  
Until EOF(notas);  // Continua até EOF.

Clrscr;
Writeln('DICIPLINA                                          MÉDIA GERAL');
Writeln;

// Exibe a média para cada disc.

For C := 1 To 6 Do
Writeln(DISCIPLINA[C], media[C] / tt:32);

// Greetings.

Writeln;
Writeln;
Writeln('Obrigado por testar meu código!!! ', #10, 'Até mais.');
Writeln;
Writeln;

// Encerra o programa, utilizando "TERMINE".

TERMINE;

Writeln;
Writeln;
Writeln('Finish ', #10, '    --- = ---');

// Fecha os arquivos.

Close(notas);
Close(ARQ);

End.