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
                field(servicePriority; ServicePriority)
                {
                    trigger OnValidate();
                    begin
                        Rec.ValidateAPIValue(Rec.FieldNo("TKA Service Priority"), ServicePriority);
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
        AssignedSalesperson, ServiceStatus, ServicePriority, ServiceType, ServiceSourceDepartment : Text[50];
        NoCustomerDefinedErr: Label 'Pro tisk požadavků musí být určen zákazník.';

    /// <summary>
    /// printServiceOrder.
    /// </summary>
    /// <param name="projectReportKey">Text[50].</param>
    /// <param name="sendToEmail">Text.</param>
    /// <returns>Return value of type Text.</returns>
    [ServiceEnabled]
    procedure printServiceOrder(projectReportKey: Text[50]; sendToEmail: Text): Text
    var
        SalesHeader: Record "Sales Header";
        TKAProjectDocument: Record "TKA Project Document";

        TKASWProjectEMasterMgmt: Codeunit "TKA SW Project E-Master Mgmt.";

        AttachmentRecordRef: RecordRef;
    begin
        if Rec."Sell-to Customer No." = '' then
            Error(NoCustomerDefinedErr);

        // Init Email
        TKASWProjectEMasterMgmt.InitEmail(projectReportKey, sendToEmail);
        // Load Project Report Configuration
        TKASWProjectEMasterMgmt.GetProjectReportSetting(projectReportKey, TKAProjectDocument);

        // Create report as an attachment and attach to newly created email
        SalesHeader.SetRange("Document Type", Rec."Document Type");
        SalesHeader.SetRange("No.", Rec."No.");
        AttachmentRecordRef.SetTable(SalesHeader);
        TKASWProjectEMasterMgmt.AddAttachment(TKAProjectDocument."TKA Report Object No.", TKAProjectDocument."TKA Report Attachment Name", AttachmentRecordRef);

        // Send
        TKASWProjectEMasterMgmt.SendEmail();
    end;

    /// <summary>
    /// printAllServiceOrdersByResourceGroup.
    /// </summary>
    /// <param name="projectReportKey">Text[50].</param>
    /// <param name="sendToEmail">Text.</param>
    /// <param name="limitToResourceGroups">Text.</param>
    /// <returns>Return value of type Text.</returns>
    [ServiceEnabled]
    procedure printAllServiceOrdersByResourceGroup(projectReportKey: Text[50]; sendToEmail: Text; limitToResourceGroups: Text): Text
    var
        Resource: Record Resource;
        SalesHeader: Record "Sales Header";
        TKAProjectDocument: Record "TKA Project Document";
        TempTKAServiceBatch: Record "TKA Service Batch" temporary;

        TKASWProjectEMasterMgmt: Codeunit "TKA SW Project E-Master Mgmt.";

        AttachmentRecordRef: RecordRef;
        SalespersonFilter: Text;
    begin
        if Rec."Sell-to Customer No." = '' then
            Error(NoCustomerDefinedErr);

        // Init Email
        TKASWProjectEMasterMgmt.InitEmail(projectReportKey, sendToEmail);
        // Load Project Report Configuration
        TKASWProjectEMasterMgmt.GetProjectReportSetting(projectReportKey, TKAProjectDocument);

        // Create report as an attachment and attach to newly created email
        SalesHeader.SetRange("Document Type", Rec."Document Type");
        SalesHeader.SetRange("No.", Rec."No.");

        // Apply filters
        Clear(SalesHeader);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        SalesHeader.SetRange("TKA SWEM Service Order", true);
        // TODO limit to sales headers with specific service status?
        if limitToResourceGroups <> '' then begin
            Resource.SetRange(Blocked, false);
            Resource.SetFilter("TKA SWEM Salesperson Code", '<>''''');
            Resource.SetFilter("Resource Group No.", limitToResourceGroups);

            SalespersonFilter := '';
            if Resource.FindSet() then
                repeat
                    if StrPos(SalespersonFilter, Resource."TKA SWEM Salesperson Code") = 0 then begin
                        if SalespersonFilter <> '' then
                            SalespersonFilter += '|';
                        SalespersonFilter += Resource."TKA SWEM Salesperson Code";
                    end;
                until Resource.Next() = 0;

            if SalespersonFilter <> '' then
                SalesHeader.SetFilter("Salesperson Code", SalespersonFilter);
        end;

        // Find All Used Batch Codes in selected documents
        Rec.CreateDistinctBatchCodesBuffer(SalesHeader, TempTKAServiceBatch);

        // Create different attachment file for each batch code
        TempTKAServiceBatch.SetFilter("TKA Code", '<>''''');
        if TempTKAServiceBatch.FindSet() then
            repeat
                SalesHeader.SetRange("TKA Service Batch Code Filter", TempTKAServiceBatch."TKA Code");
                AttachmentRecordRef.SetTable(SalesHeader);
                TKASWProjectEMasterMgmt.AddAttachment(TKAProjectDocument."TKA Report Object No.", TKAProjectDocument."TKA Report Attachment Name", AttachmentRecordRef);
            until TempTKAServiceBatch.Next() = 0;

        // Look for documents without service batch code
        TempTKAServiceBatch.SetRange("TKA Code", '');
        if not TempTKAServiceBatch.IsEmpty() then begin
            SalesHeader.SetRange("TKA Service Batch Code Filter", '');
            AttachmentRecordRef.SetTable(SalesHeader);
            TKASWProjectEMasterMgmt.AddAttachment(TKAProjectDocument."TKA Report Object No.", TKAProjectDocument."TKA Report Attachment Name", AttachmentRecordRef);
        end;

        // Send
        TKASWProjectEMasterMgmt.SendEmail();
    end;
}

