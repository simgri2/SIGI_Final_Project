page 74010 SIGIAutoSetup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SIGIAutoSetup;
    Caption = 'SIGI Auto Setup';
    Editable = true;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Automobile No. Series"; Rec."Automobile No. Series")
                {
                    ToolTip = 'Automobilių nr. serija.', Comment = '%';
                }
                field("Rent Card Series"; Rec."Rent Card Series")
                {
                    ToolTip = 'Nuomos kortelės nr. serija.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ToolTip = 'Priedai.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}
