<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Browse-Resources.aspx.vb" Inherits="BrowseResources" %>
<asp:Content ID="contentChildTitle" ContentPlaceHolderID="cphMasterTitle"
    runat="server">
    <asp:literal ID="ltltitle" runat="server">Browse-Resources</asp:literal>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <form id="frmBrowseResources" runat="server">
 <!-- region content - used for the site main content -->
   <section id="w-content" class="region">
    <div class="region-inner clearfix">
	 <div class="block twelve ps-nested">
	  <div class="block-inner clearfix">
       <div id="title-block" class="block seven">
		<div class="block-inner">
		 <div class="block-content">
		 <!-- replace with page title -->
		 <h1 id="page-title" class="block-title">Resources List<a class="add-icon" href="Resource-edit-page.aspx"">Add Resource</a></h1>
		      <!-- end - replace page title -->
		    </div>
		  </div>
		</div>
		
		<div id="title-right" class="block five">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with the real content -->
		   
		      <!-- end - replace with the real content -->
		    </div>
		  </div>
		</div>
		
	      </div>
	    </div>
	    
	    <div id="filters-menu" class="block twelve">
              <div class="block-inner">
		<div class="block-content">
		  <a class="filter-menu" href="#">Filters</a>
		</div>
	      </div>
	    </div>
                  
	    <div id="filters-top" class="block twelve ps-nested collapsible">
              <div class="block-inner">

		<div id="filters-search" class="block four search-form">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with search form -->
		    <%--<form action="/" method="post" id="search-block-form">--%>
			<div class="form-wrapper clearfix">
			  <div class="form-widget">
			    <label class="element-invisible" for="search-text">Search </label>
			    <div class="form-item form-item-text">
			      <%--<input title="Enter the terms you wish to search for." type="search" id="search-text" name="search_block_form" value="" class="form-text"/>--%>
			    <asp:TextBox ID="txtSearch" type="search" runat="server" CssClass="form-text"></asp:TextBox>
                </div>
			  </div>
              <div class="form-actions form-widget" id="form-actions">			   
                <asp:button id="btnSearch" runat="server" CssClass="form-submit" text="find resources" OnClick="btnSearch_Click" />
			  </div>			  
			</div>
		      <%--</form>--%>
		      <!-- end - replace with search form -->
		    </div>
		  </div>
		</div>

		<%--<form action="/" method="post" id="search-block-filters" class="filters-form" >--%>
		  <div class="form-wrapper clearfix">
		    
		    <div id="filters-publish-on" class="block three">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with first published form field -->
			    <label for="first-published-filter">Resource Type</label>
			    <%--<div class="form-item form-item-select">
                   <select id="first-published-filter" name="first-published" class="form-select">
				<option value="0" selected="selected">All resource types</option>
				<option value="30" >Website</option>
                <option value="40" >Educational</option>
                         <option value="50" >Training</option>
                         <option value="60" >Paper</option>
			      </select>
                </div> --%>
			    <div class="form-item form-item-select">
                    <asp:DropDownList ID="ddlResourceType_Filter" runat ="server" cssClass="form-select"  AppendDataBoundItems="true"
                        DataTextField="ResourceTypeLabel" DataValueField="ResourceTypeID">
                    <asp:ListItem Text="All resource types" Value ="all" Selected="True"></asp:ListItem>

                    </asp:DropDownList>
			  </div>			 
			  <!-- end - replace with first published form field -->
			</div>
		      </div>
		    </div>
		    
		    <div id="filters-constructs" class="block three">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  
			</div>
		      </div>
		    </div>
		    
		    <div id="filters-actions" class="block two">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with construct form field -->
               <div class="action-wrapper action-submit"><asp:button id="btnGo" runat="server" CssClass="form-submit" text="Go" OnClick="btngo_Click" /></div>
			  <div class="action-wrapper action-reset"><asp:button id="btnReset" runat="server" Text="Reset" CssClass="form-submit reset" OnClientClick="PageRedirect(); return false;"/></div>
             <!-- end - replace with construct form field -->
			</div>
		      </div>
		    </div>
		    
		  </div>
		<%--</form>--%>
	  
	      </div>
	    </div>
	    <div id="filters-alpha" class="block twelve ps-nested collapsible">
              <div class="block-inner">
		
		<div id="alpha-filter" class="block seven">
		  <div class="block-inner">
		    <div class="block-content">
		      
		    </div>
		  </div>
		</div>
		
		<div id="top-pager" class="block five">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with top pager -->
            <div id="top-pager-content">
		   	<asp:Repeater ID="rptPaging" runat="server" OnItemDataBound="rptPaging_OnItemDataBound">
                  <HeaderTemplate>
                      <ul class="pager-list">
                      <li class="filter-prev"><asp:HyperLink ID="hlPagingPrev" Text="Prev"  NavigateUrl="~/public/browse-resources.aspx?alp={alp}&pagenum=" runat="server"></asp:HyperLink></li>
                  </HeaderTemplate>
                  <ItemTemplate>
                     <li class="filter-1">
                         <asp:HyperLink ID="hlPaging" Text="<%# Container.DataItem %>" NavigateUrl='<%#"~/public/browse-resources.aspx?alp={alp}&pagenum=" & Container.DataItem%>' runat="server"></asp:HyperLink>                        
                     </li>
                   </ItemTemplate>
                  <FooterTemplate>
                      <li class="filter-next"><asp:HyperLink ID="hlPagingNext" Text="Next"  NavigateUrl="~/public/browse-resources.aspx?alp={alp}&pagenum=" runat="server"></asp:HyperLink></li>
                      </ul>
                  </FooterTemplate>
                </asp:Repeater>
            </div>
		    <!-- end - replace with top pager -->
		    </div>
		  </div>
		</div>
		
	      </div>
	    </div>
	    
	    <div id="main-content-area" class="block twelve ps-nested">
              <div class="block-inner">

		  <!-- replace with main page content -->
		 
        <asp:Repeater ID="rptResourcesList" runat="server">
             <HeaderTemplate>
           <table class="resources-table sortable" width="100%" border="0">
		    <tr>
		      <th scope="col"><a href="#" title="sort by Theory Name" class="sort_down">Name/Description</a></th>
		      <th scope="col">Resource Type</th>
		      <th scope="col">Related Theories</th>
              <th scope="col">Added By</th>
		    </tr>
            </HeaderTemplate>
            <ItemTemplate>
            <tr class="row-odd">
             <td><asp:hyperlink id="hlResourcetitle" runat= "server" class="resource-title" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceTitle")%></asp:hyperlink>                 
                   <%# HTPUtil.TruncateAtWord(Eval("ResourceDesc"), HTPUtil.BrowseResDescCount)%>
                   <asp:hyperlink ID="hlmore" runat="server" class="theory-more theory-more-link" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>' Visible ='<%# IIf((Eval("ResourceDesc").ToString().Length > HTPUtil.BrowseResDescCount), True, False)%>' Text="Read more"></asp:hyperlink>
             </td>
		     <td><%# DataBinder.Eval(Container.DataItem, "ResourceTypeLabel")%></td>
		            
		     <td>             
                     <asp:Repeater ID="rptTheoriesList" runat="server">
                     <ItemTemplate>                        
                         <asp:HyperLink ID="lbltheory" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' Text='<%#Bind("TheoryName")%>'></asp:HyperLink><br />
                     </ItemTemplate>
                 </asp:Repeater>
             <%-- <asp:HyperLink ID="AlltheoriesLink" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?at=2&TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' CssClass="more-constructs"></asp:HyperLink>              --%>
         
		     </td>
                <td><%# DataBinder.Eval(Container.DataItem, "CreateUser")%><br />(<%# Eval("CreateDT", "{0:d}")%>)</td> 
		    </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
            <tr class="row-even">
               <td><asp:hyperlink id="hlResourcetitle" runat= "server" class="resource-title" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceTitle")%></asp:hyperlink>                 
                <%# HTPUtil.TruncateAtWord(Eval("ResourceDesc"), HTPUtil.BrowseResDescCount)%>
                <asp:hyperlink ID="hlmore" runat="server" class="theory-more theory-more-link" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>' Visible ='<%# IIf((Eval("ResourceDesc").ToString().Length > HTPUtil.BrowseResDescCount), True, False)%>' Text="Read more"></asp:hyperlink>
             </td>
		     <td><%# DataBinder.Eval(Container.DataItem, "ResourceTypeLabel")%></td>
		        
		     <td>            
                     <asp:Repeater ID="rptTheoriesList" runat="server">
                     <ItemTemplate>                      
                         <asp:HyperLink ID="lbltheory" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' Text='<%#Bind("TheoryName")%>'></asp:HyperLink><br />
                     </ItemTemplate>
                 </asp:Repeater>
		     </td>
                <td><%# DataBinder.Eval(Container.DataItem, "CreateUser")%><br />(<%# Eval("CreateDT", "{0:d}")%>)</td> 
		    </tr>
		    </tr>
            </AlternatingItemTemplate>
            <FooterTemplate>
                <tr id="tremptydata" runat="server" visible="false">
                    <td colspan="4" style="text-align:center;">
                        <asp:Label ID="lblEmptyData" Font-Bold="true" runat="server" Visible="false" Text="No Resources" />
                    </td>
                </tr>
                </table>
            </FooterTemplate>
                  </asp:Repeater>
	<div id="bottom-pager">
         </div>
        
		  <!-- end - replace with main page content -->

	      </div>
	    </div>
	    
          </div>
        </section>
</form>     
        <!-- region below the main content - can be used for extra blocks -->
     
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="jsHolder" Runat="Server">   
                 
    
    <script type="text/javascript">
      $(document).ready(function () {
        $('#bottom-pager').append($('#top-pager-content').html());

        $('body').removeClass("frontpage");
      });

      function PageRedirect() {
        window.location.href = "/public/browse-resources.aspx";
      }
    </script>
          
          
          
          
                            
</asp:Content>
         
