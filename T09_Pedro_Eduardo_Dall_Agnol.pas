Program T09_Pedro_Eduardo_Dall_Agnol;
// FEITO POR Pedro Eduardo Dall' Agnol GRR-20240844

USES TARDENOITE;

VAR

REG																								:REGIS   										 ;
VET																								:VETOR											 ;
ARQ																								:File Of REGIS							 ;
Vagas																							:Text												 ;
Vaga																							:String [31]								 ;
Datas																							:String [8]									 ;
Nvagas																						:String [2]								 	 ;
Notas																							:Array  [1..7]  Of String[3] ;
Nvagaa																						:Array  [1..12] Of integer   ;
Cargoo																						:Array  [1..12] Of Integer	 ;
A, B, C, PFI, IND, TOT, Datae, clg, Nvaga, eRR		:Integer										 ;


Begin
  
  TextBackground(white);  { Mudar a cor de fundo para branco. }
  TextColor(black);       { Mudar a cor das letras para preto. }
  
  ClrScr;
  
  Writeln('    --- = ---');
  Writeln;
  Writeln('Start ');
  Writeln;                  // Inicio do programa T09 ------>
  
  Writeln('Atualizando campos CG, CC e CV.', #10, 'Por favor, aguarde...');
  
  ASSIGN(Vagas,'VAGAS.TXT');
  ASSIGN(ARQ,'CAND.IND');
  
  RESET(vagas);
  RESET(ARQ);
  
  for A:=1 to 12 do
  
  Begin
    readln(Vagas,Vaga);
    Nvagas := Copy(Vaga,30,2);
    val(Nvagas,Nvagaa[a],eRR);
  End;
  
  
  While (Not EOF(ARQ)) Do
  
  Begin
    
    Read(ARQ,REG);
    IND := IND+1;
    VET[IND].PF := PFI;
    Str(reg.som:3,Notas[1]) ;
    Str(reg.notas[4]:3,Notas[2]) ;
    Str(reg.notas[5]:3,Notas[3]) ;
    Str(reg.notas[3]:3,Notas[4]) ;
    Str(reg.notas[2]:3,Notas[5]) ;
    Str(reg.notas[6]:3,Notas[6]) ;
    Str(reg.notas[1]:3,Notas[7]) ;
    Datas := REG.DATA.ANO+REG.DATA.MES+REG.DATA.DIA;
    Val(Datas,datae,eRR);
    Datae := 20240605-Datae;
    Str(Datae:6, Datas);
    VET[IND].CC := Concat(Notas[1], Notas[2], Notas[3], Notas[4], Notas[5], Notas[6], Notas[7], Datas);
    PFI := PFI+1;
    Datae := 0  ;
    
  End;
  
  TOT:=IND;
  ORDEM(VET,TOT);
  
  For B:=tot Downto 1 Do
  
  Begin
    
    SEEK(ARQ,VET[B].PF);
    READ(ARQ,REG);
    clg := 1+clg ;
    reg.clg := clg;
    Cargoo[reg.car] := Cargoo[reg.car]+1 ;
    reg.clc := Cargoo[reg.car];
    
    If  (Cargoo[reg.car] <= Nvagaa[reg.car]) Then
    
    Begin
      reg.ccl:=reg.car;
    End;
    
    SEEK(arq,vet[B].pf);
    Write(arq,reg);
    
  End;
  
  CLRSCR;
  
  Writeln('    --- = ---');
  Writeln;
  Writeln('Start ');
  Writeln;
  Writeln('Os campos CG, CC e CV, foram atualizados com sucesso.');
  
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
  
  Close(arq);
  Close(vagas);
  
End.
