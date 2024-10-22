unit uPDFDocument;

interface

uses
  uDocument,
  System.Classes;

type
  ///<summary>
  ///   Class that defines the pdf document class of the base document base class
  ///</summary>
  TPDFDocument = class(TDocument)
  private
    ///<summary>
    ///   Property that stores the version's information
    ///</summary>
    FVersion: string;
    ///<summary>
    ///   Property that stores the encryption status's information
    ///</summary>
    FEncryptionStatus: string;
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
    ///<summary>
    ///   AVersion: string, version of the document
    ///</summary>
    ///<summary>
    ///   AEncryptionStatus: string, encryption status of the document
    ///</summary>
    constructor Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AVersion: string; AEncryptionStatus: string);
    ///<summary>
    ///   Property that stores the version's information
    ///</summary>
    property Version: string read FVersion write FVersion;
    ///<summary>
    ///   Property that stores the encryption status's information
    ///</summary>
    property EncryptionStatus: string read FEncryptionStatus write FEncryptionStatus;
  end;

implementation

Uses
  System.SysUtils;

{ TPDFDocument }

constructor TPDFDocument.Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AVersion: string; AEncryptionStatus: string);
begin
  inherited Create(AID, AName, ASize, ADescription, ATags, cPdf);
  FVersion := AVersion;
  FEncryptionStatus := AEncryptionStatus;
end;


end.

