/// <summary>
/// Page TKA Sales Service Orders API (ID 81009).
/// </summary>
page 81009 "TKA Sales Service Orders API"
{
    Caption = 'salesServiceOrdersAPI', Locked = true;
    PageType = API;
    APIPublisher = 'keptyCZ';
    APIGroup = 'swProjectEMaster';
    APIVersion = 'v1.0';
    EntityName = 'salesServiceOrder';
    EntitySetName = 'salesServiceOrders';

    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    DelayedInsert = true;

    SourceTable = "Sales Header";
    SourceTableView = where("TKA SWEM Service Order" = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(no; Rec."No.")
                {
                    Editable = false;
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.") { }
                field(serviceOrderDescription; Rec."TKA Service Order Description") { }
                field(externalDocumentNumber; Rec."External Document No.") { }
                field(salespersonCode; AssignedSalesperson)
                {
                    trigger OnValidate();
                    begin
                        Rec.ValidateAPIValue(Rec.FieldNo("Salesperson Code"), AssignedSalesperson);
                    end;
                }
                field(serviceStatus; ServiceStatus)
                {
                    trigger OnValidate();
                    begin
                        Rec.ValidateAPIValue(Rec.FieldNo("TKA Service Status"), ServiceStatus);
                    end;
                }
                field(serviceType; ServiceType)
                {
                    trigger OnValidate();
                    begin
                        Rec.ValidateAPIValue(Rec.FieldNo("TKA Service Type"), ServiceType);
                    end;
                }
                field(serviceSourceDepartment; ServiceSourceDepartment)
                {
                    trigger OnValidate();
                    begin
                        Rec.ValidateAPIValue(Rec.FieldNo("TKA Service Source Department"), ServiceSourceDepartment);
                    end;
                }
                field(servicePlannedQty; Rec."TKA Service Planned Qty.") { }
                part(salesServiceOrderLines; "TKA Sales Ser. Order Lines API")
                {
                    ApplicationArea = All;
                    Caption = 'Lines';
                    EntityName = 'salesServiceOrderLine';
                    EntitySetName = 'salesServiceOrderLines';
                    SubPageView = where("Document Type" = const(Order));
                    SubPageLink = "Document No." = field("No.");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        SalesHeader: Record "Sales Header";

        ExternalDocNoAlreadyExistsErr: Label 'External Document No. %1 already exists and due to this new document can not be created.', Comment = '%1 - external document no.';
    begin
        Rec.TestField("External Document No.");

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("External Document No.", Rec."External Document No.");
        SalesHeader.SetRange("TKA SWEM Service Order", true);
        if not SalesHeader.IsEmpty() then
            Error(ExternalDocNoAlreadyExistsErr, Rec."External Document No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Document Type", Rec."Document Type"::Order);
        Rec.Validate("TKA SWEM Service Order", true);
        Rec.Validate("TKA SWEM Service Ord. from API", true);
    end;

    trigger OnAfterGetRecord()
    begin
        AssignedSalesperson := Rec.GetAPIValue(Rec.FieldNo("Salesperson Code"));
        ServiceStatus := Rec.GetAPIValue(Rec.FieldNo("TKA Service Status"));
        ServiceType := Rec.GetAPIValue(Rec.FieldNo("TKA Service Type"));
        ServiceSourceDepartment := Rec.GetAPIValue(Rec.FieldNo("TKA Service Source Department"));
    end;

    var
        AssignedSalesperson, ServiceStatus, ServiceType, ServiceSourceDepartment : Text[50];
}

