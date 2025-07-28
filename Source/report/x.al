report 74011 AutoRentHistory
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Automobilio nuomos istorija';
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(SIGIAuto; SIGIAuto)
        {

            column(Nr_; "Nr.") { }
            column(Mark; Mark) { }
            column(Model; Model) { }

            dataitem(SIGIAutoRentHeader; SIGIAutoRentHeader)
            {
                // suggestive filter that pops up for user in UI to fill in
                RequestFilterFields = "ReservedFrom", "ReservedTo";

                DataItemLink = "Auto No." = field("Nr.");

                column(ReservedFrom; ReservedFrom) { }
                column(ReservedTo; ReservedTo) { }
                column(Client_Name; "Client Name") { }
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

        actions
        {
            area(processing)
            {
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'rdl/AutoRentHistory.rdl';
        }
    }

    labels
    {
        ReportName = 'Automobilio nuomos istorijos spausdinys';
    }
}
