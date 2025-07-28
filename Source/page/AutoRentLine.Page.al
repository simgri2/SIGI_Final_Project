page 74021 SIGIAutoRentLine
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAutoRentLine;
    Caption = 'SIGI Auto Rent Line';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Dokumento Nr.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Eilutės Nr.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Paslaugos tipas.', Comment = '%';
                }
                field("Nr."; Rec."Nr.")
                {
                    ToolTip = 'Nr.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Paslaugos aprašas.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Suteiktos paslaugos kiekis.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Paslaugos vieneto kaina.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Paslaugos suma.', Comment = '%';
                }
            }
        }
    }
}
