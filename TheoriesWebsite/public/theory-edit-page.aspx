<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="theory-edit-page.aspx.vb" Inherits="public_theory_edit_page" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" runat="Server">
    <asp:Literal ID="ltltitle" runat="server">Edit Theory</asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <%--<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>--%>




    <style type="text/css">
        .txtMargin {
            margin: 0 0 0 0;
        }

        .txtClear {
            clear: both;
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
            border: solid 1px #444444;
            margin: 0px;
            padding: 2px;
            height: 100px;
            overflow: auto;
            background-color: #FFFFFF;
        }

        .listItem {
            color: #1C1C1C;
        }

        .itemHighlighted {
            background-color: #e3ebef;
        }

        .ui-state-disabled {
            opacity: .75;
        }

        .btndelete {
            color: #fff !important;
            text-decoration: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
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
                                    <h1 id="page-title" class="block-title">
                                        <asp:Label ID="lbltitle" runat="server"></asp:Label></h1>
                                    <!-- end - replace page title -->
                                </div>
                            </div>
                        </div>

                        <div id="display-mode" class="block three ps-no-bottom">
                            <div class="block-inner">
                                <div class="block-content">
                                    <!-- replace with the real content -->
                                    <asp:Literal ID="ltlmode" runat="server" Text=""></asp:Literal>
                                    <!-- end - replace with the real content -->
                                </div>
                            </div>
                        </div>

                        <div id="title-right" class="block three ps-no-bottom">
                            <div class="block-inner">
                                <div class="block-content">
                                    <!-- replace with the real content -->
                                    <p class="theory-more">
                                        <asp:HyperLink ID="hlexit" runat="server" CssClass="theory-more-link">Exit Edit Mode</asp:HyperLink>
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
                                            <label for="edit-field-title-value">Theory Name</label>
                                            <asp:HiddenField ID="hdTheoryID" runat="server" />
                                            <asp:TextBox ID="txtname" runat="server" CssClass="text-full form-text" size="60"></asp:TextBox>
                                            <%--	  <input class="text-full form-text" type="text" id="edit-field-title-value" name="field-title" value="Health Belief Model (HBM)" size="60" />--%>
                                        </div>
                                    </div>
                                    <div class="field-item field-theory-year-first-published clearfix">
                                        <span class="field-label">Year first published</span>
                                        <span class="field-content">
                                            <asp:Label ID="lblyear" runat="server"></asp:Label></span>
                                    </div>
                                    <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-field-description1">
                                        <div class="form-item form-item-field-description-value clearfix">
                                            <label for="edit-field-description-value">Description <span class="description">(Type below)</span> </label>
                                            <asp:TextBox ID="txtdesc" runat="server" CssClass="text-full form-textarea" Rows="4" Columns="158" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-actions form-wrapper" id="edit-actions1">
                                        <asp:Button ID="btncancel1" CssClass="btncancel form-submit" OnClientClick="if(!FirmConfirm()) return false;" runat="server" Text="Cancel" />
                                        <asp:Button ID="btnsubmit1" CssClass="btnsave form-submit" runat="server" Text="Save" />
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div id="theory-detail" class="block twelve ps-no-left-right ps-no-bottom">
                            <div class="block-inner">
                                <div class="block-content">

                                    <div id="ps-accordion-1" class="w-accordion">
                                        <h3 class="ps-accordion-head theory-references">References</h3>
                                        <div class="ps-accordion-body theory-references">
                                            <!-- replace with main page content -->
                                            <div class="edit-table-wrapper">
                                                <%-- <h4>To Edit Reference Click on a Row</h4>--%>
                                                <asp:UpdatePanel ID="UP1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <asp:Repeater ID="RptReferences" runat="server" OnItemCommand="RptReferences_ItemCommand">
                                                            <HeaderTemplate>
                                                                <table class="theories-table sortable" style="width: 100%;" border="0">
                                                                    <tr>
                                                                        <th scope="col">Citation</th>
                                                                        <th scope="col">Publication Year</th>
                                                                        <th scope="col">Pubmed ID</th>
                                                                        <th scope="col">Relevance*</th>
                                                                    </tr>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="row-odd">
                                                                    <td>
                                                                        <asp:Label ID="lblCitation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label>
                                                                        <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server">
                                                                            <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CitationID")%>' />
                                                                        </div>
                                                                        <%--<div class="field-type-textarea field-name-field-citation form-wrapper cell-edit" id="edit_field_citation" runat="server" visible="false">
                                                                            <div class="form-item form-item-field-citation-value clearfix">
                                                                                <label for="edit-field-citation-value" class="element-invisible">Citation </label>
                                                                                <asp:TextBox ID="txtCitation" runat="server" Rows="4" CssClass="txtMargin" TextMode="MultiLine" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:TextBox>
                                                                            </div>
                                                                        </div>--%>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblYearPublished" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "YearPublished")%>'></asp:Label>
                                                                        <%--<div id="year_first_published" visible="false" runat="server" class="field-type-select field-name-field-theory-year-first-published form-wrapper cell-edit">
                                                                            <div class="form-item form-item-field-theory-year-first-published-value clearfix">
                                                                                <label for="edit-field-theory-year-first-published-value" class="element-invisible">Year of Publication</label>
                                                                                <div class="date-year">
                                                                                    <asp:DropDownList ID="ddlYears" runat="server" Visible="false" class="date-form form-select">
                                                                                        <asp:ListItem Value=""></asp:ListItem>
                                                                                        <asp:ListItem Value="1900">1900</asp:ListItem>
                                                                                        <asp:ListItem Value="1901">1901</asp:ListItem>
                                                                                        <asp:ListItem Value="1902">1902</asp:ListItem>
                                                                                        <asp:ListItem Value="1903">1903</asp:ListItem>
                                                                                        <asp:ListItem Value="1904">1904</asp:ListItem>
                                                                                        <asp:ListItem Value="1905">1905</asp:ListItem>
                                                                                        <asp:ListItem Value="1906">1906</asp:ListItem>
                                                                                        <asp:ListItem Value="1907">1907</asp:ListItem>
                                                                                        <asp:ListItem Value="1908">1908</asp:ListItem>
                                                                                        <asp:ListItem Value="1909">1909</asp:ListItem>
                                                                                        <asp:ListItem Value="1910">1910</asp:ListItem>
                                                                                        <asp:ListItem Value="1911">1911</asp:ListItem>
                                                                                        <asp:ListItem Value="1912">1912</asp:ListItem>
                                                                                        <asp:ListItem Value="1913">1913</asp:ListItem>
                                                                                        <asp:ListItem Value="1914">1914</asp:ListItem>
                                                                                        <asp:ListItem Value="1915">1915</asp:ListItem>
                                                                                        <asp:ListItem Value="1916">1916</asp:ListItem>
                                                                                        <asp:ListItem Value="1917">1917</asp:ListItem>
                                                                                        <asp:ListItem Value="1918">1918</asp:ListItem>
                                                                                        <asp:ListItem Value="1919">1919</asp:ListItem>
                                                                                        <asp:ListItem Value="1920">1920</asp:ListItem>
                                                                                        <asp:ListItem Value="1921">1921</asp:ListItem>
                                                                                        <asp:ListItem Value="1922">1922</asp:ListItem>
                                                                                        <asp:ListItem Value="1923">1923</asp:ListItem>
                                                                                        <asp:ListItem Value="1924">1924</asp:ListItem>
                                                                                        <asp:ListItem Value="1925">1925</asp:ListItem>
                                                                                        <asp:ListItem Value="1926">1926</asp:ListItem>
                                                                                        <asp:ListItem Value="1927">1927</asp:ListItem>
                                                                                        <asp:ListItem Value="1928">1928</asp:ListItem>
                                                                                        <asp:ListItem Value="1929">1929</asp:ListItem>
                                                                                        <asp:ListItem Value="1930">1930</asp:ListItem>
                                                                                        <asp:ListItem Value="1931">1931</asp:ListItem>
                                                                                        <asp:ListItem Value="1932">1932</asp:ListItem>
                                                                                        <asp:ListItem Value="1933">1933</asp:ListItem>
                                                                                        <asp:ListItem Value="1934">1934</asp:ListItem>
                                                                                        <asp:ListItem Value="1935">1935</asp:ListItem>
                                                                                        <asp:ListItem Value="1936">1936</asp:ListItem>
                                                                                        <asp:ListItem Value="1937">1937</asp:ListItem>
                                                                                        <asp:ListItem Value="1938">1938</asp:ListItem>
                                                                                        <asp:ListItem Value="1939">1939</asp:ListItem>
                                                                                        <asp:ListItem Value="1940">1940</asp:ListItem>
                                                                                        <asp:ListItem Value="1941">1941</asp:ListItem>
                                                                                        <asp:ListItem Value="1942">1942</asp:ListItem>
                                                                                        <asp:ListItem Value="1943">1943</asp:ListItem>
                                                                                        <asp:ListItem Value="1944">1944</asp:ListItem>
                                                                                        <asp:ListItem Value="1945">1945</asp:ListItem>
                                                                                        <asp:ListItem Value="1946">1946</asp:ListItem>
                                                                                        <asp:ListItem Value="1947">1947</asp:ListItem>
                                                                                        <asp:ListItem Value="1948">1948</asp:ListItem>
                                                                                        <asp:ListItem Value="1949">1949</asp:ListItem>
                                                                                        <asp:ListItem Value="1950">1950</asp:ListItem>
                                                                                        <asp:ListItem Value="1951">1951</asp:ListItem>
                                                                                        <asp:ListItem Value="1952">1952</asp:ListItem>
                                                                                        <asp:ListItem Value="1953">1953</asp:ListItem>
                                                                                        <asp:ListItem Value="1954">1954</asp:ListItem>
                                                                                        <asp:ListItem Value="1955">1955</asp:ListItem>
                                                                                        <asp:ListItem Value="1956">1956</asp:ListItem>
                                                                                        <asp:ListItem Value="1957">1957</asp:ListItem>
                                                                                        <asp:ListItem Value="1958">1958</asp:ListItem>
                                                                                        <asp:ListItem Value="1959">1959</asp:ListItem>
                                                                                        <asp:ListItem Value="1960">1960</asp:ListItem>
                                                                                        <asp:ListItem Value="1961">1961</asp:ListItem>
                                                                                        <asp:ListItem Value="1962">1962</asp:ListItem>
                                                                                        <asp:ListItem Value="1963">1963</asp:ListItem>
                                                                                        <asp:ListItem Value="1964">1964</asp:ListItem>
                                                                                        <asp:ListItem Value="1965">1965</asp:ListItem>
                                                                                        <asp:ListItem Value="1966">1966</asp:ListItem>
                                                                                        <asp:ListItem Value="1967">1967</asp:ListItem>
                                                                                        <asp:ListItem Value="1968">1968</asp:ListItem>
                                                                                        <asp:ListItem Value="1969">1969</asp:ListItem>
                                                                                        <asp:ListItem Value="1970">1970</asp:ListItem>
                                                                                        <asp:ListItem Value="1971">1971</asp:ListItem>
                                                                                        <asp:ListItem Value="1972">1972</asp:ListItem>
                                                                                        <asp:ListItem Value="1973">1973</asp:ListItem>
                                                                                        <asp:ListItem Value="1974">1974</asp:ListItem>
                                                                                        <asp:ListItem Value="1975">1975</asp:ListItem>
                                                                                        <asp:ListItem Value="1976">1976</asp:ListItem>
                                                                                        <asp:ListItem Value="1977">1977</asp:ListItem>
                                                                                        <asp:ListItem Value="1978">1978</asp:ListItem>
                                                                                        <asp:ListItem Value="1979">1979</asp:ListItem>
                                                                                        <asp:ListItem Value="1980">1980</asp:ListItem>
                                                                                        <asp:ListItem Value="1981">1981</asp:ListItem>
                                                                                        <asp:ListItem Value="1982">1982</asp:ListItem>
                                                                                        <asp:ListItem Value="1983">1983</asp:ListItem>
                                                                                        <asp:ListItem Value="1984">1984</asp:ListItem>
                                                                                        <asp:ListItem Value="1985">1985</asp:ListItem>
                                                                                        <asp:ListItem Value="1986">1986</asp:ListItem>
                                                                                        <asp:ListItem Value="1987">1987</asp:ListItem>
                                                                                        <asp:ListItem Value="1988">1988</asp:ListItem>
                                                                                        <asp:ListItem Value="1989">1989</asp:ListItem>
                                                                                        <asp:ListItem Value="1990">1990</asp:ListItem>
                                                                                        <asp:ListItem Value="1991">1991</asp:ListItem>
                                                                                        <asp:ListItem Value="1992">1992</asp:ListItem>
                                                                                        <asp:ListItem Value="1993">1993</asp:ListItem>
                                                                                        <asp:ListItem Value="1994">1994</asp:ListItem>
                                                                                        <asp:ListItem Value="1995">1995</asp:ListItem>
                                                                                        <asp:ListItem Value="1996">1996</asp:ListItem>
                                                                                        <asp:ListItem Value="1997">1997</asp:ListItem>
                                                                                        <asp:ListItem Value="1998">1998</asp:ListItem>
                                                                                        <asp:ListItem Value="1999">1999</asp:ListItem>
                                                                                        <asp:ListItem Value="2000">2000</asp:ListItem>
                                                                                        <asp:ListItem Value="2001">2001</asp:ListItem>
                                                                                        <asp:ListItem Value="2002">2002</asp:ListItem>
                                                                                        <asp:ListItem Value="2003">2003</asp:ListItem>
                                                                                        <asp:ListItem Value="2004">2004</asp:ListItem>
                                                                                        <asp:ListItem Value="2005">2005</asp:ListItem>
                                                                                        <asp:ListItem Value="2006">2006</asp:ListItem>
                                                                                        <asp:ListItem Value="2007">2007</asp:ListItem>
                                                                                        <asp:ListItem Value="2008">2008</asp:ListItem>
                                                                                        <asp:ListItem Value="2009">2009</asp:ListItem>
                                                                                        <asp:ListItem Value="2010">2010</asp:ListItem>
                                                                                        <asp:ListItem Value="2011">2011</asp:ListItem>
                                                                                        <asp:ListItem Value="2012">2012</asp:ListItem>
                                                                                        <asp:ListItem Value="2013">2013</asp:ListItem>
                                                                                        <asp:ListItem Value="2014">2014</asp:ListItem>
                                                                                        <asp:ListItem Value="2015">2015</asp:ListItem>
                                                                                        <asp:ListItem Value="2016">2016</asp:ListItem>
                                                                                        <asp:ListItem Value="2017">2017</asp:ListItem>
                                                                                        <asp:ListItem Value="2018">2018</asp:ListItem>

                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </div>
                                                                        </div>--%>
                                                                    </td>
                                                                    <td>
                                                                        <asp:HyperLink runat="server" ID="hlPubMed" class="theory-title" Visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>' NavigateUrl='<%#"http://www.ncbi.nlm.nih.gov/pubmed/" & DataBinder.Eval(Container.DataItem, "PubMedID")%>' Target="_blank"><%# DataBinder.Eval(Container.DataItem, "PubMedID")%></asp:HyperLink>
                                                                        <%--<div class="field-type-text field-name-field-pubmed-id form-wrapper cell-edit" id="edit-field-pubmed-id">
				                                                              <div class="form-item form-item-field-pubmed-id-value clearfix">
					                                                        <label for="edit-field-pubmed-id-value" class="element-invisible">Pubmed ID</label>
					                                                        <asp:textbox runat="server" CssClass="text-full form-text" id="txtpubmedid" Visible ="false" Text ='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>'></asp:textbox>

				                                                              </div>
				                                                            </div>--%>

                    				
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblRelavance" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelevanceLabel")%>'></asp:Label>
                                                                        <asp:HiddenField runat="server" ID="hfrelanvaceorder" Visible="false" Value='<%# DataBinder.Eval(Container.DataItem, "RelevanceOrder")%>' />
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="row-even">
                                                                    <td>
                                                                        <asp:Label ID="lblCitation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label>
                                                                        <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server">
                                                                            <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CitationID")%>' />
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblYearPublished" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "YearPublished")%>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:HyperLink runat="server" ID="hlPubMed" class="theory-title" Visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "PubMedID"))%>' NavigateUrl='<%#"http://www.ncbi.nlm.nih.gov/pubmed/" & DataBinder.Eval(Container.DataItem, "PubMedID")%>' Target="_blank"><%# DataBinder.Eval(Container.DataItem, "PubMedID")%></asp:HyperLink>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblRelavance" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelevanceLabel")%>'></asp:Label>
                                                                        <asp:HiddenField runat="server" ID="hfrelanvaceorder" Visible="false" Value='<%# DataBinder.Eval(Container.DataItem, "RelevanceOrder")%>' />
                                                                    </td>
                                                                </tr>
                                                            </AlternatingItemTemplate>

                                                            <FooterTemplate>
                                                                <tr id="tremptydata" runat="server" visible="false">
                                                                    <td colspan="4">
                                                                        <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No References currently associated with this theory." />
                                                                    </td>
                                                                </tr>
                                                                </table>
                                                                <br />
                                                                <div>
                                                                    <asp:Label ID="lblfooternote" runat="server">* NOTE: The "Source" reference should the first published article that describes the theory.                   
                                                                    </asp:Label>
                                                                </div>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>

                                            <div class="citation-wrapper">
                                                <asp:PlaceHolder ID="plAddRef" runat="server">
                                                    <h4>Add Reference</h4>
                                                    <p>
                                                        If you know the PubMed ID for the reference, enter it in the PubMed ID field and hit "Load Citation" button.
			    The Theories site will automatically load the citation from PubMed. Otherwise, enter your citation details manually.
                                                    </p>

                                                    <%--pubmed id--%>
                                                    <div class="pubmed-wrapper pubgroup clearfix">

                                                        <div class="field-type-text field-name-field-pubmed-id form-wrapper" id="edit-field-pubmed-id">
                                                            <div class="form-item form-item-field-pubmed-id-value clearfix">
                                                                <label for="edit-field-pubmed-id-value">Pubmed ID</label>
                                                                <asp:TextBox ID="txtPubMedID" runat="server" CssClass="text-full form-textarea txtClear" Style="float: left;" Width="101px">
                                                                </asp:TextBox>

                                                                <asp:Button ID="Button1" CssClass="btnsave form-submit" Style="margin-left: 10px; margin-top: 20px;"
                                                                    OnClientClick="if(!validateAddReference()) return false;" runat="server" Text="Load Citation" />
                                                                <a class="theory-more-link" id="edit-field-pubmed-search-value" href="http://www.ncbi.nlm.nih.gov/pubmed/" style="margin-left: 15px; margin-top: 15px;">Search PubMed</a>


                                                            </div>
                                                        </div>

                                                    </div>

                                                    <%--citation--%>
                                                    <div class="field-type-textarea field-name-field-description form-wrapper" id="add-citation-description">
                                                        <div class="form-item form-item-field-description-value clearfix">
                                                            <label for="edit-field-description-value">Citation*</label>
                                                            <%--<asp:TextBox ID="txtCitation" runat="server" CssClass="text-full form-textarea txtClear" 
                     TextMode="MultiLine" Rows="4" Columns="150"></asp:TextBox>--%>
                                                            <asp:TextBox ID="txtCitation" OnTextChanged="txtCitation_TextChanged" runat="server"
                                                                CssClass="text-full form-textarea txtClear" Rows="4" Columns="150" TextMode="MultiLine"
                                                                AutoPostBack="true">
                                                            </asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <%--title--%>
                                                    <div class="field-type-textarea field-name-field-description form-wrapper" id="add-title-description">
                                                        <div class="form-item form-item-field-description-value clearfix">
                                                            <label for="edit-field-description-value">Title*</label>
                                                            <asp:TextBox ID="txtTitle" runat="server" MaxLength="500" CssClass="text-full form-textarea txtClear" Width="500px" Style="float: left;">
                                                            </asp:TextBox>
                                                        </div>
                                                    </div>


                                                    <%--pub year--%>


                                                    <div class="field-type-textarea field-name-field-description form-wrapper" id="add-model-pubyear">
                                                        <div class="form-item form-item-field-description-value clearfix">
                                                            <label for="edit-field-description-value">Publication Year*</label>
                                                            <asp:TextBox ID="txtPubYear" runat="server" MaxLength="4" CssClass="text-full form-textarea txtClear"
                                                                Width="101" Style="float: left;"></asp:TextBox>

                                                        </div>
                                                    </div>

                                                    <%--Relevance--%>

                                                    <div class="field-type-textarea field-name-field-description form-wrapper" id="add-model-Relevance">
                                                        <div class="form-item form-item-field-description-value clearfix">
                                                            <label for="edit-field-description-value">Relevance to Theory*</label>

                                                            <asp:DropDownList ID="ddlRelevance" runat="server" CssClass="text-full form-textarea txtClear">
                                                                <asp:ListItem Value=""></asp:ListItem>
                                                                <asp:ListItem Value="4">Source</asp:ListItem>
                                                                <asp:ListItem Value="1">High</asp:ListItem>
                                                                <asp:ListItem Value="2">Moderate</asp:ListItem>
                                                                <asp:ListItem Value="3">Low</asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>

                                                    </div>

                                                    <%--Pub Type--%>

                                                    <div class="field-type-textarea field-name-field-description form-wrapper" id="add-model-PubType">
                                                        <div class="form-item form-item-field-description-value clearfix">
                                                            <label for="edit-field-description-value">Publication Type</label>
                                                            <asp:DropDownList ID="ddlPubType_filter" runat="server" CssClass="text-full form-textarea txtClear" Width="180px"
                                                                AppendDataBoundItems="true"
                                                                DataTextField="PubTypeAbbr" DataValueField="PubTypeID">
                                                                <%--<asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem>--%>
                                                                <asp:ListItem Value=""></asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>

                                                    </div>

                                                    *Required field


			  <div class="form-actions form-wrapper" id="edit-actions">
                  <asp:Button ID="btncancel2" CssClass="btncancel form-submit" OnClientClick="if(!clearAddReference()) return false;" runat="server" Text="Cancel" />
                  <asp:Button ID="btnsubmit2" CssClass="btnsave form-submit" OnClientClick="if(!validateAddReference()) return false;" runat="server" Text="Save" OnClick="btnAddReference_Click" />
                  <%--  <input type="submit" id="edit-cancel" name="op" value="Cancel" class="form-submit">
			    <input type="submit" id="edit-submit" name="op" value="Save" class="form-submit">--%>
              </div>

                                                </asp:PlaceHolder>
                                                <div>
                                                    <asp:PlaceHolder ID="plDups" runat="server" Visible="False">
                                                        <table>
                                                            <tr>
                                                                <td>The citation already exists.</td>
                                                            </tr>
                                                        </table>
                                                    </asp:PlaceHolder>
                                                </div>
                                            </div>
                                            <%--< end of div class="citation-wrapper">--%>
                                        </div>

                                        <h3 class="ps-accordion-head theory-diagram">Diagram</h3>
                                        <div class="ps-accordion-body theory-diagram">
                                            <asp:Repeater ID="rptTheoryModels" runat="server" OnItemDataBound="rptTheoryModels_ItemDataBound"
                                                OnItemCommand="rptTheoryModels_ItemCommand">
                                                <ItemTemplate>
                                                    <div id="diagram-more" class="block two">
                                                        <div class="block-inner">
                                                            <div class="block-content">
                                                                <div class="field-item field-theory-diagram field-diagram-1 clearfix">
                                                                    <span class="field-label element-invisible">Main Diagram</span>
                                                                    <span class="field-content">
                                                                        <asp:Image ID="imgModel" runat="server" />
                                                                        <asp:LinkButton ID="lnkModelDelete" runat="server"
                                                                            CommandName='<%# DataBinder.Eval(Container.DataItem, "TheoryModelID") %>'
                                                                            OnClientClick="return confirm('Are sure you want to delete the Model?');"
                                                                            Style="padding-left: 55px;">Delete</asp:LinkButton>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <div id="diagramfooter" class="block ten" runat="server" visible="false">
                                                        <div class="block-inner">
                                                            <div class="block-content">
                                                                <div class="field-item field-theory-diagram field-diagram-1 clearfix">
                                                                    <span class="field-label element-invisible">Main Diagram</span>
                                                                    <span class="field-content">
                                                                        <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No Models currently associated with this theory." />
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </FooterTemplate>
                                            </asp:Repeater>

                                            <div class="clear"></div>
                                            <div class="citation-wrapper">
                                                <h4>Add New Model</h4>

                                                <div class="field-type-textarea field-name-field-description form-wrapper" id="add-model-name">
                                                    <div class="form-item form-item-field-description-value clearfix">
                                                        <label for="edit-field-description-value" class="clearfix">File Location</label>
                                                        <asp:FileUpload ID="flUploadModel" runat="server" Style="display: none;" />
                                                        <asp:TextBox ID="txtModelPath" runat="server" ReadOnly="true" CssClass="text-full form-textarea txtClear" Width="500px" Style="float: left;"></asp:TextBox>
                                                        <input type="button" value="Select" onclick="showModelBrowseDialog()" style="margin-left: 20px; margin-top: 20px;" />

                                                    </div>
                                                </div>
                                                <div class="field-type-textarea field-name-field-description form-wrapper" id="add-model-description">
                                                    <div class="form-item form-item-field-description-value clearfix">
                                                        <label for="edit-field-description-value">Short Description</label>
                                                        <asp:TextBox ID="txtModelDesc" runat="server" MaxLength="500" CssClass="text-full form-textarea txtClear" Width="500px" Style="float: left;"></asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="field-type-textarea field-name-field-description form-wrapper" id="add-model-Source">
                                                    <div class="form-item form-item-field-description-value clearfix">
                                                        <label for="edit-field-description-value">Source Credit (please provide a URL or citation as a source credit of this diagram.)</label>
                                                        <asp:TextBox ID="txtModelSource" runat="server" MaxLength="500" CssClass="text-full form-textarea txtClear" Width="500px" Style="float: left;"></asp:TextBox>
                                                        <asp:Button ID="btnModelUpload" CssClass="btnsave form-submit" Style="margin-left: 10px; margin-top: 20px;"
                                                            OnClientClick="if(!validateAddModel()) return false;" runat="server" Text="Upload" OnClick="btnModelUpload_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <h3 class="ps-accordion-head theory-constructs">Constructs</h3>
                                        <div class="ps-accordion-body theory-constructs">
                                            <div class="edit-table-wrapper">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <asp:Repeater ID="rptConstructs" runat="server" OnItemDataBound="rptConstructs_ItemDataBound" OnItemCommand="rptConstructs_ItemCommand">
                                                            <HeaderTemplate>
                                                                <table class="construct-table sortable" style="width: 100%" border="0">
                                                                    <tr>
                                                                        <th scope="col">Theoretical Construct</th>
                                                                        <th scope="col" style="width: 65%">Description</th>
                                                                        <%--<th scope="col"><a href="#" title="sort by Theory Name" class="sort_down">GEM Construct ID</a></th>--%>
                                                                        <th scope="col">GEM Construct ID</th>
                                                                    </tr>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr class="row-odd">
                                                                    <td>
                                                                        <div class="edit-row-wrapper">
                                                                            <asp:LinkButton ID="lnk_Edit" CssClass="edit-row" runat="server" Text="Edit" CommandName="EditThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ConstructID")%>' />
                                                                        </div>
                                                                        <asp:Label ID="lblConstruct" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructName")%>'></asp:Label>
                                                                        <%--<div class="form-actions form-wrapper edit-row-wrapper" id="edit_actions" runat="server" visible="false">
                                                                            <asp:LinkButton ID="lnk_Submit" CssClass="btnsave form-submit" Visible="false" runat="server" Text="Save" CommandName="SubmitThis" />
                                                                        </div>--%>
                                                                        <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server" visible="false">
                                                                            <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" Visible="false" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ConstructID")%>' />
                                                                        </div>
                                                                        <div class="field-type-textarea field-name-field-citation form-wrapper cell-edit" id="edit_field_ConstructName" runat="server" visible="false">
                                                                            <div class="form-item form-item-field-citation-value clearfix">
                                                                                <label for="edit-field-citation-value" class="element-invisible">Theoretical Construct </label>
                                                                                <asp:TextBox ID="txtConstructName" runat="server" Rows="4" CssClass="txtMargin" TextMode="MultiLine" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructName")%>'></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="lblConstructDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructDefinition")%>'></asp:Label>
                                                                        <div id="year_first_published" visible="false" runat="server" class="field-type-select field-name-field-theory-year-first-published form-wrapper cell-edit">
                                                                            <div class="form-item form-item-field-theory-year-first-published-value clearfix">
                                                                                <label for="edit-field-theory-year-first-published-value" class="element-invisible">Description</label>
                                                                                <asp:TextBox ID="txtConstructDefinition" runat="server" Rows="4" CssClass="txtMargin" TextMode="MultiLine" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructDefinition")%>'></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                    </td>

                                                                    <td>
                                                                        <asp:Label ID="lblGEMConstructID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "GEMConstructID")%>'></asp:Label>
                                                                        <%--<asp:hyperlink ID="hlgemdetails" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, "GEMConstructLink")%>' Target="_blank"  runat="server" class="theory-title" visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>' Text='<%# DataBinder.Eval(Container.DataItem, "GEMConstructID")%>'></asp:hyperlink>--%>	                                                               
                                                                    </td>


                                                                </tr>
                                                            </ItemTemplate>
                                                            <AlternatingItemTemplate>
                                                                <tr class="row-even">
                                                                    <td>
                                                                        <div class="edit-row-wrapper">
                                                                            <asp:LinkButton ID="lnk_Edit" CssClass="edit-row" runat="server" Text="Edit" CommandName="EditThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ConstructID")%>' />
                                                                        </div>
                                                                        <asp:Label ID="lblConstruct" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructName")%>'></asp:Label>
                                                                        <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server" visible="false">
                                                                            <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" Visible="false" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ConstructID")%>' />
                                                                        </div>
                                                                        <asp:TextBox ID="txtConstructName" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructName")%>'></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblConstructDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ConstructDefinition")%>'></asp:Label>

                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblGEMConstructID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "GEMConstructID")%>'></asp:Label>
                                                                        <%--<asp:hyperlink ID="hlgemdetails" NavigateUrl='<%#DataBinder.Eval(Container.DataItem, "GEMConstructLink")%>' Target="_blank"  runat="server" class="theory-title" visible='<%# HTPUtil.CheckNull(DataBinder.Eval(Container.DataItem, "GEMConstructLink"))%>' Text='<%# DataBinder.Eval(Container.DataItem, "GEMConstructID")%>'></asp:hyperlink>--%>
                                                                    </td>

                                                                </tr>
                                                            </AlternatingItemTemplate>

                                                            <FooterTemplate>
                                                                <tr id="tremptydata" runat="server" visible="false">
                                                                    <td colspan="3">

                                                                        <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No constructs currently associated with this theory." />

                                                                    </td>
                                                                </tr>


                                                                </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>

                                            <div class="citation-wrapper">
                                                <asp:UpdatePanel ID="update1" runat="server">
                                                    <ContentTemplate>
                                                        <h4>
                                                            <asp:Label runat="server" ID="lblConstructMode" Text="Add Construct"></asp:Label></h4>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-construct-name">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Theoretical Construct Name</label>

                                                                <asp:HiddenField ID="hdnValue" OnValueChanged="hdnValue_ValueChanged" runat="server" Value="" />
                                                                <asp:TextBox ID="txtConstructName" runat="server" CssClass="text-full form-textarea txtClear" Width="500px"></asp:TextBox>
                                                                <asp:AutoCompleteExtender ServiceMethod="GetConstructNames" MinimumPrefixLength="1"
                                                                    CompletionInterval="10" EnableCaching="false" CompletionSetCount="1" TargetControlID="txtConstructName"
                                                                    ID="AutoCompleteExtender1" runat="server" FirstRowSelected="false"
                                                                    OnClientItemSelected="OnConstructSelected"
                                                                    CompletionListCssClass="completionList"
                                                                    CompletionListHighlightedItemCssClass="itemHighlighted"
                                                                    CompletionListItemCssClass="listItem">
                                                                </asp:AutoCompleteExtender>


                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-construct-description">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Description</label>
                                                                <asp:TextBox ID="txtConstructDesc" runat="server" CssClass="text-full form-textarea txtClear" TextMode="MultiLine" Rows="4" Columns="150"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-construct-GEMID">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value">GEM Construct ID:</label>
                                                                <asp:Label ID="lblGEMConstructID" runat="server"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-construct-UseNme">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value">
                                                                    Use GEM Construct name and definition:</label>
                                                                <asp:CheckBox ID="cbUseConstructName" runat="server" Checked="false" AutoPostBack="true" Enabled="false"></asp:CheckBox>

                                                                <asp:HiddenField runat="server" ID="hdnCID" />
                                                                <asp:HiddenField runat="server" ID="hdnCName" />
                                                                <asp:HiddenField runat="server" ID="hdnCDesc" />
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <div class="form-actions form-wrapper" id="edit-construct-actions">
                                                    <%--<asp:Button ID="btnConstructCancel" CssClass="btncancel form-submit" OnClick="btnConstructCancel_Click" OnClientClick="if(!clearAddConstruct()) return false;" runat="server" Text="Cancel" />--%>
                                                    <asp:Button ID="btnConstructCancel" CssClass="btncancel form-submit" runat="server" Text="Cancel" />
                                                    <asp:Button ID="btnConstructSubmit" CssClass="btnsave form-submit" OnClientClick="if(!validateAddConstruct()) return false;" runat="server" Text="Save"  />

                                                </div>
                                            </div>
                                        </div>

                                        <h3 class="ps-accordion-head theory-related">Related Theories</h3>
                                        <div class="ps-accordion-body theory-related">
                                            <div class="edit-table-wrapper">
                                                <asp:Repeater ID="rptRelatedTheories" runat="server" OnItemDataBound="rptRelatedTheories_ItemDataBound" OnItemCommand="rptRelatedTheories_ItemCommand">
                                                    <HeaderTemplate>
                                                        <table class="relatedtheories-table sortable" width="100%" border="0">
                                                            <tr>
                                                                <th scope="col">Theory</th>
                                                                <th scope="col">Relationship</th>
                                                                <th scope="col" style="width: 40%">Comment</th>
                                                                <th scope="col">User</th>
                                                            </tr>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr class="row-odd">
                                                            <td>
                                                                <asp:HyperLink ID="hltheoryname" runat="server" NavigateUrl='<%# "~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "RelatedTheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:HyperLink>

                                                                <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server" visible="false">
                                                                    <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "RelatedTheoryID")%>' />
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRelationship" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Relationship")%>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblComment" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Comment")%>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblUN" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "UserName")%>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <tr class="row-even">
                                                            <td>
                                                                <asp:HyperLink ID="hltheoryname" runat="server" NavigateUrl='<%# "~/public/Theory_details.aspx?TID=" & DataBinder.Eval(Container.DataItem, "RelatedTheoryID")%>'><%# DataBinder.Eval(Container.DataItem, "TheoryName")%></asp:HyperLink>
                                                                <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server">
                                                                    <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "RelatedTheoryID")%>' />
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRelationship" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Relationship")%>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblComment" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Comment")%>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblUN" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "UserName")%>'></asp:Label>
                                                            </td>
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

                                            <div class="citation-wrapper">
                                                <asp:UpdatePanel ID="upAddRelation" runat="server">
                                                    <ContentTemplate>
                                                        <h4>Add Relationship</h4>
                                                        <p>To manually create a relationship between this theory and another theory in the database, please select the related theory from the list below.  You must also provide a short explanatory comment.</p>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-relation-name">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Theory Name</label>
                                                                <asp:DropDownList ID="ddlRelationTheories" runat="server" CssClass="text-full form-textarea txtClear"
                                                                    AppendDataBoundItems="true"
                                                                    DataTextField="TheoryName" DataValueField="TheoryID">
                                                                    <asp:ListItem Value=""></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-relation-comment">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Comment (500 characters max)</label>
                                                                <asp:TextBox ID="txtRelationComment" runat="server" CssClass="text-full form-textarea txtClear" TextMode="MultiLine" Rows="4" Columns="150" MaxLength="500"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <div class="form-actions form-wrapper" id="edit-relation-actions">
                                                    <asp:Button ID="btnRelationCancel" CssClass="btncancel form-submit" runat="server" Text="Cancel" OnClientClick="if(!clearAddRelation()) return false;"/>
                                                    <asp:Button ID="btnRelationSave" CssClass="btnsave form-submit" runat="server" Text="Create Relationship" OnClientClick="if(!validateAddRelation()) return false;" />
                                                </div>
                                            </div>
                                        </div>

                                        <h3 class="ps-accordion-head theory-additional">Additional Resources</h3>
                                        <div class="ps-accordion-body theory-additional">
                                            <div class="edit-table-wrapper">
                                                <asp:Repeater ID="rptAdditonalResources" runat="server">
                                                    <HeaderTemplate>
                                                        <table class="additionalresources-table sortable" style="width:100%;" border="0">
                                                            <tr>
                                                                <th scope="col">
                                                                    <asp:LinkButton ID="lnbName" runat="server"  CommandName="ResourceName">Name</asp:LinkButton></th>
                                                                <th scope="col" style="width: 40%">Description</th>
                                                                <th scope="col" style="text-align: center;">
                                                                    <asp:LinkButton ID="lnbType" runat="server" CommandName="ResourceTypeDesc">Type</asp:LinkButton></th>
                                                                <th scope="col">URL</th>
                                                            </tr>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr class="row-odd">
                                                            <td>
                                                                <asp:HyperLink ID="hlResourceName" runat="server" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceName")%></asp:HyperLink>
                                                                <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server">
                                                                    <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ResourceID")%>' />
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblResourceDesc" runat="server" CssClass="comment more" data-showchar="350" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceDesc")%>'></asp:Label></td>
                                                            <td><%# DataBinder.Eval(Container.DataItem, "ResourceTypeDesc")%></td>
                                                            <td>
                                                                <asp:HyperLink ID="hlResourceURL" runat="server" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>' Target="_blank" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>'></asp:HyperLink></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <tr class="row-even">
                                                            <td>
                                                                <asp:HyperLink ID="hlResourceName" runat="server" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>'><%# DataBinder.Eval(Container.DataItem, "ResourceName")%></asp:HyperLink>
                                                                <div class="form-actions form-wrapper edit-row-wrapper" id="delete_actions" runat="server">
                                                                    <asp:LinkButton ID="lnk_Delete" CssClass="btndelete form-submit" runat="server" Text="Delete" CommandName="DeleteThis" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ResourceID")%>' />
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblResourceDesc" runat="server" CssClass="comment more" data-showchar="350" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceDesc")%>'></asp:Label></td>
                                                            <td><%# DataBinder.Eval(Container.DataItem, "ResourceTypeDesc")%></td>
                                                            <td>
                                                                <asp:HyperLink ID="hlResourceURL" runat="server" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>' Target="_blank" Text='<%# DataBinder.Eval(Container.DataItem, "ResourceURL")%>'></asp:HyperLink></td>
                                                        </tr>
                                                    </AlternatingItemTemplate>
                                                    <FooterTemplate>                                                        
                                                            <tr id="tremptydata" runat="server" visible="false">
                                                                <td colspan="4">
                                                                    <asp:Label ID="lblEmptyData" runat="server" Visible="false" Text="No Related Resources currently associated with this theory." /></td>
                                                            </tr>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </div>

                                            <div class="citation-wrapper">
                                                <asp:UpdatePanel ID="upAddResource" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <h4>Add Resource</h4>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-resource-name">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Resource Name</label>
                                                                <asp:TextBox ID="txtResourceName" runat="server" CssClass="text-full form-textarea txtClear" Width="500px" MaxLength="500"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-resource-url">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Resource URL</label>
                                                                <asp:HiddenField ID="hdnValueResourceURL" OnValueChanged="hdnValueResourceURL_ValueChanged" runat="server" Value="" />
                                                                <asp:TextBox ID="txtResourceURL" runat="server" CssClass="text-full form-textarea txtClear" Width="500px"></asp:TextBox>
                                                                <%--<asp:AutoCompleteExtender ServiceMethod="GetResourceURL" MinimumPrefixLength="1"
                                                                    CompletionInterval="10" EnableCaching="false" CompletionSetCount="1" TargetControlID="txtResourceURL"
                                                                    ID="AutoCompleteExtenderResourceURL" runat="server" FirstRowSelected="false"
                                                                    OnClientItemSelected = "OnURLSelected"
                                                                    CompletionListCssClass = "completionList"
                                                                    CompletionListHighlightedItemCssClass = "itemHighlighted"
                                                                    CompletionListItemCssClass="listItem">
                                                                </asp:AutoCompleteExtender>--%>
                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-resource-desc">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Resource Description</label>
                                                                <asp:TextBox ID="txtResourceDesc" runat="server" CssClass="text-full form-textarea txtClear" TextMode="MultiLine" Rows="4" Columns="150" MaxLength="500"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="field-type-textarea field-name-field-description form-wrapper" id="edit-resource-type">
                                                            <div class="form-item form-item-field-description-value clearfix">
                                                                <label for="edit-field-description-value" class="clearfix">Resource Type</label>
                                                                <asp:DropDownList ID="ddlResourceType" runat="server" CssClass="text-full form-textarea txtClear"
                                                                    AppendDataBoundItems="true"
                                                                    DataTextField="ResourceTypeDesc" DataValueField="ResourceTypeID">
                                                                    <asp:ListItem Value=""></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <div class="form-actions form-wrapper" id="edit-resource-actions">
                                                    <asp:Button ID="btnResourceCancel" CssClass="btncancel form-submit" runat="server" Text="Cancel" OnClientClick="if(!clearAddResource()) return false;"/>
                                                    <asp:Button ID="btnResourceSave" CssClass="btnsave form-submit" runat="server" Text="Add Resource" OnClientClick="if(!validateAddResource()) return false;" />
                                                </div>
                                            </div>

                                        </div>

                                        <%--	<h3 class="ps-accordion-head theory-comments">Comments</h3>
			                                    <div class="ps-accordion-body theory-commnents">

			                                      <!-- replace with main page content -->
			                                      <p><strong>COMING SOON!</strong></p>
			  
			                                    </div>--%>
                                    </div>

                                </div>
                            </div>

                            <%--<div id="theory-actions" class="block twelve">
                            <div class="block-inner">
                                <div class="block-content">
                                    <div class="form-actions form-wrapper" id="edit-actions">
                                        <input type="submit" id="edit-cancel" name="op" value="Cancel" class="form-submit"/>
                                        <input type="submit" id="edit-submit" name="op" value="Save" class="form-submit"/>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                            <!-- end - replace with main page content -->

                        </div>
                    </div>

                </div>
             </div>
        </section>
    </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JsHolder" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('body').removeClass("frontpage").addClass("theory-detail").addClass("theory-edit").addClass("page-edit");
            $('[id^="ps-accordion"]').accordion({
                active: false
            });

            //$('[id^="ps-accordion"]').accordion("option", "active", 0);

            var activeTab = getQueryString('at');
            var hdTabValue = $("#MainContent_hdTab").val();

            if (hdTabValue) {
                var accordionindex = parseInt(hdTabValue, 10);
                $('[id^="ps-accordion"]').accordion("option", "active", accordionindex);               
            } else {
                if (activeTab) {
                    $('[id^="ps-accordion"]').accordion("option", "active", 2);
                } else {
                    $('[id^="ps-accordion"]').accordion("option", "active", false);
                }
            }



            var activeTabInt = parseInt(activeTab);  // convert a string to a number
            if (activeTab) {
                $('[id^="ps-accordion"]').accordion("option", "active", activeTabInt);
            }

            var hdtid = "<%= hdTheoryID.ClientID %>";
            var hdtheoryid = document.getElementById(hdtid).value
            if (hdtheoryid) {

            } else {
                $('[id^="ps-accordion"]').accordion("disable");
            }

            <%--$('#<%=txtConstructName.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%= ResolveUrl("theory-edit-page.aspx/GetConstructNames")%>',
                        data: "{ 'pre':'" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return { value: item }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                }
            });

            $('.ui-autocomplete').css('list-style-type', 'none');
            $('.ui-autocomplete').css('text-decoration', 'none');--%>
        });

        var getQueryString = function (field, url) {
            var href = url ? url : window.location.href;
            var reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i');
            var string = reg.exec(href);
            return string ? string[1] : null;
        };

        function FirmConfirm() {
            if (confirm('Do you want to cancel?'))
                return true;
            else
                return false;
        }

        function clearAddReference() {
            $('#MainContent_txtPubMedID').val('');
            $('#MainContent_txtCitation').val('');
            $('#MainContent_txtTitle').val('');
            $('#MainContent_txtPubYear').val('');
            $('#MainContent_ddlPubType_filter').val('');
            $('#MainContent_ddlRelevance').val('');
            return false;
        }

        function clearAddConstruct() {
            $('#MainContent_lblConstructMode').text('Add Construct');
            $('#MainContent_txtConstructName').val('');
            $('#MainContent_txtConstructDesc').val('');
            $('#MainContent_cbUseConstructName').removeAttr('checked');
            $('#MainContent_lblGEMConstructID').text('');            
            return false;
        }

        function clearAddRelation() {
            $('#MainContent_ddlRelationTheories').val('');
            $('#MainContent_txtRelationComment').val('');
            return false;
        }

        function clearAddResource() {
            $('#MainContent_txtResourceName').val('');
            $('#MainContent_txtResourceURL').val('');
            $('#MainContent_txtResourceDesc').val('');
            $('#MainContent_ddlResourceType').val('');
            return false;
        }

        function validateAddReference() {
            var isValid = false;
            if ($('#MainContent_txtCitation').val().trim().length > 0) {
                if ($('#MainContent_txtTitle').val().trim().length > 0) {
                    if ($('#MainContent_txtPubYear').val().trim().length > 0) {
                        if ($('#MainContent_ddlRelevance').val().trim().length > 0) {
                            isValid = true;
                        }
                    }
                }
            }
            return isValid;
        }

        function clearAddConstruct() {
            $('#MainContent_txtConstructName').val('');
            $('#MainContent_txtConstructDesc').val('');
            $('#MainContent_lblGEMConstructID').text('');
            $('#MainContent_cbUseConstructName').attr('checked', false);
            $('#MainContent_txtConstructName').removeAttr("readonly");
            $('#MainContent_txtConstructDesc').removeAttr("readonly");
            $('#MainContent_cbUseConstructName').add("readonly");
            return false;
        }

        function validateAddConstruct() {
            var isValid = false;

            if ($('#MainContent_txtConstructName').val().trim().length > 0) {
                if ($('#MainContent_txtConstructDesc').val().trim().length > 0) {
                    isValid = true;
                }
            }

            return isValid;
        }

        function validateAddRelation() {
            var isValid = false;

            if ($('#MainContent_ddlRelationTheories').val().trim().length > 0) {
                if ($('#MainContent_txtRelationComment').val().trim().length > 0) {
                    isValid = true;
                }
            }

            return isValid;
        }

        function validateAddResource() {
            var isValid = false;
            if ($('#MainContent_txtResourceName').val().trim().length > 0) {
                if ($('#MainContent_txtResourceDesc').val().trim().length > 0) {
                    if ($('#MainContent_ddlResourceType').val().trim().length > 0) {
                        isValid = true;
                    }
                }
            }
            return isValid;
        }

        function warnChangeOrigGem() {
            $('#<%= cbUseConstructName.ClientID%>').change(function () {
                $('#<%= txtConstructName.ClientID%>').removeAttr("readonly");
                $('#<%= txtConstructDesc.ClientID%>').removeAttr("readonly");
                if ($('#<%= cbUseConstructName.ClientID%>').is(":checked")) {
                    $('#<%= txtConstructName.ClientID%>').attr("readonly", true);
                    $('#<%= txtConstructDesc.ClientID%>').attr("readonly", true);
                    if (($('#<%= hdnCName.ClientID%>').val().trim() != $('#<%= txtConstructName.ClientID%>').val().trim()) || ($('#<%= hdnCDesc.ClientID%>').val().trim() != $('#<%= txtConstructDesc.ClientID%>').val().trim())) {
                        if (!confirm('WARNING: This action will change the name and description of this construct back  to the original GEM name and description.  Do you want to continue?')) {
                            $('#<%= txtConstructName.ClientID%>').removeAttr("readonly");
                            $('#<%= txtConstructDesc.ClientID%>').removeAttr("readonly");
                            $('#<%= cbUseConstructName.ClientID%>').removeAttr('checked');
                            return false;
                        }
                        else {
                            document.getElementById("<%= txtConstructName.ClientID%>").value = $('#<%= hdnCName.ClientID%>').val();
                            document.getElementById("<%= txtConstructDesc.ClientID%>").value = $('#<%= hdnCDesc.ClientID%>').val();
                        }
                    }
                }
            });
            return true;
        }

        function OnConstructSelected(source, eventArgs) {
            var hdnValueID = "<%= hdnValue.ClientID %>";
            document.getElementById(hdnValueID).value = eventArgs.get_value();
            __doPostBack(hdnValueID, "");
        }

        function showModelBrowseDialog() {
            var fileuploadctrl = document.getElementById('<%=flUploadModel.ClientID%>');
            fileuploadctrl.click();
        }

        function setUploadModelPath(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=txtModelPath.ClientID %>").value = fileUpload.value;
            }
        }

        function validateAddModel() {
            var isValid = false;

            if ($('#MainContent_txtModelDesc').val().trim().length > 0) {
                if ($('#MainContent_txtModelPath').val().trim().length > 0) {
                    if ($('#MainContent_txtModelSource').val().trim().length > 0) {
                        isValid = true;
                    }
                }
            }
            return isValid;
        }
    </script>
</asp:Content>

