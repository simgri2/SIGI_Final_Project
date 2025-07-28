page 74023 SIGIFinishedAutoRentHeaderCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SIGIFinishedAutoRentHeader;
    Caption = 'SIGI Finished Auto Rent Header';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = false;
                Caption = 'Nuomos sutartis';

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
            group(Lines)
            {
                Editable = false;
                Caption = 'Paslaugos';
                part(OrderLines; "SIGIFinishedAutoRentLine")
                {
                    // Shows rent lines related only to this specific rent header
                    SubPageLink = "Document No." = field("Nr.");
                }
            }
        }

        area(FactBoxes)
        {
            part(DriverLicenseImage; "SIGIDriverLicenseImageFactBox")
            {
                SubPageLink = "Nr." = field("Nr.");
            }
        }
    }
}
