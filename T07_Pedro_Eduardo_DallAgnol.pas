Program T07_Pedro_Eduardo_Dall_Agnol ;
//FEITO POR Pedro Eduardo Dall' Agnol GRR-20240844

USES TARDENOITE;

VAR ARQ                                       				: FILE OF REGIS;

REG																										: REGIS;
VET																					         	: VETOR;
Option, Pagina, A, B, IND, PFI, TC, TOT, c, caragr    : INTEGER;
num                                           				: string[4];
Cargo                                         				: string[2];
Name                                          				: string[35];
CargoADD                                      				: string [37];

Begin
  
  TextBackground(white); { Mudar a cor de fundo para branco. }
  TextColor(black);      { Mudar a cor das letras para preto. }
  
  ClrScr;
  
  Writeln('    --- = ---');
  Writeln;
  Writeln('Start ');
  Writeln;                  // Inicio do programa T07 ------>
  
  Assign(ARQ,'CAND.IND');   // Associa o arquivo 'CAND.IND' à variável ARQ
  Reset(ARQ);               // Abre o arquivo ARQ para leitura
  Repeat
    
    Writeln('Digite a opção relacionada a ordenação desejada:');
    Writeln;
    leia('1- Inscrição, 2- Alfabética, 3- CPF, 4- Cargo ', Option);    // Solicita ao usuário uma opção
    If (Option < 0) Or (Option > 4) Then
    Writeln('OPÇÃO INVÁLIDA!');
    
  Until (Option > 0) And (Option <= 4	);   // Repete até que a opção seja válida
  
  While (Not Eof(ARQ)) Do
  Begin
    Read(ARQ,REG);
    IND:= IND + 1;
    VET[IND].PF:=PFI;
    
    If Option = 1 Then                  // Se a opção for 1 (inscrição)
    
    Begin
      Str(REG.num,num);
      TC:= Length(num);
      For c:= 1 To 4 - TC Do
      Insert('0',num,1);
      VET[IND].CC:= num;
      PFI:= PFI + 1
    End;
    
    If Option = 2 Then    // Se a opção for 2 (ordem alfabética)
    
    Begin
      VET[IND].CC:= REG.Nome;
      PFI:= PFI + 1
    End;
    
    If Option = 3 Then    // Se a opção for 3 (CPF)
    
    Begin
      VET[IND].CC:=REG.CPF;
      PFI:= PFI + 1
    End;
    
    If Option = 4 Then                    // Se a opção for 4 (cargo + alfabetica em cargo)
    
    Begin
      
      Str(REG.car,Cargo);
      Name:= REG.nome;
      CargoADD:= Concat(Cargo,Name);
      TC:= Length(CargoADD);
      
      For c:=1 To 37-TC Do
      
      Insert('0',CargoADD,1);
      VET[IND].CC:= CargoADD;
      PFI:= PFI + 1
      
    End
  End;
  
  
  
  Writeln(IND:5,' Registros Analisados   ', #10, 'Carregando Lista...');
  TOT:= IND;
  ORDEM(VET,TOT);                       // Chama a função ORDEM para ordenar o vetor VET
  Writeln;
  TextColor(lightred);
  Writeln('DIGITE ENTER PARA PROSSEGUIR.');
  TextColor(black);
  Readln;
  Clrscr;                                 // Limpa a tela para reiniciar contagem/demosntração
  Writeln;
  TextColor(lightblue);
  Write('  ORD  NUM N O M E                             ===C P F=== NASCIMENTO CS  N1');
  Writeln('  N2  N3  N4  N5  N6   SO   CG  CC CV FA');
  TextColor(black);
  Pagina:= 0;
  
  
  For B:= 1 To TOT Do
  
  BEGIN
    
    
    SEEK(ARQ,VET[B].PF);
    READ(ARQ,REG);
    
    IF (Pagina = 25) or (( Option = 4 ) and (caragr<>reg.car) and (Pagina > 0)) THEN
    BEGIN
      
      Writeln;
      TextColor(lightred);
      Writeln('ENTER Para Continuar Analisando: ');
      TextColor(black);
      READLN;
      CLRSCR;
      Writeln;
      TextColor(lightblue);
      write('  ORD  NUM N O M E                             ===C P F=== NASCIMENTO CS  N1');
      Writeln('  N2  N3  N4  N5  N6   SO   CG  CC CV FA');
      TextColor(black);
      Pagina:= 0;
      
    END;
    
    Write(B:5,REG.NUM:5,' ',REG.nome,' ',REG.CPF,' ',REG.DATA.DIA,'/',REG.DATA.MES,'/',REG.DATA.ANO,REG.car:3);
    FOR A:= 1 TO 6 DO
    Write(REG.NOTAS[A]:4);
    Writeln(REG.SOM:5,REG.CLG:5,REG.CLC:4,REG.CCL:3,REG.FALTA:3);
    caragr:= reg.car;
    Pagina:= Pagina + 1;
    
  END;
  Begin
    
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
    
  End;
End.