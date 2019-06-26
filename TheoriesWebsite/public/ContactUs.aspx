<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="ContactUs.aspx.vb" Inherits="public_ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
     <asp:literal ID="ltltitle" runat="server">Contact Us</asp:literal>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
   <%--<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>--%>
<style type="text/css">
        .txtMargin
        {
            margin:0 0 0 0;
        }
        .txtClear{
            clear:both;
        }
        .txtcnt{
          max-width:300px;

        }
       /*.autocomplete_listItem
        {
            background-color: #222;
            color: #cfdbe6;
            list-style-type:none;
        }

        .autocomplete_highlightedListItem
        {
            background-color: #999;
            color: #111;
            list-style-type:none;
        }

        .autocomplete_completionListElement
        {
            list-style-type:none;
        }*/
       .completionList {
            border:solid 1px #444444;
            margin:0px;
            padding:2px;
            height: 100px;
            overflow:auto;
            background-color: #FFFFFF;
        }

            .listItem {
            color: #1C1C1C;
            }

            .itemHighlighted {
            background-color: #e3ebef;
            }
            .ui-state-disabled{
                opacity: .75;
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
		      <h1 id="page-title" class="block-title"><asp:label ID="lbltitle" runat="server" >Contact Us</asp:label></h1>
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
			
		
	      </div>
	    </div>
	    
	    <div id="main-content-area" class="block twelve ps-nested">
              <div class="block-inner">
		
		<div id="theory-summary" class="block eleven ps-no-left-right">
		  <div class="block-inner">
		    <div class="block-content">
		      
		      <div class="field-type-text field-name-field-title form-wrapper" id="edit-field-title">
			<div class="form-item form-item-field-title-value clearfix">
              We would love to hear from you. Please use the form below to send us a message. Feel free to share ideas for 
              improving the site!
              <br /> <br />               
              <asp:Label id ="lblMessage" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                              
			  <label for="edit-field-title-value">Your Name</label>                
                <asp:TextBox ID="txtname" runat="server" CssClass="text-full form-text" size="60"></asp:TextBox>             	
			</div>
		      </div>	
              <div class="field-item field-theory-year-first-published clearfix">	      
			   <label for="edit-field-title-value">Your Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="text-full form-text" size="60"></asp:TextBox>                
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                  ControlToValidate="txtEmail" ErrorMessage="Please enter valid email address." Display="Dynamic" 
                  ValidationExpression="[\w\.-]*[a-zA-Z0-9_']*[a-zA-Z0-9_]@[\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]" 
                  ValidationGroup="InsertValidation" >
                </asp:RegularExpressionValidator>
		      </div>
		       <div class="field-item field-theory-year-first-published clearfix">	
			<div class="form-item form-item-field-description-value clearfix">
			  <label for="edit-field-description-value">Your comments (limit 500 characters)               
			  </label>
                <asp:TextBox ID="txtComments" runat="server" MaxLength="500" CssClass="text-full form-textarea" Rows="10" Columns="100" TextMode="MultiLine" ></asp:TextBox>             
              <asp:Label CssClass ="txtcnt" ID ="txtCommentsCnt" runat="server"  Text="500"
                AssociatedControlID="txtComments"></asp:Label>characters left              
			 </div>
		      </div>
		      <div class="form-actions form-wrapper" id="edit-actions1">
                  <asp:Button ID="btncancel1" CssClass="btncancel form-submit" OnClientClick="if(!FirmConfirm()) return false;" runat ="server" Text="Cancel" OnClick="btncancel1_Click" />
                   <asp:Button ID="btnsubmit1" CssClass="btnsave form-submit" runat ="server" Text="Send"  />
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
  <script type="text/javascript" src="Scripts/jsFunctions.js" >  </script>
  <script lang="JavaScript" type="text/javascript">
    
      function FirmConfirm() {
        if (confirm('Do you want to cancel?'))
          return true;
        else
          return false;
      }
    
      function ValidateInput() {
        
        var txtEmail = document.getElementById("<%=txtEmail.ClientID%>");
      
        //invalid email
        
        var email_check = /[\w\.-]*[a-zA-Z0-9_']*[a-zA-Z0-9_]@[\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]/;
                
        if (txtEmail.value != "") {
          if (!email_check.test(txtEmail.value)) {
            alert("Please enter valid email address.");
            return false;
          }
        }
        return true;
      }
    
      $(document).ready(function () {
        $('body').removeClass("frontpage");
      });
 

</script>
   
</asp:Content>

