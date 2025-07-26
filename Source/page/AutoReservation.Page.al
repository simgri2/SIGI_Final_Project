page 74015 SIGIAutoReservation
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoReservation;
    Caption = 'SIGI Auto Reservation';

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
                field(ReservationFrom; Rec.ReservedFrom)
                {
                    ToolTip = 'Automobilio rezervacijos pradžios data ir laikas.', Comment = '%';
                }
                field(ReservationUntil; Rec.ReservedTo)
                {
                    ToolTip = 'Automobilio rezervacijos pabaigos data ir laikas.', Comment = '%';
                }
            }
        }
    }

    /*
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    */
}
