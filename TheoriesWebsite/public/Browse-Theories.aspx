<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Browse-Theories.aspx.vb" Inherits="BrowseTheories" %>
<asp:Content ID="contentChildTitle" ContentPlaceHolderID="cphMasterTitle"
    runat="server">
    <asp:literal ID="ltltitle" runat="server">Browse-Theories</asp:literal>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   <form id="frmBrowseTheories" runat="server">
   <!-- region content - used for the site main content -->
   <section id="w-content" class="region">
    <div class="region-inner clearfix">
	 <div class="block twelve ps-nested">
	  <div class="block-inner clearfix">
       <div id="title-block" class="block seven">
		<div class="block-inner">
		 <div class="block-content">
		 <!-- replace with page title -->
		 <h1 id="page-title" class="block-title">Theories List<a class="add-icon" href="theory-edit-page.aspx">Add Theory</a></h1>
		      <!-- end - replace page title -->
		    </div>
		  </div>
		</div>
		
		<div id="title-right" class="block five">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with the real content -->
		      <a href="Theories_Timeline.aspx" class="theoryIcon">View Theories Timeline</a>
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
		   <%-- <form action="/" method="post" id="search-block-form">--%>
			<div class="form-wrapper clearfix">
			  <div class="form-widget">
			    <label class="element-invisible" for="search-text">Search </label>
			    <div class="form-item form-item-text">
			      <%--<input title="Enter the terms you wish to search for." type="search" id="search-text" name="search_block_form" value="" class="form-text"/>--%>
                    <asp:TextBox ID="txtSearch" type="search" runat="server" CssClass="form-text"></asp:TextBox>
			    </div>
			  </div>
			  <div class="form-actions form-widget" id="form-actions">			   
                <asp:button id="btnSearch" runat="server" CssClass="form-submit" text="find theories" OnClick="btnSearch_Click" />
			  </div>
			</div>
		      <%--</form>--%>
		      <!-- end - replace with search form -->
		    </div>
		  </div>
		</div>

	<%--	<form id="search_block_filters" class="filters-form" runat="server">--%>
		  <div class="form-wrapper clearfix">
		    
		    <div id="filters-publish-on" class="block three">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with first published form field -->
			    <label for="first-published-filter">First published on or after</label>
			    <%--<div class="form-item form-item-select">
			      <select id="first-published-filter" name="first-published" class="form-select">
				<option value="All" selected="selected">All</option>
				<option value="1875">1875</option>
				<option value="1876">1876</option>
				<option value="1877">1877</option>
				<option value="1878">1878</option>
				<option value="1879">1879</option>
				<option value="1880">1880</option>
			      </select>
			  </div>--%>
                  <div class="form-item form-item-select">
                    <asp:DropDownList ID="ddlPubYear_Filter" runat ="server" ssClass="form-select"  AppendDataBoundItems="true"
                        DataTextField="YearPublished" DataValueField="YearPublished">
                    <asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem></asp:DropDownList>
			  </div>
			  <!-- end - replace with first published form field -->
			</div>
		      </div>
		    </div>
		    
		    <div id="filters-constructs" class="block three">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with construct form field -->
			    <label for="construct-filter">Constructs</label>
			    <div class="form-item form-item-select">
                    <asp:DropDownList ID="ddlconstruct_filter" runat="server" CssClass="form-select" Width="180px"
                        AppendDataBoundItems="true"
                        DataTextField="ConstructName" DataValueField="ConstructID">
                        <asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
			    <%--<select id="construct-filter" name="construct-filter" class="form-select">
				    <option value="All" selected="selected">All</option>
				    <option value="Albumin Concentration" selected="selected">Albumin Concentration</option>
				    <option value="Fuga. Itate sum ipsam">Fuga. Itate sum ipsam</option>
				    <option value="Ptaque ratiat harunti">Ptaque ratiat harunti</option>
			    </select>--%>
			  </div>
			  <!-- end - replace with construct form field -->
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
	 <%--   </form>--%>
	  
	      </div>
	    </div>
	    <div id="filters-alpha" class="block twelve ps-nested collapsible">
              <div class="block-inner">
		
		<div id="alpha-filter" class="block seven">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with alpha filter -->
                <asp:Repeater ID="rptAlpPaging" runat="server" OnItemDataBound="rptAlpPaging_OnItemDataBound">
                    <HeaderTemplate>
                        <ul id="alpha-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="filter-A">
                            <asp:HyperLink ID="hlAlpPaging" Text="<%# Container.DataItem %>" NavigateUrl='<%#"~/public/browse-theories.aspx?alp=" & Container.DataItem & "&pagenum={pagenum}"%>' runat="server"></asp:HyperLink>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>

                        <li class="filter-View All"></li>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>
	         <!-- end - replace with alpha filter -->
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
                      <li class="filter-prev"><asp:HyperLink ID="hlPagingPrev" Text="Prev"  NavigateUrl="~/public/browse-theories.aspx?alp={alp}&sc={sortcolumn}&so={sortorder}&pagenum=" runat="server"></asp:HyperLink></li>
                  </HeaderTemplate>
                  <ItemTemplate>
                     <li class="filter-1">
                         <asp:HyperLink ID="hlPaging" Text="<%# Container.DataItem %>" NavigateUrl='<%#"~/public/browse-theories.aspx?alp={alp}&sc={sortcolumn}&so={sortorder}&pagenum=" & Container.DataItem%>' runat="server"></asp:HyperLink>                        
                     </li>
                   </ItemTemplate>
                  <FooterTemplate>
                      <li class="filter-next"><asp:HyperLink ID="hlPagingNext" Text="Next"  NavigateUrl="~/public/browse-theories.aspx?alp={alp}&sc={sortcolumn}&so={sortorder}&pagenum=" runat="server"></asp:HyperLink></li>
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
		 
        <asp:Repeater ID="rptTheoriesList" runat="server" OnItemCommand="rptTheoriesList_ItemCommand">
             <HeaderTemplate>
           <table class="theories-table sortable" width="100%" border="0">
		    <tr>
		      <th scope="col"><asp:linkbutton ID="lnbTheoryName"  runat="server" CommandName="TheoryName">Theory Name</asp:linkbutton></th>
		      <th scope="col">Description</th>
		      <th scope="col"><asp:linkbutton ID="lnbYearPublished"  runat="server" CommandName="YearPublished">Year First Published</asp:linkbutton></th>
		      <th scope="col">Constructs</th>
		    </tr>
            </HeaderTemplate>
            <ItemTemplate>
            <tr class="row-odd">
             <td><asp:hyperlink id="hlTheorytitle" runat= "server" class="theory-title" NavigateUrl='<%#"~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:hyperlink></td>
		     <td><asp:Label ID="lbltd" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TheoryDescription")%>'></asp:Label></td>
		     <td><%# DataBinder.Eval(Container.DataItem, "YearPublished")%></td>                
		     <td>
                 <asp:Repeater ID="rptConstructList" runat="server">
                     <ItemTemplate>                        
                         <asp:HyperLink ID="lblConstruct" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?at=2&TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' Text='<%#Bind("ConstructName")%>'></asp:HyperLink><br />
                     </ItemTemplate>
                 </asp:Repeater>
              <asp:HyperLink ID="AllConstructsLink" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?at=2&TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' CssClass="more-constructs"></asp:HyperLink>              

		     </td>
		    </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                 <tr class="row-even">
             <td><asp:hyperlink id="hlTheorytitle" runat= "server" class="theory-title" NavigateUrl='<%#"~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:hyperlink></td>
		      <td><asp:Label ID="lbltd" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TheoryDescription")%>'></asp:Label></td>
		      <td><%# DataBinder.Eval(Container.DataItem, "YearPublished")%></td>
		     <td>
                 <asp:Repeater ID="rptConstructList" runat="server">
                     <ItemTemplate>                        
                         <asp:HyperLink ID="lblConstruct" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?at=2&TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' Text='<%#Bind("ConstructName")%>'></asp:HyperLink><br />
                     </ItemTemplate>
                 </asp:Repeater>   
             <asp:HyperLink ID="AllConstructsLink" runat="server" NavigateUrl='<%#"~/public/Theory_details.aspx?at=2&TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>' CssClass="more-constructs"></asp:HyperLink>            
                <%--<a class="more-constructs" href="#">View all 7 constructs</a>--%>

		     </td>
		    </tr>
            </AlternatingItemTemplate>
            <FooterTemplate>
                <tr id="tremptydata" runat="server" visible="false">
                    <td colspan="4" style="text-align:center;">
                        <asp:Label ID="lblEmptyData" Font-Bold="true" runat="server" Visible="false" Text="No Theories" />
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
   <!-- region below the main content - can be used for extra blocks -->    
   </form>  
</asp:Content>
	    <asp:Content ID="Content3" ContentPlaceHolderID="jsHolder" Runat="Server">   
                 
    <script type="text/javascript">
        $(document).ready(function () {
            $('#bottom-pager').append($('#top-pager-content').html());

            $('body').removeClass("frontpage");
        });

        function PageRedirect() {
            window.location.href = "/public/browse-theories.aspx";
        }
    </script>
                      
</asp:Content>
         
