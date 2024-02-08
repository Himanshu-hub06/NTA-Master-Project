page 50271 "Driver Image"
{
    Caption = 'Image';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Driver;

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the picture of the customer, for example, a logo.';
                    trigger OnDrillDown()
                    var
                        FileManagement: Codeunit "File Management";
                        FileName: Text;
                        ClientFileName: Text;
                        selection: Integer;
                    begin
                        if Rec."Driver Name" = '' then
                            Error(MustSpecifyNameErr);
                        selection := StrMenu('Upload,Delete', 1, 'Go through the selected option');
                        if selection = 1 then begin
                            if Rec.Image.HasValue then
                                if not Confirm(OverrideImageQst) then
                                    exit;
                            FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                            if FileName = '' then
                                exit;

                            Clear(Rec.Image);
                            Rec.Image.ImportFile(FileName, ClientFileName);
                            if not Rec.Modify(true) then
                                Rec.Insert(true);

                            if FileManagement.DeleteServerFile(FileName) then;
                        end;
                        if selection = 2 then begin
                            if Confirm(DeleteImageQst) then
                                Clear(rec.Image);
                        end;
                    end;
                }
            }
        }
    }
    actions
    {

    }

    var
        Camera: Codeunit Camera;
        [InDataSet]
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        MustSpecifyNameErr: Label 'You must specify a ''Driver Name'' before you can import a picture.';

    procedure TakeNewPicture()
    begin
        Rec.Find;
        Rec.TestField("Driver Code");

        Camera.AddPicture(Rec, Rec.FieldNo(Image));
    end;
}
