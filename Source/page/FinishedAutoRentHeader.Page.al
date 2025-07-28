page 74022 SIGIFinishedAutoRentHeader
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIFinishedAutoRentHeader;
    CardPageId = SIGIFinishedAutoRentHeaderCard;
    Caption = 'SIGI Finished Auto Rent Header';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Editable = false;

                field("Nr."; Rec."Nr.")
                {
                    ToolTip = 'Nuomos kortelės Nr.', Comment = '%';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Kliento Nr.', Comment = '%';
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
            }
        }
    }
}
