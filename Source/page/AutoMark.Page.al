page 74011 SIGIAutoMark
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoMark;
    Caption = 'SIGI Auto Mark';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec."Code")
                {
                    ToolTip = 'Automobilio kodas', Comment = '%';
                }
                field(Description; Rec."Description")
                {
                    ToolTip = 'Nurodomas Automobilio aprašas.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {

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
