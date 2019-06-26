<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Bibliography.aspx.vb" Inherits="public_Bibliography" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
     <asp:literal ID="ltltitle" runat="server">Bibliography</asp:literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
     .theories-table tr td:nth-child(5),.theories-table tr th:nth-child(5) 
     {
      /*width: 15%;*/
        text-align: center;
    }

    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
 <form id="frmBibliography" runat="server">
    <!-- region content - used for the site main content -->
   <section id="w-content" class="region">
    <div class="region-inner clearfix">
	 <div class="block twelve ps-nested">
	  <div class="block-inner clearfix">
       <div id="title-block" class="block seven">
		<div class="block-inner">
		 <div class="block-content">
		 <!-- replace with page title -->
		 <h1 id="page-title" class="block-title">Bibliography<a class="add-icon" href="Citation-edit-page.aspx">Add Citation</a></h1>
		      <!-- end - replace page title -->
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
			<div class="form-wrapper clearfix">
			  <div class="form-widget">
			    <label class="element-invisible" for="search-text">Search </label>
			    <div class="form-item form-item-text">
			<%--      <input title="Enter the terms you wish to search for." type="search" id="search-text" name="search_block_form" value="" class="form-text"/>
			--%>    
                     <asp:TextBox ID="txtSearch" type="search" runat="server" CssClass="form-text"></asp:TextBox>
			    </div>
			  </div>
			  <div class="form-actions form-widget" id="form-actions">
                     <asp:button id="btnSearch" runat="server" CssClass="form-submit" text="search citation" OnClick="btnSearch_Click" />
			
			 <%--   <input type="submit" id="form-submit" name="op" value="search citation" class="form-submit"/>--%>
			  </div>
			</div>

		      <!-- end - replace with search form -->
		    </div>
		  </div>
		</div>

<%--		<form action="/" method="post" id="search_block_filters" class="filters-form" runat="server">--%>
		  <div class="form-wrapper clearfix">
		    
		    <div id="filters-publish-on" class="block three">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with construct form field -->
			    <label for="construct-filter">Publication Type</label>
			    <div class="form-item form-item-select">
                    <asp:DropDownList ID="ddlPubType_filter" runat="server" CssClass="form-select" Width="100px"
                        AppendDataBoundItems="true"
                        DataTextField="PubTypeAbbr" DataValueField="PubTypeID">
                        <asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem></asp:DropDownList>
               
			  </div>
			  <!-- end - replace with construct form field -->
			</div>
		      </div>
		    </div>
		    
		    
		    <div id="filters-constructs" class="block three">
   <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with first published form field -->
			    <label for="first-published-filter">Published on or after</label>
                <asp:DropDownList ID="ddlPubYear_Filter" runat ="server" ssClass="form-select"  AppendDataBoundItems="true"
                        DataTextField="YearPublished" DataValueField="YearPublished">
                    <asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem></asp:DropDownList>
			    </div>
		      </div>
		    </div>
		    
		    <div id="filters-actions" class="block two">
		      <div class="block-inner">
			<div class="block-content form-widget">
			  <!-- replace with construct form field -->
			  <div class="action-wrapper action-submit"><asp:button id="btnGo" runat="server" CssClass="form-submit" text="Go" OnClick="btngo_Click" /></div>
			  <div class="action-wrapper action-reset"><asp:button id="btnReset" runat="server" Text="Reset" CssClass="form-submit reset"  OnClientClick="PageRedirect(); return false;"/></div>
			  <!-- end - replace with construct form field -->
			</div>
		      </div>
		    </div>
		    
		  </div>
<%--		</form>--%>
	  
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
                            <asp:HyperLink ID="hlAlpPaging" Text="<%# Container.DataItem %>" NavigateUrl='<%#"~/public/Bibliography.aspx?alp=" & Container.DataItem & "&pagenum={pagenum}"%>' runat="server"></asp:HyperLink>
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
                      <li class="filter-prev"><asp:HyperLink ID="hlPagingPrev" Text="Prev"  NavigateUrl="~/public/Bibliography.aspx?alp={alp}&sc={sortcolumn}&so={sortorder}&pagenum=" runat="server"></asp:HyperLink></li>
                  </HeaderTemplate>
                  <ItemTemplate>
                     <li class="filter-1">
                         <asp:HyperLink ID="hlPaging" Text="<%# Container.DataItem %>" NavigateUrl='<%#"~/public/Bibliography.aspx?alp={alp}&sc={sortcolumn}&so={sortorder}&pagenum=" & Container.DataItem%>' runat="server"></asp:HyperLink>                        
                     </li>
                   </ItemTemplate>
                  <FooterTemplate>
                      <li class="filter-next"><asp:HyperLink ID="hlPagingNext" Text="Next"  NavigateUrl="~/public/Bibliography.aspx?alp={alp}&sc={sortcolumn}&so={sortorder}&pagenum=" runat="server"></asp:HyperLink></li>
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
		 
        <asp:Repeater ID="rptBibliography" runat="server" OnItemCommand="rptBibliography_ItemCommand">
             <HeaderTemplate>
           <table class="theories-table sortable" width="100%" border="0">
		    <tr>
		      <th scope="col" style="width:35%;"><asp:linkbutton ID="lnbCitation"  runat="server" CommandName="Title">Citation</asp:linkbutton></th>
		      <th scope="col" style="width:9%;"><asp:linkbutton ID="lnbPubType"  runat="server" CommandName="PubType">Pub Type</asp:linkbutton></th>
		      <th scope="col" style="width:9%;"><asp:linkbutton ID="lnbYearPublished"  runat="server" CommandName="YearPublished">Pub Year</asp:linkbutton></th>
		      <th scope="col" style="width:26%;">Theories</th>
              <th scope="col">Pub Med ID</th>
              <th scope="col" style="width:10%"><asp:linkbutton ID="lnbDateAdded"  runat="server" CommandName="DateAdded">Date Added</asp:linkbutton></th> 
		    </tr>
            </HeaderTemplate>
            <ItemTemplate>
            <tr class="row-odd">
             
                <td><asp:Label id="hlCitation" runat= "server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label></td>
           		<td><%# DataBinder.Eval(Container.DataItem, "PubType")%></td>
		        <td><%# DataBinder.Eval(Container.DataItem, "YearPublished")%></td>                
		        <td>
                  <asp:Repeater ID="rptTheoriesList" runat="server">
                     <ItemTemplate>                        
                         <asp:HyperLink ID="hlTheory" runat="server" NavigateUrl='<%#String.Format("~/public/Theory_details.aspx?TID={0}", Eval("TheoryID"))%>' Text='<%#Bind("TheoryName")%>'></asp:HyperLink><br />
                     </ItemTemplate>
                 </asp:Repeater>   
                <asp:HyperLink ID="AllTheoriesLink" runat="server" NavigateUrl='#' CssClass="more-constructs"></asp:HyperLink>            
		        </td>
                <td><asp:hyperlink runat="server" ID="hlPubMed" class="theory-title" visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>' NavigateUrl='<%#"http://www.ncbi.nlm.nih.gov/pubmed/" & DataBinder.Eval(Container.DataItem, "PubMedID")%>'  Target="_blank"><%# DataBinder.Eval(Container.DataItem, "PubMedID")%></asp:hyperlink></td>
                <td><%# DataBinder.Eval(Container.DataItem, "DateAdded", "{0:MM/dd/yyyy}")%></td>
		    </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
              <tr class="row-even">
                <td><asp:Label id="hlCitation" runat= "server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label></td>
                <td><%# DataBinder.Eval(Container.DataItem, "PubType")%></td>
		        <td><%# DataBinder.Eval(Container.DataItem, "YearPublished")%></td>                
		        <td>
                  <asp:Repeater ID="rptTheoriesList" runat="server">
                     <ItemTemplate>                        
                         <asp:HyperLink ID="hlTheory" runat="server" NavigateUrl='<%#String.Format("~/public/Theory_details.aspx?TID={0}", Eval("TheoryID"))%>' Text='<%#Bind("TheoryName")%>'></asp:HyperLink><br />
                     </ItemTemplate>
                 </asp:Repeater>   
                <asp:HyperLink ID="AllTheoriesLink" runat="server" NavigateUrl='#' CssClass="more-constructs"></asp:HyperLink>            
		        </td>
                <td><asp:hyperlink runat="server" ID="hlPubMed" class="theory-title" visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>' NavigateUrl='<%#"http://www.ncbi.nlm.nih.gov/pubmed/" & DataBinder.Eval(Container.DataItem, "PubMedID")%>'  Target="_blank"><%# DataBinder.Eval(Container.DataItem, "PubMedID")%></asp:hyperlink></td>
                <td><%# DataBinder.Eval(Container.DataItem, "DateAdded", "{0:MM/dd/yyyy}")%></td>
		    </tr>
            </AlternatingItemTemplate>
            <FooterTemplate>
                <tr id="tremptydata" runat="server" visible="false">
                    <td colspan="4" style="text-align:center;">
                        <asp:Label ID="lblEmptyData" Font-Bold="true" runat="server" Visible="false" Text="No Citations" />
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JsHolder" Runat="Server">
     <script type="text/javascript">
        $(document).ready(function () {
            $('#bottom-pager').append($('#top-pager-content').html());

            $('body').removeClass("frontpage");

        });
    </script>
                  
</asp:Content>

