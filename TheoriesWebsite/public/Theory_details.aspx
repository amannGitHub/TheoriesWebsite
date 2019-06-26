<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Theory_details.aspx.vb" Inherits="public_Theory_details" %>
<asp:Content ID="contentChildTitle" ContentPlaceHolderID="cphMasterTitle"
    runat="server">
    <asp:literal ID="ltltitle" runat="server"></asp:literal>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  
    <style type="text/css">
     a.morelink {
            text-decoration:none;
            outline: none;
        }
        .morecontent span {
            display: none;
        }
        .comment {
            width: 400px;            
            /*margin: 10px;*/
        }
        td{
            vertical-align :top;
        }
        .btncomment{
            margin-bottom:0px !important;
                    }
        .btnsave {
            background: #B55727 !important;
            color: white;
          }

        a.nolink {
            text-decoration:none;
            outline: none;
                }
       
        a.nolink :hover{
            text-decoration:none;
            outline: none;
                }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 <!-- region content - used for the site main content -->
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
               <h1 id="page-title" class="block-title"><asp:Label ID="lblTitle" runat="server"></asp:Label></h1>
		      <!-- end - replace page title -->
		    </div>
		  </div>
		</div>
		
		<div id="title-right" class="block three">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with the real content -->
		      <asp:hyperlink id="hledit" runat="server" CssClass="theoryIcon editTheoryIcon">Edit Theory</asp:hyperlink>
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
             
		      <div class="field-item field-theory-year-first-published clearfix">
			<span class="field-label">Year first published</span>
			<span class="field-content"><asp:Label ID="lblYear" runat="server"></asp:Label></span>
		      </div>
                   
		      <div class="field-item field-theory-description clearfix">
			<span class="field-label">Description</span><br />
			<span class="field-content">
			<asp:Label ID="lblDesc" runat="server" CssClass="comment more" data-showchar="750"></asp:Label>
		<%--	<p class="theory-more"><asp:hyperlink ID="hlmore" runat="server" class="theory-more-link" NavigateUrl="#">Read more</asp:hyperlink></p>--%>
			</span>
		      </div>
		    </div>		    
		  </div>
		</div>
                 
<div id="theory-detail" class="block twelve ps-no-left-right">
		  <div class="block-inner">
		    <div class="block-content">
		      
		      <div id="ps-accordion-1" class="w-accordion">
			<h3 class="ps-accordion-head theory-references">References</h3>
			<div class="ps-accordion-body theory-references" style="height:200px">
             
			  <!-- replace with main page content -->
             <asp:Repeater ID="RptReferneces" runat="server" OnItemCommand="RptReferneces_ItemCommand">
                 <HeaderTemplate>
			   <table class="theories-table sortable" width="100%" border="0">
			    <tr>
				<th scope="col">Citation</th>
				<th scope="col"><asp:linkbutton ID="lnbYear"  runat="server" class="" CommandName="YearPublished">Publication Year</asp:linkbutton></th>
				<th scope="col">Pubmed ID</th>
				<th scope="col"><asp:linkbutton ID="lnbRelevance"  runat="server" class="" CommandName="RelevanceOrder">Relevance</asp:linkbutton></th>
                 </tr>
                </HeaderTemplate>
                 <ItemTemplate>
			      <tr class="row-odd">
				<td><asp:Label ID="lblCitation" runat ="server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label> </td>
				<td><%# DataBinder.Eval(Container.DataItem, "YearPublished")%></td>
			<td><asp:hyperlink runat="server" ID="hlPubMed" class="theory-title" visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>' NavigateUrl='<%#"http://www.ncbi.nlm.nih.gov/pubmed/" & DataBinder.Eval(Container.DataItem, "PubMedID")%>'  Target="_blank"><%# DataBinder.Eval(Container.DataItem, "PubMedID")%></asp:hyperlink></td>
				<td><asp:Label ID="lblRelavance" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelevanceLabel")%>'></asp:Label></td>
                <asp:HiddenField runat="server" ID="hfrelanvaceorder" Visible="false" value ='<%# DataBinder.Eval(Container.DataItem, "RelevanceOrder")%>' />

			      </tr>
                     </ItemTemplate>
                 <AlternatingItemTemplate>
			      <tr class="row-even">
				<td><asp:Label ID="lblCitation" runat ="server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label> </td>
				<td><%# DataBinder.Eval(Container.DataItem, "YearPublished")%></td>
             	<td><asp:hyperlink runat="server" ID="hlPubMed" class="theory-title" visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>' NavigateUrl='<%#"http://www.ncbi.nlm.nih.gov/pubmed/" & DataBinder.Eval(Container.DataItem, "PubMedID")%>' Target="_blank"><%# DataBinder.Eval(Container.DataItem, "PubMedID")%></asp:hyperlink></td>
				<td><asp:Label ID="lblRelavance" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelevanceLabel")%>'></asp:Label></td>
			      </tr>
                  </AlternatingItemTemplate>
			   <FooterTemplate>
                    <tr id="tremptydata" runat ="server" visible ="false" >
                    <td colspan ="4">

    <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No References currently associated with this theory." />
 
                    </td>
                    </tr>
                </table>
                 <br />
                 <div>  
                   <asp:Label id="lblfooternote" runat="server">* NOTE: The "Source" reference should the first published article that describes the theory.
                   
                   </asp:Label>

                    </div>


            </FooterTemplate>
		</asp:Repeater>
           
               
      </div>
	
			<h3 class="ps-accordion-head theory-diagram">Diagram</h3>
			<div class="ps-accordion-body theory-diagram">
                <div><asp:label id="lblfulllimg" runat="server" text="Click on a diagram thumbnail below to view full image"></asp:label></div>
			  <!-- replace with main page content -->
			  <div id="diagram-more" class="block twelve">
                                  <div class="block-inner">
                                      <div class="block-content">
                                         <div class="field-item field-theory-diagram field-diagram-1 clearfix">
                                              <span class="field-label element-invisible">Main Diagram</span>
                                              <span class="field-content">
                                                  <ul class="pp-gallery">
				 <asp:Repeater ID="rptTheoryModels" runat="server" OnItemDataBound="rptTheoryModels_ItemDataBound">
                          <ItemTemplate>
                                
				                                    <li>			
                                                       <asp:HyperLink ID="hlModel" runat="server" rel="prettyPhoto[pp_gal]"  >
                                                         <asp:Image ID="imgModel" runat="server"  />                                                          
                                                        </asp:HyperLink>
                                                         
                                                        <asp:LinkButton ID="lbModelDownload" runat="server" OnClick="lbModelDownload_Click" CssClass="mov-link">Download diagram</asp:LinkButton>
				                                    </li>	
                                                  
                          </ItemTemplate>
                            <FooterTemplate> 
                                <div id="diagramfooter" class="block ten" runat="server" visible="false">
                                  <div class="block-inner">
                                      <div class="block-content">
                                         <div class="field-item field-theory-diagram field-diagram-1 clearfix">
                                              <span class="field-label element-invisible">Main Diagram</span>
                                              <span class="field-content">
                                                  <%--<asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No Models currently associated with this theory." />--%>
                                                <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text='There are currently no diagrams uploaded for this theory.  You can add a diagram by using the "Edit Theory" link above.' />
                                              </span>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                            </FooterTemplate>    
                       </asp:Repeater>
		       </ul>                                                
                                              </span>
                                          </div>
                                      </div>
                                  </div>
                              </div>
			</div>
			<div id="Constrcuts">
			<h3 class="ps-accordion-head theory-constructs">Constructs</h3>
			<div class="ps-accordion-body theory-constructs">

			  <!-- replace with main page content -->
                <asp:Repeater ID="rptConstructs" runat="server" OnItemDataBound="rptConstructs_ItemDataBound" OnItemCommand="rptConstructs_ItemCommand">
                    <HeaderTemplate >
			  <table class="theories-table sortable" width="100%" border="0">
			    <tbody><tr>
			      <th scope="col"><asp:linkbutton ID="lnbConstructName"  runat="server" class="" CommandName="ConstructName">Theoretical Construct</asp:linkbutton></th>
			      <th scope="col" style="width:65%">Description</th>
			      <th scope="col"><asp:linkbutton ID="lnbKeyConstructFlag"  runat="server" class="" CommandName="KeyConstructFlag">GEM Construct*</asp:linkbutton></th>
			    </tr>
                    </HeaderTemplate>
                <ItemTemplate>
			    <tr class="row-odd">
			       <td><%# DataBinder.Eval(Container.DataItem, "ConstructName")%></td>
			       <td><%# DataBinder.Eval(Container.DataItem, "ConstructDefinition")%>
                       
			       </td>
                   <td>
                   
                     <%--<asp:hyperlink ID="hlgemdetails" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, "GEMConstructLink")%>' 
                       Target="_blank" runat="server" CssClass="nolink"><%# HTPUtil.checknullreturnNOElseYes(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>
                       </asp:hyperlink> --%>  
                       <asp:hyperlink ID="Hyperlink1" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, "GEMConstructLink")%>' 
                       Target="_blank"  runat="server"  
                       visible='<%# HTPUtil.CheckNullReturnFalse(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>' 
                       >Yes</asp:hyperlink>
                      <asp:label ID="lblflagNo" runat="server" visible='<%# HTPUtil.CheckNullReturnTrue(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>' 
                        Text='No'>
                      </asp:label>
                  
                     </td>
               </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
			    <tr class="row-even">
			       <td><%# DataBinder.Eval(Container.DataItem, "ConstructName")%></td>
			       <td><%# DataBinder.Eval(Container.DataItem, "ConstructDefinition")%>
                       
			      </td>
                   <td>
                    <%-- <asp:hyperlink ID="hlgemdetails" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, "GEMConstructLink")%>' 
                       Target="_blank" runat="server"  CssClass="nolink"><%# HTPUtil.checknullreturnNOElseYes(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>
                       </asp:hyperlink>    --%>
                     <%--<asp:label ID="lblflag" runat="server" Text='<%# HTPUtil.checknullreturnNO(DataBinder.Eval(Container.DataItem, "KeyConstructFlag"))%>'></asp:label>--%>
                  <asp:hyperlink ID="Hyperlink1" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, "GEMConstructLink")%>' 
                       Target="_blank"  runat="server"  
                       visible='<%# HTPUtil.CheckNullReturnFalse(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>' 
                       >Yes</asp:hyperlink> 
                       <asp:label ID="lblflagNo" runat="server" visible='<%# HTPUtil.CheckNullReturnTrue(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>' 
                        Text='No'>
                      </asp:label>
                     </td>
                 </tr>
                         </tbody>
               
                  </AlternatingItemTemplate>
                <FooterTemplate> 
                   
                <tr id="tremptydata" runat ="server" visible ="false" >
                    <td colspan ="3">

    <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No constructs currently associated with this theory." />

</td>
                    </tr>
  
			</table> <br />
                    <div>  <asp:Label id="lblfooternote" runat="server">* GEM is an interactive website containing behavioral, social science, and other scientific measures organized by theoretical constructs. Read more about GEM <asp:hyperlink runat="server" ID="hlPubMed" class="theory-title"     
                        NavigateUrl="https://www.gem-measures.org/public/About.aspx" Target="_blank">here</asp:hyperlink>
                           </asp:Label>

                    </div>
                    </FooterTemplate>  
         
                      
			</asp:Repeater>   
			</div>
			</div>
			<h3 class="ps-accordion-head theory-related">Related Theories</h3>
			<div class="ps-accordion-body theory-related">

			  <!-- replace with main page content -->
			 <%-- <p><strong>COMING SOON!</strong></p>--%>
                <asp:Repeater ID="rptRelatedTheories" runat="server">
                    <HeaderTemplate>
                 <table class="relatedtheories-table sortable" width="100%" border="0">
			    <tr>
				<th scope="col"><a href="#" title="sort by Theory Name" class="sort_down">Theory</a></th>
				<th scope="col" style="width:15%">Relationship</th>
				<th scope="col" style="width:40%;text-align:left;">Comment</th>
				<th scope="col">User</th>
                 </tr>
                </HeaderTemplate>
                 <ItemTemplate>
			      <tr class="row-odd">
				<td><asp:hyperlink id="hltheoryname" runat="server" NavigateUrl='<%# "~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "RelatedTheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:hyperlink></td>
				<td><%# DataBinder.Eval(Container.DataItem, "Relationship")%></td>
			    <td><%# DataBinder.Eval(Container.DataItem, "Comment")%></td>
				<td><%# DataBinder.Eval(Container.DataItem, "Username")%></td>
           			      </tr>
                     </ItemTemplate>
                 <AlternatingItemTemplate>
			      <tr class="row-even">
			    <td><asp:hyperlink id="hltheoryname" runat="server" NavigateUrl='<%# "~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "RelatedTheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:hyperlink></td>
				<td><%# DataBinder.Eval(Container.DataItem, "Relationship")%></td>
			    <td><%# DataBinder.Eval(Container.DataItem, "Comment")%></td>
				<td><%# DataBinder.Eval(Container.DataItem, "Username")%></td>
			      </tr>
                  </AlternatingItemTemplate>
			   <FooterTemplate>
                    <tr id="tremptydata" runat ="server" visible ="false" >
                    <td colspan ="4">

    <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No Related Theories currently associated with this theory." />

</td>
                    </tr>
                </table>
               </FooterTemplate>
			  </asp:Repeater>
			</div>
			
			<h3 class="ps-accordion-head theory-additional">Additional Resources</h3>
			<div class="ps-accordion-body theory-additional">

			  <!-- replace with main page content -->
			 <%-- <p><strong>COMING SOON!</strong></p>--%>
			   <asp:Repeater ID="RptAdditonalResources" runat="server">
                    <HeaderTemplate>
                 <table class="theories-table sortable" width="100%" border="0">
			    <tr>
				<th scope="col"><asp:linkbutton ID="lnbName"  runat="server" class="" CommandName="ResourceName">Name</asp:linkbutton></th>
				<th scope="col" style="width:40%">Description</th>
				<th scope="col" style="text-align:center;"><asp:linkbutton ID="lnbType"  runat="server" class="" CommandName="ResourceTypeDesc">Type</asp:linkbutton></th>
				<th scope="col">URL</th>
                 </tr>
                </HeaderTemplate>
                 <ItemTemplate>
			      <tr class="row-odd">
				<td><asp:hyperlink id="hlResourceName" runat="server" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceName")%></asp:hyperlink> </td>
				<td><asp:Label ID="lblResourceDesc" runat="server" CssClass="comment more" data-showchar="350" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceDesc")%>'></asp:Label></td>
			    <td><%# DataBinder.Eval(Container.DataItem, "ResourceTypeDesc")%></td>
				<td><asp:hyperlink id="hlResourceURL" runat="server" NavigateUrl ='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>' Target="_blank" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>'></asp:hyperlink></td>
           		</tr>
                </ItemTemplate>
                 <AlternatingItemTemplate>
			      <tr class="row-even">
				<td><asp:hyperlink id="hlResourceName" runat="server" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceName")%></asp:hyperlink> </td>
				<td><asp:Label ID="lblResourceDesc" runat="server" CssClass="comment more" data-showchar="350" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceDesc")%>'></asp:Label></td>
			    <td><%# DataBinder.Eval(Container.DataItem, "ResourceTypeDesc")%></td>
				<td><asp:hyperlink id="hlResourceURL" runat="server" NavigateUrl ='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>' Target="_blank" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>'></asp:hyperlink></td>
			      </tr>
                  </AlternatingItemTemplate>
		  <FooterTemplate>
               <tr id="tremptydata" runat ="server" visible ="false" >
               <td colspan ="4">
               <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No Related Resources currently associated with this theory." /></td>
               </tr>
              </table>
           </FooterTemplate>
	  </asp:Repeater>
                 
   </div>
			
    <h3 class="ps-accordion-head theory-comments">Comments</h3>
		<div class="ps-accordion-body theory-commnents">
		  <!-- replace with main page content -->
			 <%-- <p><strong>COMING SOON!</strong></p>--%>
            <asp:HyperLink ID="hladdcomment" runat="server" NavigateUrl=" ">Add New Comment</asp:HyperLink>
           
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
              
               <div class="block-content" style="clear:both;">
                   <div class="3comments">
            <asp:Repeater ID="rptcomments" runat="server" >
                <ItemTemplate>
                   
                  <div class="divcomment">
                 <span class="field-label"><asp:Label ID="lblCommentTItle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentTitle")%>'></asp:Label></span>
		      <div class="field-item field-theory-year-first-published clearfix">
			<%--<span class="field-label">Year first published</span>--%>
			<%--<span class="field-content"><asp:Label ID="lblCommentTItle" runat="server"></asp:Label></span>--%>
                  By
              <span class="field-content"><asp:Label ID="lblauthor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentName")%>'></asp:Label>
                  on <asp:Label ID="lbldate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentDT", "{0:MM/dd/yyyy}")%>'></asp:Label></span>
		      </div>
                   
		      <div class="field-item field-theory-description clearfix">
			<%--<span class="field-label">Description</span><br />--%>
			<span class="field-content">
			<asp:Label ID="lblCommentDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CommentText")%>' ></asp:Label>
		<%--	<p class="theory-more"><asp:hyperlink ID="hlmore" runat="server" class="theory-more-link" NavigateUrl="#">Read more</asp:hyperlink></p>--%>
			</span>
		      </div>
<br/></div>
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
<asp:Content ID="Content3" ContentPlaceHolderID="JsHolder" Runat="Server">
     <script type="text/javascript">
         $(document).ready(function () {
            $("li").addClass("active active-trail");
            $('body').removeClass("frontpage").addClass("theory-detail");
            $("#ui-id-2").css("height", "");
            $("#ui-id-4,#ui-id-6,#ui-id-8,#ui-id-10,#ui-id-12").css("height", "");

            var activeTab = getQueryString('at');
            var hdTabValue = $("#MainContent_hdTab").val();

            if (hdTabValue) {
                var accordionindex = parseInt(hdTabValue, 10);
                $('[id^="ps-accordion"]').accordion("option", "active", accordionindex);
            } else {
                if (activeTab) {
                    $('[id^="ps-accordion"]').accordion("option", "active", 2);
                } else {
                    $('[id^="ps-accordion"]').accordion("option", "active", 0);
                }
            }

             //Hide Add New Comment Panel
            var addNewCommentPanel = $('#<%=pnlAddComment.ClientID%>');
            addNewCommentPanel.css("display", "none");
        });
       
        var getQueryString = function (field, url) {
            var href = url ? url : window.location.href;
            var reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i');
            var string = reg.exec(href);
            return string ? string[1] : null;
        };

        $(document).ready(function () {
            //var showChar = 50;
            var ellipsestext = "...";
            var moretext = "Read more";
            var lesstext = "Less";
            $('.more').each(function () {
                var content = $(this).html();
                var showChar = $(this).data("showchar");
 
                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    var h = content.substr(showChar, content.length - showChar);

                    var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<p class="theory-more" style="margin:0px"><a class="theory-more-link morelink" href="">' + moretext + '</a></p></span>';

                    $(this).html(html);
                }

            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");
                    $(this).html(moretext);
                    $('.moreellipses').css("display", "");
                } else {
                    $(this).addClass("less");
                    $(this).html(lesstext);
                    $('.moreellipses').css("display", "none");
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });



            ///
            $(".3comments").each(function (e) {
                var commentsCount = $(".divcomment", this).length;
                if (commentsCount > 3) {
                    $(".divcomment", this).slice(3).wrapAll("<div class='divSlideUpDown' style='display:none;' />");
                } else {
                    $("#viewmore").hide();
                }
            });

            //
        });

        $("#viewmore").click(function () {
            $(".divSlideUpDown").slideToggle();
            $(this).text($(this).text()== "view more" ? "hide" : "view more")
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

 