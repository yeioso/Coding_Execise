program Delphi_Coding_Exercise;

  ///<summary>
  /// Author: Yeimi Rodrigo Osorio Valladares
  /// Date: 2024-10-22
  ///</summary>

uses
  Vcl.Forms,
  uDatabase,
  uCreate.Base,
  Form_Main in 'Forms\Form_Main.pas' {FrMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //Validates if there is a connection to the database and if the tables are created to use the application
  If TDatabaseManager.GetInstance.Connect And TCreate_Base.Execute Then
  Begin
    Application.CreateForm(TFrMain, FrMain);
  Application.Run;
  End
  Else
  Begin
    Application.Terminate;
  End;
end.
