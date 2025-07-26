page 74017 SIGIAutoDamage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoDamage;
    Caption = 'SIGI Auto Damage';

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
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Automobilio žalos fiksavimo data.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Žalos automobiliui aprašas.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Dokumento statusas.', Comment = '%';
                }
            }
        }
    }
}
