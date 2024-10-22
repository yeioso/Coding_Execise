unit uFolder;


interface

uses
  uDocument,
  uDatabase,
  System.SysUtils,
  System.Generics.Collections;

type
   ///<summary>
  ///   Class that is responsible for managing information regarding the folder
  ///</summary>
  TFolders = Class;

  TFolder = Class(TObject)
  private
    FID: string;
    FName: string;
  public
    ///<summary>
    ///  Creating the instance that manages the folder
    ///</summary>
    constructor Create(AName: string);
    ///<summary>
    ///   Unique identifier of the folder
    ///</summary>
    property ID: string Read FID write FID;
    ///<summary>
    ///   Name of the folder
    ///</summary>
    property Name: string read FName write FName;
  end;
  TFolders = Class(TObjectList<TFolder>);

implementation

{ TFolder }

///<summary>
///  Creating the instance that manages the folder
///</summary>
constructor TFolder.Create(AName: string);
begin
  FID := TDatabaseManager.GetId;
  FName := AName;
end;

end.


