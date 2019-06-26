<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Contribute.aspx.vb" Inherits="public_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" runat="Server">
    <asp:Literal ID="ltltitle" runat="server">Contribute</asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
               
        #theory-model .block-inner, #train-educ .block-inner {
            border-right: 2px solid #116172;
        }
       #w-content .block-content { 
            border-top: 2px solid #116172;          
        }



        /*
          h2.block-title {
            margin-bottom: 0px;
        }

        #theory-model .block-inner > .block-title:after {
            content: "";
            display: inline-block;
            width: 35px;
            height: 31px;
            margin-left: 5px;
            background: none;
        }
        #train-educ .block-inner > .block-title:after {
            content: "";
            display: inline-block;
            width: 35px;
            height: 31px;
            margin-left: 5px;
            background: none;
        }
        #biblio .block-inner > .block-title:after {
            content: "";
            display: inline-block;
            width: 35px;
            height: 31px;
            margin-left: 5px;
            background: none;
        }

    */



    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <!-- region content - used for the site main content -->
    <section id="w-content" class="region">
        <div class="region-inner clearfix">
            <div class="block two-third ps-nested">
                <div class="block-inner">

                    <div id="theory-model" class="block half">
                        <div class="block-inner">
                            <h2 class="block-title">Theory</h2>
                          
                          <div class="block-content ps-uniHeight" style="width:90%;">
                                <!-- replace with the real content -->
                                <h4><strong>What is a Theory and how can I contribute?</strong></h4>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
                                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
                                when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
                                It has survived not only five centuries, but also the leap into electronic typesetting, 
                                remaining essentially unchanged. <br /><br />                             
                                <a href="theory-edit-page.aspx" class="add-icon" style="margin-left:0px;">Add Theory</a>
                                <!-- end - replace with the real content -->
                            </div>
                        </div>
                    </div>

                    <div id="train-educ" class="block half">
                        <div class="block-inner">
                            <h2 class="block-title">Resource</h2>
                            <div class="block-content ps-uniHeight" style="width:92%;">
                                <!-- replace with the real content -->
                                <h4><strong>What is a Resource and how can I contribute?</strong></h4>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
                                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
                                when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
                                It has survived not only five centuries, but also the leap into electronic typesetting, 
                                remaining essentially unchanged. <br /><br />
                                <a href="resource-edit-page.aspx" class="add-icon" style="margin-left:0px;">Add Resource</a>
                                <!-- end - replace with the real content -->
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div id="biblio" class="block one-third ps-full-portrait clearafter">
                <div class="block-inner">
                    <h2 class="block-title">Citation</h2>
                    <div class="block-content ps-uniHeight ps-portrait-auto">
                       <!-- replace with the real content -->
                                <h4><strong>What is a Citation and how can I contribute?</strong></h4>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
                                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
                                when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
                                It has survived not only five centuries, but also the leap into electronic typesetting, 
                                remaining essentially unchanged. <br /><br />
                                <a href="citation-edit-page.aspx" class="add-icon" style="margin-left:0px;">Add Citation</a>
                                <!-- end - replace with the real content -->                                             
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- region below the main content - can be used for extra blocks -->
    <section id="w-content-bottom" class="region">
        <div class="region-inner clearfix">
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JsHolder" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('body').removeClass("frontpage");
        });
    </script>
</asp:Content>

