unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Xml.xmldom,
  Xml.XMLIntf, Xml.XMLDoc, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, UrlMon;

type
  TForm1 = class(TForm)
    DadosXML: TXMLDocument;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

function DownloadFile(Source, Dest: string): Boolean;
begin
try
Result:= UrlDownloadToFile(nil, PChar(source),PChar(Dest), 0, nil) = 0;
except
Result:= False;
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
a, b , c : Integer;
begin
  if FileExists('C:\Users\Lucas\Desktop\teste\dados.xml') then
  begin
    DadosXML.LoadFromFile('C:\Users\Lucas\Desktop\teste\dados.xml');
    for a := 0 to 1 do
    begin
      for b := 0 to 4 do
        begin
          for c := 0 to 7 do
          begin
            materia[a][c][b] := (DadosXML.ChildNodes.FindNode('materia').ChildNodes[a].ChildNodes[b].ChildValues[c]);
            Memo1.Lines.Add(materia[a][c][b]);
            if (materia[a][c][b] = 'Livre') then
            begin
              aulalivre[a][c][b] := True;
            end;
          end;
        end;
    end;
  end
  else
  begin
    ShowMessage('Arquivo N�o existe!');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  if DownloadFile('https://lucasdessy.github.io/etec-app/data/dados.xml','C:\Users\Lucas\Desktop\teste\dados.xml') then
  begin
    ShowMessage('Baixado');
  end
  else
  begin
  ShowMessage('Erro');
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.
