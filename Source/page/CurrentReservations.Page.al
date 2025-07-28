page 74016 SIGICurrentReservations
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoReservation;
    Caption = 'Galiojančios rezervacijos';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ToolTip = 'Automobilio Nr.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Eilutės Nr.', Comment = '%';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Kliento Nr.', Comment = '%';
                }
                field(ReservedFrom; Rec.ReservedFrom)
                {
                    ToolTip = 'Automobilio rezervacijos pradžios data ir laikas.', Comment = '%';
                }
                field(ReservedTo; Rec.ReservedTo)
                {
                    ToolTip = 'Automobilio rezervacijos pabaigos data ir laikas.', Comment = '%';
                }
            }
        }
    }

    // Filter reservations only valid from today
    trigger OnOpenPage()
    begin
        Rec.SetFilter("ReservedTo", '>=%1', CreateDateTime(TODAY, 0T));
    end;
}
