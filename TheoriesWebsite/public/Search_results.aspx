<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Search_results.aspx.vb" Inherits="public_Search_results" %>

<asp:Content ID="contentChildTitle" ContentPlaceHolderID="cphMasterTitle"
  runat="server">
  <asp:Literal ID="ltltitle" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

  <style type="text/css">
    a.morelink {
      text-decoration: none;
      outline: none;
    }

    .morecontent span {
      display: none;
    }

    .comment {
      width: 400px;
      /*margin: 10px;*/
    }

    td {
      vertical-align: top;
    }

    .btncomment {
      margin-bottom: 0px !important;
    }

    .btnsave {
      background: #B55727 !important;
      color: white;
    }

    a.nolink {
      text-decoration: none;
      outline: none;
    }

      a.nolink :hover {
        text-decoration: none;
        outline: none;
      }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
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
                  <h1 id="page-title" class="block-title">
                    <asp:Label ID="lblTitle" runat="server"></asp:Label></h1>
                  <!-- end - replace page title -->
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


                  <div id="search" class="block seven search-form">
                    <div class="block-inner">
                      <div class="block-content">
                        <!-- Begin Search -->
                        <div class="form-wrapper clearfix">
                          <div class="form-widget">
                            <label class="element-invisible" for="search-text">Search </label>
                            <div class="form-item form-item-text">
                              <asp:TextBox ID="txtSearchResults" type="search" runat="server" CssClass="form-text"></asp:TextBox>
                              <%--<input title="Enter the terms you wish to search for." type="search" id="search-text" name="search_block_form" value="" class="form-text" />--%>
                            </div>
                          </div>
                          <div class="form-actions form-widget" id="form-actions">
                            <asp:Button ID="btnSearchResults" runat="server" Text="Search" class="form-submit" />
                          </div>
                        </div>
                        <!-- End Search -->
                      </div>
                    </div>
                  </div>

                  <!-- Theories -->
                  <div id="theories" class="block twelve ps-no-left-right">
                    <div id="ps-accordion-1" class="w-accordion">
                      <h3 class="ps-accordion-head theory-references">Theories
													<span style="float: right;" id="lblTheoryCount" runat="server" visible="false">
                            <asp:Label ID="TheoryCount" runat="server" Text="" Visible="true"></asp:Label>
                            results of about
                            <asp:Label ID="TheoryTotalCount" runat="server" Text="" Visible="true"></asp:Label></span>
                      </h3>
                      <div class="ps-accordion-body theory-references" style="height: 200px">
                        <!-- replace with main page content -->
                        <asp:Repeater ID="RptTheories" runat="server">
                          <HeaderTemplate>
                            <table>
                          </HeaderTemplate>
                          <ItemTemplate>
                            <tr class="row-odd">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:HyperLink ID="hlTheoryTitle" runat="server" class="theory-title" NavigateUrl='<%#"~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:HyperLink>
                                <br />
                                <asp:Label ID="lblTheoryDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TheoryDescription")%>'></asp:Label>
                              </td>
                            </tr>
                          </ItemTemplate>
                          <AlternatingItemTemplate>
                            <tr class="row-even">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:HyperLink ID="hlTheoryTitle" runat="server" class="theory-title" NavigateUrl='<%#"~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "TheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:HyperLink>
                                <br />
                                <asp:Label ID="lblTheoryDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TheoryDescription")%>'></asp:Label>
                              </td>
                            </tr>
                          </AlternatingItemTemplate>
                          <FooterTemplate>
                            <tr id="tremptydata" runat="server" visible="false">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No theories found for this search criteria." />
                              </td>
                            </tr>
                            </table>
                          </FooterTemplate>
                        </asp:Repeater>

                        <br />
                        <div id="TheoryAll">
                          <asp:LinkButton ID="btnTheoryAll" runat="server" Visible="false" Text="See all theories results"></asp:LinkButton>
                          <asp:LinkButton ID="btnTheoryLess" runat="server" Visible="false" Text="See less thoeries"></asp:LinkButton>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- End Theories -->

                  <!-- Citations -->
                  <div id="citations" class="block twelve ps-no-left-right">
                    <div id="ps-accordion-2" class="w-accordion">
                      <h3 class="ps-accordion-head theory-references">Citations
													<span style="float: right;" id="lblCitationCount" runat="server" visible="false">
                            <asp:Label ID="CitationCount" runat="server" Text="" Visible="true"></asp:Label>
                            results of about
                            <asp:Label ID="CitationTotalCount" runat="server" Text="" Visible="true"></asp:Label></span>
                      </h3>
                      <div class="ps-accordion-body theory-references" style="height: 200px">
                        <asp:Repeater ID="RptCitations" runat="server">
                          <HeaderTemplate>
                            <table>
                          </HeaderTemplate>
                          <ItemTemplate>
                            <tr class="row-odd">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:Label ID="hlCitation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label>
                              </td>
                            </tr>
                          </ItemTemplate>
                          <AlternatingItemTemplate>
                            <tr class="row-even">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:Label ID="hlCitation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label></td>
                            </tr>
                          </AlternatingItemTemplate>
                          <FooterTemplate>
                            <tr id="tremptydata" runat="server" visible="false">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No bibliography found for this search criteria." />
                              </td>
                            </tr>
                            </table>
                          </FooterTemplate>
                        </asp:Repeater>

                        <br />
                        <div id="CitationAll">
                          <asp:LinkButton ID="btnCitationAll" runat="server" Visible="false" Text="See all bibliography results"></asp:LinkButton>
                          <asp:LinkButton ID="btnCitationLess" runat="server" Visible="false" Text="See less bibliography"></asp:LinkButton>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- End Citations  -->


                  <!-- Resources -->
                  <div id="resources" class="block twelve ps-no-left-right">
                    <div id="ps-accordion-3" class="w-accordion">
                      <h3 class="ps-accordion-head theory-references">Resources
													<span style="float: right;" id="lblResourceCount" runat="server" visible="false">
                            <asp:Label ID="ResourceCount" runat="server" Text="" Visible="true"></asp:Label>
                            results of about
                            <asp:Label ID="ResourceTotalCount" runat="server" Text="" Visible="true"></asp:Label></span>
                      </h3>
                      <div class="ps-accordion-body theory-references" style="height: 200px">
                        <asp:Repeater ID="RptResources" runat="server">
                          <HeaderTemplate>
                            <table>
                          </HeaderTemplate>
                          <ItemTemplate>
                            <tr class="row-odd">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:HyperLink ID="hlResourcetitle" runat="server" class="resource-title" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceTitle")%></asp:HyperLink>
                                <br />
                                <asp:Label ID="hlResourceDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceDesc")%>'></asp:Label>
                              </td>
                            </tr>
                          </ItemTemplate>
                          <AlternatingItemTemplate>
                            <tr class="row-even">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:HyperLink ID="hlResourcetitle" runat="server" class="resource-title" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceTitle")%></asp:HyperLink>
                                <br />
                                <asp:Label ID="hlResourceDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceDesc")%>'></asp:Label>
                              </td>
                            </tr>
                          </AlternatingItemTemplate>
                          <FooterTemplate>
                            <tr id="tremptydata" runat="server" visible="false">
                              <td style="border: 0px; padding-bottom: 0px;">
                                <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No resource found for this search criteria." />
                              </td>
                            </tr>
                            </table>
                          </FooterTemplate>
                        </asp:Repeater>

                        <br />
                        <div id="ResourceAll">
                          <asp:LinkButton ID="btnResourceAll" runat="server" Visible="false" Text="See all resources results"></asp:LinkButton>
                          <asp:LinkButton ID="btnResourceLess" runat="server" Visible="false" Text="See less resources"></asp:LinkButton>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- End Resources  -->

                </div>
              </div>
            </div>
          </div>
    </section>
  </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="JsHolder" runat="Server">
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
      var addNewCommentPanel = $('#<%'=pnlAddComment.ClientID%>');
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
      $(this).text($(this).text() == "view more" ? "hide" : "view more")
      return false;
    });

  </script>
</asp:Content>

