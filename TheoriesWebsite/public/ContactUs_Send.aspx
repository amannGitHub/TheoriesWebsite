<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="ContactUs_Send.aspx.vb" Inherits="public_ContactUs_Send" %>

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
              <asp:Label id ="lblMessage" runat="server" Font-Bold="true" ForeColor="Red">Your message has been sent.  Thank you for your feedback!</asp:Label>
                  
              <br /> <br />   <br /> <br />   <br /> <br />   <br /> <br />  
              
              
              
                      
			  </div>		    
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
     
</asp:Content>

