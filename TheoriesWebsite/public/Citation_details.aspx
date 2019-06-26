<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Citation_details.aspx.vb" Inherits="public_Citation_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
    <asp:literal ID="ltltitle" runat="server"></asp:literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
       <style type="text/css">
    .theories-table tr td:nth-child(3),.theories-table tr th:nth-child(3) {
     text-align: left;
}
         .slicknav_nav > li > a.active {
    background: #B55727;
    z-index: 10;
}
      

    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
   <form id="frmRepeater" runat="server">
        <asp:HiddenField ID="hdTab" runat="server" Value="" />
        <section id="w-content" class="region">
            <div class="region-inner clearfix">
                <div class="block twelve ps-nested title-row">
                    <div class="block-inner clearfix">
                        <div id="title-block" class="block nine">
                            <div class="block-inner">
                                <div class="block-content">
                                    <!-- replace with page title -->
                                    <h1 id="page-title" class="block-title">
                                        <asp:Label ID="lblTitle" runat="server"></asp:Label></h1>
                                    <!-- end - replace page title -->
                                </div>
                            </div>
                        </div>

                        <div id="title-right" class="block three">
                            <div class="block-inner">
                                <div class="block-content">
                                    <!-- replace with the real content -->
                                    <asp:HyperLink ID="hledit" runat="server" CssClass="theoryIcon editTheoryIcon">Edit Citation</asp:HyperLink>
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
                                    <div class="field-item field-theory-description clearfix">
                                        <asp:Label id="citation" runat="server" cssclass="field-label">Citation</asp:Label><br />
                                        <span class="field-content">
                                            <asp:Label ID="lblCitation" runat="server" CssClass="comment more" data-showchar="750"></asp:Label>                                           
                                        </span>
                                    </div>
                                    <div class="field-item field-theory-description clearfix" id="dvPubYear" runat="server">
                                        <span class="field-label">Publication Year</span><br />
                                        <span class="field-content">
                                            <asp:Label ID="lblyear" runat="server"></asp:Label>                                           
                                        </span>
                                    </div>
                                <div id="dvAuthor" runat ="server" class="field-item field-theory-description clearfix" visible="true">
                                        <span class="field-label" >Author(s)</span><br />
                                        <span class="field-content">
                                            <asp:Label ID="lblAuthor" runat="server"></asp:Label>                                           
                                        </span>
                                    </div>
                                     <div id="dvPubType" runat ="server"  class="field-item field-theory-description clearfix">
                                        <span class="field-label">Publication Type</span><br />
                                        <span class="field-content">
                                            <asp:Label ID="lblType" runat="server"></asp:Label>                                           
                                        </span>
                                    </div>
                                     <div id="dvAvOnline" runat ="server"  class="field-item field-theory-description clearfix">
                                        <span class="field-label">Available online</span><br />
                                        <span class="field-content">
                                            <asp:HyperLink ID="hlonline" runat="server" Target="_blank"></asp:HyperLink>                                           
                                        </span>
                                    </div>
                                    <div id="dvPubMedId" runat ="server"  class="field-item field-theory-description clearfix">
                                        <span class="field-label">PubMed ID</span><br />
                                        <span class="field-content">
                                           <asp:hyperlink ID="hlpubmedID" runat="server" Target="_blank"></asp:hyperlink>                                        
                                        </span>
                                    </div>
                                    <div id="dvDOI" runat ="server"  class="field-item field-theory-description clearfix">
                                        <span class="field-label" style="font-size: 12px;">DOI</span><br />
                                        <span class="field-content" style="font-size: 12px;">
                                            <asp:hyperlink ID="hlDOI" runat="server" Target="_blank"></asp:hyperlink>
                                        </span>
                                    </div>
                               </div>
                            </div>
                        </div>

                        <div id="theory-detail" class="block twelve ps-no-left-right">
                            <div class="block-inner">
                                <div class="block-content">
                                    <div id="ps-accordion-1" class="w-accordion">                                       
                                        <h3 class="ps-accordion-head theory-related">Related Theories</h3>
                                        <div class="ps-accordion-body theory-related">
                                            <asp:Repeater ID="rptRelatedTheories" runat="server" OnItemDataBound="rptRelatedTheories_ItemDataBound">
                                                <HeaderTemplate>
                                                    <table class="theories-table sortable" width="100%" border="0">
                                                        <tr>
                                                            <th scope="col">
                                                                <asp:LinkButton ID="lnbTheoryName" runat="server" class="" CommandName="TheoryName">Theory</asp:LinkButton></th>
                                                            <th scope="col" style="width: 55%">Description</th>
                                                            <%--<th scope="col">Key Constructs</th>--%>
                                                            <th scope="col" style="text-align: center; width: 10%;">Relevance</th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr class="row-odd">
                                                        <td>
                                                            <asp:HyperLink ID="hlTheoryName" runat="server" NavigateUrl='<%#"/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:HyperLink></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "TheoryDesc")%></td>
                                                        <%--<td>
                                                            <asp:Repeater ID="rptConstructList" runat="server">
                                                                <ItemTemplate>
                                                                    <asp:label ID="lblConstruct" runat="server" Text='<%#Bind("ConstructName")%>'></asp:label><br />
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </td>--%>
                                                      <td style="text-align: center"><%# DataBinder.Eval(Container.DataItem, "RelevanceLabel")%></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <AlternatingItemTemplate>
                                                    <tr class="row-even">
                                                        <td>
                                                            <asp:HyperLink ID="hlTheoryName" runat="server" NavigateUrl='<%#"/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:HyperLink></td>
                                                        <td><%# DataBinder.Eval(Container.DataItem, "TheoryDesc")%></td>

                                                        <%--<td>
                                                            <asp:Repeater ID="rptConstructList" runat="server">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblConstruct" runat="server" Text='<%#Bind("ConstructName")%>'></asp:Label><br />
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </td>--%>
                                                        <td style="text-align: center"><%# DataBinder.Eval(Container.DataItem, "Relevance")%></td>
                                                    </tr>
                                                </AlternatingItemTemplate>
                                                <FooterTemplate>
                                                    <tr id="tremptydata" runat="server" visible="false">
                                                        <td colspan="4">
                                                            <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No Related Theories currently associated with this citation." />
                                                        </td>
                                                    </tr>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </div>

                                        <h3 class="ps-accordion-head theory-comments">Comments</h3>
                                        <div class="ps-accordion-body theory-commnents">
                                                        <asp:HyperLink ID="hladdcomment" runat="server" NavigateUrl="#">Add New Comment</asp:HyperLink>
                                             <asp:Panel ID="pnlAddComment" runat="server" GroupingText="New Comment">                
                <div id="theory-summary1" class="block eleven ps-no-left-right">
		  <div class="block-inner">
		    <div class="block-content">
		       <div class="citation-wrapper">
		      <div class="field-type-text field-name-field-title form-wrapper" id="edit-field-title">
			<div class="form-item form-item-field-title-value clearfix">
                <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
			  <label for="edit-field-title-value">Comment Title:</label>
            <%--    <asp:HiddenField ID="hdTheoryID" runat="server" />--%>
                <asp:TextBox ID="txtCommentTitle" runat="server" CssClass="text-full form-text" size="60"></asp:TextBox>		
			</div>
		      </div>
		     
		      <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-field-description1">
			<div class="form-item form-item-field-description-value clearfix">
			  <label for="edit-field-description-value">Comment:</label>
                <asp:TextBox ID="txtCommentText" runat="server" CssClass="text-full form-textarea" Rows="4" Columns="158" TextMode="MultiLine" ></asp:TextBox>
			 </div>
		      </div>
		      <div class="form-actions form-wrapper" id="edit-actions1" style="text-align:right;font-size: 12px;">
                  <asp:Button ID="btnSubmitComment" CssClass="btnsave form-submit " runat ="server" Text="Save" OnClick="btnSubmitComment_Click" />
                  <asp:Button ID="btnCancelComment" CssClass="btncancel form-submit " OnClientClick="if(!CancelNewComment()) return false;" runat ="server" Text="Cancel" />                  
		     </div>
	
   
		    </div>		    
		  </div>
		</div>   
                    </div>  
            </asp:Panel>
                                            <div class="block-content">
                                                
                                                <div class="3comments">

                                                    <asp:Repeater ID="rptcomments" runat="server">
                                                        <ItemTemplate>
                                                            <div class="divcomment">
                                                                <span class="field-label">
                                                                    <asp:Label ID="lblCommentTItle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentTitle")%>'></asp:Label></span>
                                                                <div class="field-item field-theory-year-first-published clearfix">
                                                                    <%--<span class="field-label">Year first published</span>--%>
                                                                    <%--<span class="field-content"><asp:Label ID="lblCommentTItle" runat="server"></asp:Label></span>--%>
                  By
              <span class="field-content">
                  <asp:Label ID="lblauthor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentName")%>'></asp:Label>
                  on
                  <asp:Label ID="lbldate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentDT", "{0:MM/dd/yyyy}")%>'></asp:Label></span>
                                                                </div>

                                                                <div class="field-item field-theory-description clearfix">
                                                                    <%--<span class="field-label">Description</span><br />--%>
                                                                    <span class="field-content">
                                                                        <asp:Label ID="lblCommentDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentText")%>'></asp:Label>
                                                                        <%--	<p class="theory-more"><asp:hyperlink ID="hlmore" runat="server" class="theory-more-link" NavigateUrl="#">Read more</asp:hyperlink></p>--%>
                                                                    </span>
                                                                </div>
                                                                <br />
                                                            </div>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <a id="viewmore" href="#">view more</a>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>
                                            <!-- end - replace with main page content -->

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
             $('body').removeClass("frontpage").addClass("theory-detail");
             $("li").addClass("active active-trail");

             $('[id^="ps-accordion"]').accordion("option", "active", 0);
            //Hide Add New Comment Panel
            var addNewCommentPanel = $('#<%=pnlAddComment.ClientID%>');
            addNewCommentPanel.css("display", "none");
             
             $(".3comments").each(function (e) {
                 var commentsCount = $(".divcomment", this).length;
                 if (commentsCount > 3) {
                     $(".divcomment", this).slice(3).wrapAll("<div class='divSlideUpDown' style='display:none;' />");
                 } else {
                     $("#viewmore").hide();
                 }
             });
         });

         $("#viewmore").click(function () {
             $(".divSlideUpDown").slideToggle();
             $(this).text($(this).text() == "view more" ? "hide" : "view more")
             return false;
         });

          $("#MainContent_hladdcomment").click(function () {
            var addNewCommentPanel = $('#<%=pnlAddComment.ClientID%>');
            addNewCommentPanel.css("display", "block");

            var txtCommentTitle = $('#<%=txtCommentTitle.ClientID%>');
            var txtCommentText = $('#<%=txtCommentText.ClientID%>');
            txtCommentTitle.val('');
            txtCommentText.val('');

            $(this).hide();
            return false;
        });

         function CancelNewComment() {
             var addNewCommentPanel = $('#<%=pnlAddComment.ClientID%>');
             addNewCommentPanel.css("display", "none");
             $("#MainContent_hladdcomment").show();
             return false;
         }
    </script>
</asp:Content>

