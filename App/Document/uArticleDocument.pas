unit uArticleDocument;

interface

uses
  uDocument,
  System.Classes;

type
  ///<summary>
  ///   Class that defines the article document class of the base document base class
  ///</summary>
  TArticleDocument = class(TDocument)
  private
    ///<summary>
    ///   Property Property that stores the author's information
    ///</summary>
    FAuthor: string;
    ///<summary>
    ///   Property that stores the information about the publication date
    ///</summary>
    FPublicationDate: String;
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
    ///   AAuthor: string, author of the document
    ///</summary>
    ///<summary>
    ///   APublicationDate: string, publication date of the document
    ///</summary>
    constructor Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AAuthor, APublicationDate: string);
    ///<summary>
    ///   Property Property that stores the author's information
    ///</summary>
    property Author: string read FAuthor write FAuthor;
    ///<summary>
    ///   Property that stores the information about the publication date
    ///</summary>
    property PublicationDate: String read FPublicationDate write FPublicationDate;
  end;

implementation
Uses
  System.SysUtils;

{ TArticleDocument }
constructor TArticleDocument.Create(AID, AName: string; ASize: Integer; ADescription: string; ATags: string; AAuthor, APublicationDate: string);
begin
  inherited Create(AID, AName, ASize, ADescription, ATags, cArticle);
  FAuthor := AAuthor;
  FPublicationDate := APublicationDate;
end;


end.
