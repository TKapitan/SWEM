/// <summary>
/// Page TKA Resource Prices API (ID 81008).
/// </summary>
page 81008 "TKA Resource Prices API"
{
    Caption = 'resourcePricesAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'resourcePrice';
    EntitySetName = 'resourcePrices';

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    SourceTable = "Price List Line";

    SourceTableView = sorting("Work Type Code", "Unit Price") order(ascending) where("Price Type" = filter(Any | Sale), "Amount Type" = filter(Price), "Asset Type" = filter(Resource | "Resource Group"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(amountType; Rec."Amount Type") { }
                field(assetNo; Rec."Asset No.") { }
                field(workTypeCode; Rec."Work Type Code") { }
                field(unitPrice; Rec."Unit Price") { }
            }
        }
    }
}
