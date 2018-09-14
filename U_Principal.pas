unit U_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, StrUtils, FMX.Menus, FMX.ExtCtrls, FMX.ScrollBox,
  FMX.Memo, FMX.ListBox, FMX.Layouts;

type
  TForm1 = class(TForm)
    lblTopo: TLabel;
    btnExibe: TButton;
    radioA: TRadioButton;
    radioB: TRadioButton;
    popupDiaSemana: TPopupBox;
    memoExibeDia: TMemo;
    Label1: TLabel;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Label2: TLabel;
    procedure btnExibeClick(Sender: TObject);
    procedure popupDiaSemanaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure radioAChange(Sender: TObject);
    procedure radioBChange(Sender: TObject);
  private
    materia : array[0..1] of array[0..7] of array [0..4] of string;
    aulalivre: array[0..1] of array[0..7] of  array [0..4] of Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}
{$R *.Moto360.fmx ANDROID}
{$R *.GGlass.fmx ANDROID}
{$R *.SSW3.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}

procedure TForm1.btnExibeClick(Sender: TObject);
var
hora_s, minuto_s, tempo, diasemana_s, mensagem, minmins : string;
diasemana_i, soma, soma_5, aula, aula_5, turma, min_aux, min_restante: integer;
hora, minuto, segundo, milesimo : Word;
min5 : Boolean;

begin
  if radioA.IsChecked then
  begin
    turma := 0;
  end
  else if radioB.IsChecked then
  begin
    turma := 1;
  end
  else
  begin
      ShowMessage('Nenhuma turma selecionada!');
      Exit
  end;
  tempo := LeftStr(TimeToStr(Time),5);
  hora_s := Copy(tempo,1,2);
  minuto_S := Copy(tempo,4,2);
  DecodeTime(Time,hora,minuto,segundo,milesimo);
  soma := (hora*60)+minuto; //Converte as horas em minutos
  soma_5 := soma+10; //Minutos para mostrar a proxima aula
  diasemana_i := (DayOfWeek(Date) - 2);

  case diasemana_i of
  -1 : diasemana_s := 'Domingo';
  0 : diasemana_s := 'Segunda-Feira';
  1 : diasemana_s := 'Terça-Feira';
  2 : diasemana_s := 'Quarta-Feira';
  3 : diasemana_s := 'Quinta-Feira';
  4 : diasemana_s := 'Sexta-Feira';
  5 : diasemana_s := 'Sábado';
  end;

  mensagem := 'Hoje é ' + diasemana_s + '.' + sLineBreak +
              'O horário é: ' + hora_s + ':' + minuto_s + '.';


  // Calculo para saber a aula atual
  case soma of
  440 .. 489 : aula := 0;
  490 .. 539 : aula := 1;
  540 .. 589 : aula := 2;
  590 .. 604 : aula := 11; //Intervalo
  605 .. 654 : aula := 3;
  655 .. 704 : aula := 4;
  705 .. 779 : aula := 12; // Almoço
  780 .. 829 : aula := 5;
  830 .. 879 : aula := 6;
  880 .. 929 : aula := 7;
  else
  begin
    aula := 10; //Fora do horário de aula
  end;
  end;


  // Aula = 11 = Intervalo
  // Aula = 12 = Almoço
  // Aula = 10 = Fora do horario (e não dia) de aula

  // Calculo de 5 minutos na frente
  case soma_5 of
  440 .. 489 : aula_5 := 0;
  490 .. 539 : aula_5 := 1;
  540 .. 589 : aula_5 := 2;
  590 .. 604 : aula_5 := 11; //Intervalo
  605 .. 654 : aula_5 := 3;
  655 .. 704 : aula_5 := 4;
  705 .. 779 : aula_5 := 12; // Almoço
  780 .. 829 : aula_5 := 5;
  830 .. 879 : aula_5 := 6;
  880 .. 929 : aula_5 := 7;
  else
  begin
    aula_5 := 10; //Fora do horário de aula
  end;
  end;

  case aula_5 of
  0 : min_aux := 440;
  1 : min_aux := 490;
  2 : min_aux := 540;
  3 : min_aux := 605;
  4 : min_aux := 655;
  5 : min_aux := 780;
  6 : min_aux := 830;
  7 : min_aux := 880;
  11 : min_aux := 590;
  12 : min_aux := 705;
  else
  begin
     min_aux :=930;
  end;
  end;

  min_restante := ((min_aux) - (soma));

  if min_restante = 1 then //Gambiarra para mostrar minuto ou minutos.
  begin
    minmins := ' minuto ';
  end
  else
  begin
    minmins := ' minutos ';
  end;



  //Verificar se falta 5 minutos
  if ((aula - aula_5) <> 0) then
  begin
    min5 := True;
  end
  else
  begin
    min5 := False;
  end;
  if ((diasemana_i = 0) or (diasemana_i = 1) or (diasemana_i = 2) or (diasemana_i = 3) or (diasemana_i = 4)) then
  begin
      if (min5 = False) then
      begin
        if ((aula_5 <> 10) and (aula_5 <> 11) and (aula_5 <>12) and (aulalivre[turma][aula_5][diasemana_i] = False)) then
        begin
          mensagem := mensagem + sLineBreak +
                  'Você está na ' + IntToStr(aula + 1) + 'ª aula.' + sLineBreak +
                  'Matéria: ' + materia[turma][aula][diasemana_i] + '.';
        end
        else if ((aula_5 <> 10) and (aula_5 <> 11) and (aula_5 <>12) and (aulalivre[turma][aula_5][diasemana_i] = True)) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Você está na aula livre.'
        end
        else if (aula = 11) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Você está no intervalo.'
        end
        else if (aula = 12) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Você está no almoço.'
        end
        else if (aula = 10) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Você está fora do horário de aula.'
        end;
      end
      else // Se faltar 5 minutos
      begin
        if ((aula_5 <> 10) and (aula_5 <> 11) and (aula_5 <>12) and (aulalivre[turma][aula_5][diasemana_i] = False)) then
        begin
          mensagem := mensagem + sLineBreak +
                  'Faltam ' +  IntToStr(min_restante) + ' minutos para a ' +
                   IntToStr(aula_5 + 1) + 'ª aula.' + sLineBreak +
                  'Matéria: ' + materia[turma][aula_5][diasemana_i] + '.';
        end
        else if ((aula_5 <> 10) and (aula_5 <> 11) and (aula_5 <>12) and (aulalivre[turma][aula_5][diasemana_i] = True)) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Daqui a ' + IntToStr(min_restante) + minmins + 'você estará na aula livre.';
        end
        else if (aula_5 = 11) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Daqui a ' + IntToStr(min_restante) + minmins + 'você estará no intervalo.'
        end
        else if (aula_5 = 12) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Daqui a ' + IntToStr(min_restante) + minmins + 'você estará no almoço.'
        end
        else if (aula_5 = 10) then
        begin
          mensagem := mensagem + sLineBreak +
                      'Daqui a ' + IntToStr(min_restante) + minmins + 'você estará fora do horário de aula.'
        end;
      end;
  end
  else //Dia que não é útil
  begin
    mensagem := mensagem + sLineBreak +
                'Hoje não tem aula!';
  end;

  ShowMessage(mensagem);

end;
procedure TForm1.FormCreate(Sender: TObject);
var
diasemana : Integer;
begin
  //Segunda [0][x][0]
  materia[0][0][0] := 'Matemática';

  materia[0][1][0] := 'Matemática';

  materia[0][2][0] := 'LPL';

  materia[0][3][0] := 'História';

  materia[0][4][0] := 'História';

  materia[0][5][0] := 'Química';

  materia[0][6][0] := 'Química';

  materia [0][7][0] := 'LPL';

  //Terca [0][x][1]

  materia[0][0][1] := 'Biologia';

  materia[0][1][1] := 'Educação Física';

  materia[0][2][1] := 'Educação Física';

  materia[0][3][1] := 'Inglês';

  materia[0][4][1] := 'Inglês';

  materia[0][5][1] := 'GSO';

  materia[0][6][1] := 'GSO';

  materia[0][7][1] := 'LOO';

  //Quarta [0][x][2]

  materia[0][0][2] := 'LPL';

  materia[0][1][2] := 'Matemática';

  materia[0][2][2] := 'TLB';

  materia[0][3][2] := 'TLB';

  materia[0][4][2] := 'LOO';

  materia[0][5][2] := 'ASI';

  materia[0][6][2] := 'GSO';

  materia[0][7][2] := 'Geografia';

  //Quinta [0][x][3]

  aulalivre[0][0][3] := True;
  materia [0][0][3] := 'Livre';

  materia[0][1][3] := 'Física';

  materia[0][2][3] := 'Física';

  materia[0][3][3] := 'ASI';

  materia[0][4][3] := 'LOO';

  materia[0][5][3] := 'Empreendedorismo';

  materia[0][6][3] := 'Geografia';

  aulalivre[0][7][3] := True;
  materia [0][7][3] := 'Livre';

  //Sexta [0][x][4]

  materia[0][0][4]:= 'Sociologia';

  materia[0][1][4] := 'LPL';

  materia[0][2][4] := 'Matemática';

  materia[0][3][4] := 'Biologia';

  materia[0][4][4] := 'LPL';

  materia[0][5][4] := 'Filosofia';

  materia[0][6][4] := 'TLB';

  materia[0][7][4] := 'TLB';

  //Segunda [1][x][0]

  materia[1][0][0] := 'Matemática';

  materia[1][1][0] := 'Matemática';

  materia[1][2][0] := 'LPL';

  materia[1][3][0] := 'História';

  materia[1][4][0] := 'História';

  materia[1][5][0] := 'Química';

  materia[1][6][0] := 'Química';

  materia [1][7][0] := 'LPL';

  //Terça [1][x][1]

  materia[1][0][1] := 'Biologia';

  materia[1][1][1] := 'Educação Física';

  materia[1][2][1] := 'Educação Física';

  materia[1][3][1] := 'Inglês';

  materia[1][4][1] := 'Inglês';

  materia[1][5][1] := 'TLB';

  materia[1][6][1] := 'TLB';

  materia[1][7][1] := 'TPI';

  //Quarta [1][x][2]

  materia[1][0][2] := 'LPL';

  materia[1][1][2] := 'Matemática';

  materia[1][2][2] := 'LOO';

  materia[1][3][2] := 'LOO';

  materia[1][4][2] := 'ASI';

  materia[1][5][2] := 'GSO';

  materia[1][6][2] := 'ASI';

  materia[1][7][2] := 'Geografia';

  //Quinta [1][x][3]

  aulalivre[1][0][3] := True;
  materia [1][0][3] := 'Livre';

  materia[1][1][3] := 'Física';

  materia[1][2][3] := 'Física';

  materia[1][3][3] := 'GSO';

  materia[1][4][3] := 'TPI';

  materia[1][5][3] := 'Empreendedorismo';

  materia[1][6][3] := 'Geografia';

  materia[1][7][3] := 'LOO';

  //Sexta [1][x][4]

  materia[1][0][4] := 'Sociologia';

  materia[1][1][4] := 'LPL';

  materia[1][2][4] := 'Matemática';

  materia[1][3][4] := 'Biologia';

  materia[1][4][4] := 'LPL';

  materia[1][5][4] := 'Filosofia';

  materia[1][6][4] := 'GSO';

  aulalivre[1][7][4] := True;
  materia [1][7][4] := 'Livre';

  diasemana := DayOfWeek(Date);
  case diasemana of
  2 : popupDiaSemana.ItemIndex := 0;
  3 : popupDiaSemana.ItemIndex := 1;
  4 : popupDiaSemana.ItemIndex := 2;
  5 : popupDiaSemana.ItemIndex := 3;
  6 : popupDiaSemana.ItemIndex := 4;
  end;
  popupDiaSemanaChange(Self);

end;

procedure TForm1.popupDiaSemanaChange(Sender: TObject);
var
turma, diasemana : string;
index, turma_i: integer;
begin
      memoExibeDia.Lines.Clear;
      if (popupDiaSemana.ItemIndex <> -1) then
      begin
        if radioA.IsChecked then
        begin
          turma := 'A';
          turma_i := 0;
        end
        else if radioB.IsChecked then
        begin
          turma := 'B';
          turma_i := 1;
        end
        else
        begin
          memoExibeDia.Lines.Add('Selecione uma turma!');
          Exit;
        end;

        index := popupDiaSemana.ItemIndex;
        case index of
        0: diasemana := 'Segunda-Feira';
        1: diasemana := 'Terça-Feira';
        2: diasemana := 'Quarta-Feira';
        3: diasemana := 'Quinta-Feira';
        4: diasemana := 'Sexta-Feira';
        end;

        if ((radioA.IsChecked) or (radioB.IsChecked)) then
        begin
        memoExibeDia.Lines.Add('Cronograma Turma ' + turma);
        memoExibeDia.Lines.Add('');
        memoExibeDia.Lines.Add(diasemana);
        memoExibeDia.Lines.Add('07:20 - 08:10 - ' + materia[turma_i][0][index]);
        memoExibeDia.Lines.Add('08:10 - 09:00 - ' + materia[turma_i][1][index]);
        memoExibeDia.Lines.Add('09:00 - 09:50 - ' + materia[turma_i][2][index]);
        memoExibeDia.Lines.Add('Intervalo');
        memoExibeDia.Lines.Add('10:05 - 10:55 - ' + materia[turma_i][3][index]);
        memoExibeDia.Lines.Add('10:55 - 11:45 - ' + materia[turma_i][4][index]);
        memoExibeDia.Lines.Add('Almoço');
        memoExibeDia.Lines.Add('13:00 - 13:50 - ' + materia[turma_i][5][index]);
        memoExibeDia.Lines.Add('13:50 - 14:40 - ' + materia[turma_i][6][index]);
        memoExibeDia.Lines.Add('14:40 - 15:30 - ' + materia[turma_i][7][index]);
        end;
      end
      else
      begin
        memoExibeDia.Lines.Add('Selecione um dia da semana!');
      end;
end;

procedure TForm1.radioAChange(Sender: TObject);
begin
  popupDiaSemanaChange(Self);
end;

procedure TForm1.radioBChange(Sender: TObject);
begin
  popupDiaSemanaChange(Self);
end;

end.
