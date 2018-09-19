unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var nome, sexo : String;
    idade : integer;
begin

  nome := Edit1.Text;
  idade := StrToInt(Edit2.Text);
  if RadioButton1.Checked = true then sexo := 'true' else sexo := 'false';

  Memo1.Lines.Add('{');
  Memo1.Lines.Add('   "nome" : "' + nome + '",' );
  Memo1.Lines.Add('   "idade" : ' + IntToStr(idade) + ',' );
  Memo1.Lines.Add('   "sexo" : ' + sexo);
  Memo1.Lines.Add('}');

end;

procedure TForm1.Button2Click(Sender: TObject);
var caminho : String;
begin
  if OpenDialog1.Execute() then
  begin
    caminho := OpenDialog1.FileName;
    Memo1.Lines.SaveToFile(caminho);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var caminho : String;
begin
  if OpenDialog1.Execute() then
  begin
    Memo1.Clear;
    caminho := OpenDialog1.FileName;
    Memo1.Lines.LoadFromFile(caminho);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  jsonObj, jSubObj: TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
  i: Integer;
begin
  jsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Memo1.Text), 0) as TJSONObject;

  jv := jsonObj.Get('ATIVIDADES_SECUNDARIAS').JsonValue;
  ja := jv as TJSONArray;

  ListBox1.Clear;

  for i := 0 to ja.Size - 1 do
  begin
    jSubObj := (ja.Get(i) as TJSONObject);
    jv := jSubObj.Get(0).JsonValue;
    ListBox1.Items.Add(jv.Value);
  end;

end;

end.
