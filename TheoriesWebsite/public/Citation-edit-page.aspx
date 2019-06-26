<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Citation-edit-page.aspx.vb" Inherits="public_Citation_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
        <asp:literal ID="ltltitle" runat="server">Add Citation</asp:literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
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
			<asp:hyperlink id="hlexit" runat="server" CssClass="theory-more-link" text=""></asp:hyperlink>
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
		      
		      <div class="field-type-text field-name-field-title form-wrapper" id="edit-field-title">
			<div class="form-item form-item-field-title-value clearfix">
                <asp:HiddenField ID="hdTab" runat="server" Value="" />
			  <label for="edit-field-title-value">Citation</label>
                <asp:HiddenField ID="hdTheoryID" runat="server" />
                <asp:TextBox ID="txtCitation" OnTextChanged="txtCitation_TextChanged" runat="server" 
                    CssClass="text-full form-textarea" Rows="4" Columns="158" TextMode="MultiLine" 
                    AutoPostBack="true">

                </asp:TextBox>
		<%--	  <input class="text-full form-text" type="text" id="edit-field-title-value" name="field-title" value="Health Belief Model (HBM)" size="60" />--%>
			</div>
		      </div>
		      <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Title</span>
			 <asp:TextBox ID="txtTitle" runat="server" CssClass="text-full form-text" size="155"></asp:TextBox>
		      </div>
                 <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Publication Year</span>
			 <asp:TextBox ID="txtPubYear" runat="server" CssClass="text-full form-text" size="10"></asp:TextBox>
		      </div>
                  <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Author(s)</span>
			 <asp:TextBox ID="txtAuthor" runat="server" CssClass="text-full form-text" size="60"></asp:TextBox>
		      </div>
                 <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Publication Type</span>
		  <asp:DropDownList ID="ddlPubType_filter" runat="server" CssClass="form-select" Width="180px"
                        AppendDataBoundItems="true"
                        DataTextField="PubTypeAbbr" DataValueField="PubTypeID">
                <asp:ListItem Text="" Value="">Select One</asp:ListItem>
                        <%--<asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem>--%>
             </asp:DropDownList>  
		      </div>
		       <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Available online</span>
			 <asp:TextBox ID="txtAvOnline" runat="server" CssClass="text-full form-text" size="60"></asp:TextBox>
		      </div>
                 <%--<div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Journal</span>
			 <asp:TextBox ID="txtJournal" runat="server" CssClass="text-full form-text" size="20"></asp:TextBox>
		      </div>--%>
                 <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">PubMed ID</span>
			 <asp:TextBox ID="txtPubMedID" runat="server" CssClass="text-full form-text" size="20"></asp:TextBox>
		      </div>
                 <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">DOI</span>
			 <asp:TextBox ID="txtDOI" runat="server" CssClass="text-full form-text" size="20"></asp:TextBox>
		      </div>


		      <div class="form-actions form-wrapper" id="edit-actions1">
                     <asp:Button ID="btnSubmit" CssClass="btnsave form-submit" runat ="server" Text="Save" OnClick="btnSubmit_Click" />
                  <asp:Button ID="btncancel1" CssClass="btncancel form-submit" OnClientClick="if(!FirmConfirm()) return false;" runat ="server" Text="Cancel" OnClick="btncancel1_Click" />
               
		 </div>
	  
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

