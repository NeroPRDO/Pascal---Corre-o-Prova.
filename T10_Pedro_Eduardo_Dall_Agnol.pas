Program T10_Pedro_Eduardo_Dall_Agnol;
// FEITO POR Pedro Eduardo Dall' Agnol GRR-20240844

USES TARDENOITE;

VAR

VET																									: VETOR											 ;
REG																									: REGIS											 ;
ARQ																									: File Of REGIS							 ;
vagas																								: Text											 ;
vaga																								: String[31]								 ;
CCL,car																							: String[2]									 ;
CLG,clc																							: String[4]									 ;
NOMdoCA																						  : Array[1..12] Of String[27] ;
A, B, C, PFI, CA, IND, TOT, OPT, Pagn								: Integer								     ;

BEGIN
  
  TextBackground(white);  { Mudar a cor de fundo para branco. }
  TextColor(black);       { Mudar a cor das letras para preto. }
  
  ClrScr;
  
  Writeln('    --- = ---');
  Writeln;
  Writeln('Start ');
  Writeln;                  // Inicio do programa T10 ------>
  
  ASSIGN(vagas, 'VAGAS.TXT');  // Associa o arquivo de texto 'VAGAS.TXT' à variável 'vagas'
  ASSIGN(ARQ, 'CAND.IND');     // Associa o arquivo de registros 'CAND.IND' à variável 'ARQ'
  RESET(vagas);
  RESET(ARQ);
  
  // Lê os nomes dos cursos do arquivo de texto
  
  For C:=1 To 12 Do
  Begin
    Readln(vagas, vaga);
    NOMdoCA[C] := copy(vaga, 3, 27);
  End;
  
  Repeat
    
    // Menu de opções
    
    Writeln('1- Por cargo, em ordem alfabética: ');
    Writeln('2- Todos, por ordem de classificação no cargo: ');
    Writeln('3- Todos, por ordem de classificação geral: ');
    Writeln;
    leia('Selecione uma das opções disponiveis ', OPT);
    
    If (OPT < 1) Or (OPT > 3) Then
    
    Writeln('Opção Ilegal...');
    
  Until (OPT >= 1) And (OPT <= 3);
  While (Not EOF(ARQ)) Do
  Begin
    
    READ(ARQ,REG);
    IND := IND + 1;
    VET[IND].PF := PFI;
    
    If OPT = 1 Then
    Begin
      If (REG.CCL <> 0) Then
      Begin
        
        STR(REG.CCL:2, CCL); // Converte o valor de CCL para string
        VET[IND].CC := CCL + REG.NOME;  // Concatena CCL com o nome
        
      END
      
      Else
      ind := ind-1;
    End;
    
    
    If OPT = 2 Then
    Begin
      
      STR(REG.clc:4, Clc);
      STR(REG.CAR:2, car);
      VET[IND].CC := car + clc;
      
    End;
    
    If OPT = 3 Then
    Begin
      
      STR(REG.CLG:4, CLG);
      VET[IND].CC := CLG;
      
    End ;
    PFI := PFI + 1;    // Incrementa PFI
    
  End;
  
  TOT := ind;      // Total de registros processados
  ORDEM(VET, TOT);
  TextColor(lightred);
  Writeln;
  Writeln('ENTER PARA CONTINUAR');
  TextColor(black);
  READLN;
  
  CLRSCR;  // Limpa a tela
  
  Pagn := 0;
  CA := 0;
  
  If OPT = 1 Then
  Begin
  TextColor(blue);
    Writeln('CURSO: ',NOMdoCA[REG.car],REG.car:5);
    	Writeln('');
    	TextColor(lightred);
    	Writeln('  ORD  NUM NOME                                NASCIMENTO   CCL');
    	TextColor(black);
    For B := 1 To TOT Do
    Begin
      
      SEEK(ARQ, VET[B].PF); // Posiciona o ponteiro de leitura no arquivo
      READ(ARQ, REG);   // Lê um registro do arquivo
      
      If (Pagn = 25) Or  ((CA <> REG.CAR) And (Pagn > 0)) Then
      
      Begin
      TextColor(lightred);
        Writeln;
        Write('ENTER PARA CONTINUAR');  
        Readln;
        CLRSCR;
        TextColor(blue);
        Writeln('CURSO: ', NOMdoCA[REG.car],REG.car:5);
        TextColor(lightred);
        Writeln;
        Writeln('  ORD  NUM NOME                                NASCIMENTO   CCL');
      TextColor(black);  
        Pagn := 0;
      End;
      
      Writeln(B:5, REG.NUM:5, ' ', REG.NOME, ' ', REG.DATA.DIA, '/', REG.DATA.MES, '/', REG.DATA.ANO, ' ', REG.CCL:3);
      Pagn := Pagn + 1;
      ca := reg.car;
      
    End;
  End;
  
  
  If ((OPT = 2) Or (OPT = 3)) Then
  Begin
    If OPT = 2 Then
    Writeln('CURSO: ',NOMdoCA[REG.car],REG.car:5)
    Else
    
    Writeln('   ORDEM DE CLASSIFICAÇÃO GERAL DOS APROVADOS');
    Writeln('');
    Writeln('  ORD  NUM N O M E                               SOM  N1  N2  N3  N4  N5  N6   NASCIMENTO CAR OBSERVARÇÃO');
    
    For B:=1 To TOT Do
    
    Begin
      
      SEEK(ARQ,VET[B].PF);  // Posiciona o ponteiro de leitura no arquivo
      READ(ARQ,REG);    // Lê um registro do arquivo
      
      If (Pagn = 25) Or ((OPT = 2) And (CA <> REG.CAR) And (Pagn > 0)) Then
      
      Begin
        TextColor(Lightred);
        Writeln;
        Write('ENTER PARA CONTINUAR');
        TextColor(Black);
        Readln;
        CLRSCR;  // Limpa a tela
        
        If OPT = 2 Then
          
        	Writeln('CURSO: ', NOMdoCA[REG.car], REG.car:5)
        
				Else
      
        Writeln('   ORDEM DE CLASSIFICAÇÃO GERAL DOS APROVADOS');
        Writeln;
        Writeln('  ORD  NUM N O M E                               SOM  N1  N2  N3  N4  N5  N6   NASCIMENTO CAR OBSERVARÇÃO');
        
        Pagn:=0;
        
      End;
      
      Write(B:5, REG.NUM:5, ' ', REG.NOME, ' ', REG.SOM:5);
      For A := 1 To 6 Do
      Write(REG.NOTAS[A]:4);
      Write('   ',REG.DATA.DIA,'/',REG.DATA.MES,'/',REG.DATA.ANO,REG.CAR:3);
      If reg.ccl <> 0 Then
      Writeln('  CLASS CAR-', REG.CCL)
      Else
      
      Writeln('');
      
      CA := REG.car;
      Pagn := Pagn+1;
      
    End;
  End;
  Writeln;
  Writeln('Fim da listagem, Enter para encerrar.');
  Readln;
  CLRSCR;
  Writeln('    --- = ---');
  Writeln;
  Writeln('Start ');
  Writeln;
  
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
  
END.
