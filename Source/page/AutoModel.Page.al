page 74012 SIGIAutoModel
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoModel;
    Caption = 'SIGI Auto Model';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(MarkCode; Rec.MarkCode)
                {
                    ToolTip = 'Automobilio markės kodas.', Comment = '%';
                }
                field(ModelCode; Rec.ModelCode)
                {
                    ToolTip = 'Automobilio modelio kodas.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Nurodomas automobilio aprašas.', Comment = '%';
                }
            }
        }
    }
}
