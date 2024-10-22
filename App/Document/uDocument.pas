unit uDocument;

interface

uses
  System.Classes,
  FireDAC.Comp.Client,
  System.Generics.Collections;

type
  /// Base class for documents
  ///<summary>
  ///   Class base of the document
  ///</summary>
  TDocument = class
  private
    ///<summary>
    /// Unique identifier of the document
    ///</summary>
    FID: string;
    ///<summary>
    /// Name of the document
    ///</summary>
    FName: string;
    ///<summary>
    /// Date added of the document
    ///</summary>
    FDateAdded: string;
    ///<summary>
    /// Date modified of the document
    ///</summary>
    FDateModified: string;
    ///<summary>
    /// Size of the document
    ///</summary>
    FSize: Integer;
    ///<summary>
    /// Descripcion of the document
    ///</summary>
    FDescription: string;
    ///<summary>
    /// Tags of the document
    ///</summary>
    FTags: string;
    ///<summary>
    /// Type of the document
    ///</summary>
    FType: string;
  public
    ///<summary>
    /// Constant for the type pdf document
    ///</summary>
    Const cPdf = 'pdf';
    ///<summary>
    /// Constant for the type text document
    ///</summary>
    Const cText = 'text';
    ///<summary>
    /// Constant for the report document
    ///</summary>
    Const cReport = 'report';
    ///<summary>
    /// Constant for the article document
    ///</summary>
    Const cArticle = 'article';
  public
    ///<summary>
    ///  Method that is responsible for creating the instance of the class
    ///</summary>
    ///<summary>
    ///  AID : String, Unique identification of the document
    ///</summary>
    ///<summary>
    ///  AName : String, name of the document
    ///</summary>
    ///<summary>
    ///  ASize: Integer, size of the document
    ///</summary>
    ///<summary>
    ///  ADescription: String, description of the document
    ///</summary>
    ///<summary>
    ///  ATags: String, Tags associated with the document, are a fundamental part of the search
    ///</summary>
    constructor Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AType: string);
    ///<summary>
    /// Unique identifier of the document
    ///</summary>
    property ID: string read FID write FID;
    ///<summary>
    /// Name of the document
    ///</summary>
    property Name: string read FName write FName;
    ///<summary>
    /// Date added of the document
    ///</summary>
    property DateAdded: string read FDateAdded write FDateAdded;
    ///<summary>
    /// Date modified of the document
    ///</summary>
    property DateModified: string read FDateModified write FDateModified;
    ///<summary>
    /// Size of the document
    ///</summary>
    property Size: Integer read FSize write FSize;
    ///<summary>
    /// Descripcion of the document
    ///</summary>
    property Description: string read FDescription write FDescription;
    ///<summary>
    /// Tags of the document
    ///</summary>
    property Tags: string read FTags write FTags;
    ///<summary>
    /// Type of the document
    ///</summary>
    property DocType: string read FType write FType;
  end;

  TDocuments = Class(TObjectList<TDocument>);

implementation
Uses
  uDatabase,
  System.SysUtils,
  FireDAC.Stan.Param;

{ TDocument }

constructor TDocument.Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AType: string);
begin
  FID := AID;
  FName := AName;
  FSize := ASize;
  FDescription := ADescription;
  FTags := ATags;
  FType := AType;
  FDateAdded := TDatabaseManager.GetDatetime(Now);
  FDateModified := TDatabaseManager.GetDatetime(Now);
end;

End.
