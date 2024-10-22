unit uTable.Base;

interface
Uses
  uDatabase,
  System.Types,
  System.Classes,
  System.Generics.Collections;

Type
  ///<summary>
  ///Base class for table management
  ///</summary>
  TTable_Base = Class(TObject)
  Private
    ///<summary>
    ///Database Administrator
    ///</summary>
    FCon : TDatabaseManager; //Database Administrator
  Public
    ///<summary>
    ///Database Administrator
    ///</summary>
    Property Con : TDatabaseManager Read FCon Write FCon;
    ///<summary>
    ///Unique identifier of the table
    ///</summary>
    Class Function Id : String; Virtual; Abstract;
    ///<summary>
    ///Name of table
    ///</summary>
    Class Function Name : String; Virtual; Abstract;
    ///<summary>
    ///Caption or description of the table
    ///</summary>
    Class Function Caption : String; Virtual; Abstract;
    ///<summary>
    ///Method that loads the sql statement from the folder table structure
    ///</summary>
    ///<summary>
    ///ASentence : TStrings, container that will hold the SQL statement for creating the folder table structure
    ///</summary>
    Procedure GetSQL(Const ASentence : TStrings); Virtual; Abstract;
    ///<summary>
    ///Method that is executed after the object is created
    ///Database Connection Assignment
    ///</summary>
    procedure AfterConstruction; override;
  End;
  TTables_Base = Class(TObjectList<TTable_Base>);


implementation

Uses
  System.SysUtils;

{ TTable_Base }

procedure TTable_Base.AfterConstruction;
begin
  inherited;
  FCon := TDatabaseManager.GetInstance;
end;

end.
