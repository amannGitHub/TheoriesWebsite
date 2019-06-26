<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="true" CodeFile="Resource-edit-page.aspx.vb" Inherits="public_Resource_edit_page" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
        <asp:literal ID="ltltitle" runat="server">Add Resource</asp:literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
     .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.8;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 3px;
        border-style: solid;
        border-color: black;
        padding-top: 20px;
        padding-left: 10px;
        width: 400px;
        height: 140px;
    }

    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
       <form id="formedit" runat="server">
        <asp:ScriptManager ID="SM1" runat="server" />
        <!-- region content - used for the site main content -->
        <section id="w-content" class="region">
          <div class="region-inner clearfix">
	    
	    <div class="block twelve ps-nested title-row">
	      <div class="block-inner clearfix">

		<div id="title-block" class="block six ps-no-bottom">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with page title -->
		      <h1 id="page-title" class="block-title"><asp:label ID="lbltitle" runat="server" ></asp:label></h1>
		      <!-- end - replace page title -->
		    </div>
		  </div>
		</div>
		
		<div id="display-mode" class="block three ps-no-bottom">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with the real content -->
		     <asp:literal ID="ltlmode" runat="server" Text =""></asp:literal>
		      <!-- end - replace with the real content -->
		    </div>
		  </div>
		</div>
		
		<div id="title-right" class="block three ps-no-bottom">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with the real content -->
		      <p class="theory-more">
			<asp:hyperlink id="hlexit" runat="server" CssClass="theory-more-link">Exit Edit Mode</asp:hyperlink>
		      </p>
		      <!-- end - replace with the real content --> 
		    </div>
		  </div>
		</div>
		
	      </div>
	    </div>
         <div id="main-content-area" class="block twelve ps-nested">
        <div class="block-inner">
		
		<div id="theory-summary" class="block eleven ps-no-left-right">
		  <div class="block-inner">
		    <div class="block-content">
                  <asp:Panel ID="pnlMain" runat="server" Visible="true">	     
                       <!-- Resouce Name-->
                <div class="field-item field-theory-year-first-published clearfix">
			        <span class="field-label">Resource Name *</span>
			        <asp:TextBox ID="txtResourceName" runat="server" CssClass="text-full form-text" size="155" MaxLength="500" CausesValidation="true"></asp:TextBox>
                   <span style="display:block"> <asp:RequiredFieldValidator runat="server" ControlToValidate="txtResourceName"
                    CssClass="text-danger" ErrorMessage="The resource name field is required." /></span>
		      </div>
                  
		      <div class="field-type-text field-name-field-title form-wrapper" id="edit-field-title">
			<div class="form-item form-item-field-title-value clearfix">
                <asp:HiddenField ID="hdTab" runat="server" Value="" />
			  <label for="edit-field-title-value">Description</label>
                <asp:HiddenField ID="hdTheoryID" runat="server" />
                <asp:TextBox ID="txtDescription"  runat="server" 
                    CssClass="text-full form-textarea" Rows="6" Columns="158" TextMode="MultiLine" 
                    AutoPostBack="true">

                </asp:TextBox>
				</div>
		      </div>
		      
                        <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Resource Type *</span>
		  <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="form-select" Width="180px"
                        AppendDataBoundItems="true"
                        DataTextField="ResourceTypeDesc" DataValueField="ResourceTypeID">
              <asp:ListItem Text="" Value="">Select One</asp:ListItem>
               </asp:DropDownList>  
               <asp:RequiredFieldValidator ID="Req2" runat="server" ControlToValidate="ddlResourceType" InitialValue="" Display="Dynamic" />
		  
		      </div>
		       <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">URL</span>
			 <asp:TextBox ID="txtURL" runat="server" CssClass="text-full form-text" size="80" MaxLength="1000"></asp:TextBox>
		      </div>


                

		      <div class="form-actions form-wrapper" id="edit-actions1">
                      <asp:Button ID="btnSubmit" CssClass="btnsave form-submit" runat ="server" Text="Save" />
                  <asp:Button ID="btncancel1" CssClass="btncancel form-submit"  runat ="server" Text="Cancel"  OnClientClick="if(!FirmConfirm()) return false;"  OnClick="btncancel1_Click" />
               
		 </div>
                      </asp:Panel>	
	  <asp:Panel ID="pnlConfirm" runat="server" align="center" Visible="False" >
   <span class="field-label">A resource with this URL already exists in the database. Do you still want to add this resource?</span>
                    <br />  <br />
     <asp:Button ID="btnOk" CssClass="btnsave form-submit"  runat ="server" Text="Yes"/>
    <asp:Button ID="btnNo" CssClass="btncancel form-submit" runat ="server" Text="No" />
</asp:Panel>
		    </div>		    
		  </div>
		</div>
                  </div>
              </div>
              </div>
              </section>
           </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JsHolder" Runat="Server">
     <script type="text/javascript">
        $(document).ready(function () {
           
                $("li").addClass("active active-trail");
                $('body').removeClass("frontpage").addClass("theory-detail");
        });

      

</script>

</asp:Content>


