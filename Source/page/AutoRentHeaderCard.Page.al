page 74019 SIGIAutoRentHeaderCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SIGIAutoRentHeader;
    Caption = 'SIGI Auto Rent Header';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                field("Nr."; Rec."Nr.")
                {
                    ToolTip = 'Nuomos kortelės Nr.', Comment = '%';
                    Editable = IsEditable;
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Kliento Nr.', Comment = '%';
                    Editable = IsEditable;
                }
                field("Driver License Image"; Rec."Driver License Image")
                {
                    ToolTip = 'Vairuotojo pažymėjimo nuotrauka.', Comment = '%';
                    Editable = IsEditable;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Sutarties sudarymo data.', Comment = '%';
                    Editable = IsEditable;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ToolTip = 'Automobilio Nr.', Comment = '%';
                    Editable = IsEditable;
                }
                field(ReservedFrom; Rec.ReservedFrom)
                {
                    ToolTip = 'Automobilio rezervacijos pradžios data.', Comment = '%';
                    Editable = IsEditable;
                }
                field(ReservedTo; Rec.ReservedTo)
                {
                    ToolTip = 'Automobilio rezervacijos pabaigos data.', Comment = '%';
                    Editable = IsEditable;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Nuomos paslaugų suma.', Comment = '%';
                    Editable = IsEditable;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Sutarties būsena.', Comment = '%';
                    Editable = IsEditable;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Išduoti';
                Image = ReleaseDoc;
                ToolTip = 'Keisti statusą į "Išduota"';

                trigger OnAction()
                begin
                    Rec.SetStatusToReleased();
                end;
            }
            action(Reopen)
            {
                Caption = 'Atidaryti';
                Image = ReOpen;
                ToolTip = 'Keisti statusą į "Atidaryta"';

                trigger OnAction()
                begin
                    Rec.SetStatusToOpen();
                end;
            }
        }

        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(Release_Promoted; Release)
                {
                }
                actionref(Reopen_Promoted; Reopen)
                {
                }
            }
        }
    }

    var
        IsEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        // Set IsEditable to false if Status = Išduota, else true
        IsEditable := Rec.Status <> Rec.Status::"Išduota";
    end;

}
