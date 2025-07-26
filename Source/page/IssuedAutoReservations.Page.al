page 74020 SIGIIssuedAutoReservations
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoRentHeader;
    Caption = 'SIGI Išduotos Auto Sutartys';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Nr."; Rec."Nr.")
                {
                    ToolTip = 'Nuomos kortelės Nr.', Comment = '%';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Kliento Nr.', Comment = '%';
                }
                field("Driver License Image"; Rec."Driver License Image")
                {
                    ToolTip = 'Vairuotojo pažymėjimo nuotrauka.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Sutarties sudarymo data.', Comment = '%';
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ToolTip = 'Automobilio Nr.', Comment = '%';
                }
                field(ReservedFrom; Rec.ReservedFrom)
                {
                    ToolTip = 'Automobilio rezervacijos pradžios data.', Comment = '%';
                }
                field(ReservedTo; Rec.ReservedTo)
                {
                    ToolTip = 'Automobilio rezervacijos pabaigos data.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Nuomos paslaugų suma.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Sutarties būsena.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    trigger OnOpenPage()
    begin
        // Showing only issued reservations (status = išduota)
        Rec.SetFilter("Status", '=%1', Rec.Status::"Išduota");
    end;
}
