page 74024 SIGIDriverLicenseImageFactBox
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = SIGIAutoRentHeader;
    Caption = 'SIGI Vairuotojo pažymėjimo nuotrauka';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Driver License Image"; Rec."Driver License Image")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vairuotojo pažymėjimo nuotrauka';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportImage)
            {
                Caption = 'Įkelti nuotrauką';
                Image = Import;
                ToolTip = 'Įkelti vairuotojo pažymėjimo nuotrauką';

                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    // Opens file import dialog in UI.
                    // Property fields meanings: prompt shown for user, file filter,
                    // default file name, uploaded files name, uploaded image stream
                    // If user choses a file and clicks ok, UploadIntoStream returns true.
                    if UploadIntoStream('Pasirinkite nuotrauką', '', '', FileName, InStr) then begin
                        Rec."Driver License Image".ImportStream(InStr, FileName);
                        Rec.Modify();
                    end;
                end;
            }

            action(DeleteImage)
            {
                Caption = 'Pašalinti nuotrauką';
                Image = Delete;
                ToolTip = 'Ištrinti vairuotojo pažymėjimo nuotrauką';

                trigger OnAction()
                begin
                    Clear(Rec."Driver License Image");
                    Rec.Modify();
                end;
            }
        }
    }
}
