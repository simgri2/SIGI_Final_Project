report 74010 SIGIAutoRent
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Automobilio nuomos išdavimo kortelė';
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(SIGIAutoRentHeader; SIGIAutoRentHeader)
        {
            // Suggestive filter in UI
            RequestFilterFields = "Nr.";

            column(Auto_No_; "Auto No.") { }
            column(ReservedFrom; "ReservedFrom") { }
            column(ReservedTo; "ReservedTo") { }
            column(Auto_Mark; "Auto Mark") { }
            column(Auto_Model; "Auto Model") { }
            column(Client_Name; "Client Name") { }

            dataitem(SIGIAutoRentLine; "SIGIAutoRentLine")
            {
                DataItemLink = "Document No." = field("Nr.");

                column(Line_No_; "Line No.") { }
                column(Type; Type) { }
                column(Nr_; "Nr.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Amount; Amount) { }
            }
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'rdl/AutoRent.rdl';
        }
    }

    labels
    {
        ReportName = 'Automobilio nuomos išdavimo kortelės spausdinys';
    }
}
