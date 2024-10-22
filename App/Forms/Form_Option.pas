unit Form_Option;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, uTypes,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
   ///<summary>
  ///   Class that is responsible for defining the type of document and its name.
  ///</summary>
  TFrOption = class(TForm)
    RadioGroup1: TRadioGroup;
    BTNOK: TBitBtn;
    BTNCANCEL: TBitBtn;
    Label1: TLabel;
    DOCUMENT_NAME: TEdit;
    ///<summary>
    ///  method that is responsible for preparing the name of the document
    ///</summary>
    procedure FormCreate(Sender: TObject);
    ///<summary>
    ///  method that is responsible for validating if the name is not empty
    ///</summary>
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    ///<summary>
    ///  Function that triggers the execution of displaying the interface to choose the document type
    ///</summary>
    Class Function Execute(var AType_Doc : TType_Doc; Var AName : String): Boolean;
  end;

var
  FrOption: TFrOption;

implementation

{$R *.dfm}

{ TFrOption }

class function TFrOption.Execute(var AType_Doc : TType_Doc; Var AName : String): Boolean;
Var
  lF : TFrOption;
begin
  AName := '';
  AType_Doc := TType_Doc.TTD_None;
  lF := TFrOption.Create(Application);
  Result := lF.ShowModal = mrOk;
  If Result Then
  Begin
    AName := lF.DOCUMENT_NAME.Text;
    Case lF.RadioGroup1.ItemIndex Of //defines the selected document type
      0 : AType_Doc := TType_Doc.TTD_Text;
      1 : AType_Doc := TType_Doc.TTD_Report;
      2 : AType_Doc := TType_Doc.TTD_Article;
      3 : AType_Doc := TType_Doc.TTD_PDF;
    End;
  End;
  FreeAndNil(lF);
end;

procedure TFrOption.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Not Trim(DOCUMENT_NAME.Text).IsEmpty;
  If Not CanClose Then //valid that the name must contain a value
    ShowMessage('You must enter the name');
end;

procedure TFrOption.FormCreate(Sender: TObject);
begin
  DOCUMENT_NAME.Clear;
end;

end.
