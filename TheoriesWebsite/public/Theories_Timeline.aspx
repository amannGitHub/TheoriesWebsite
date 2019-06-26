<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Theories_Timeline.aspx.vb" Inherits="public_Theories_Timeline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
  <form id="frmTheoriesTimeline" runat="server">
    <!-- region content - used for the site main content -->
    <section id="w-content" class="region">
        <div class="region-inner clearfix">
            <div class="block twelve ps-nested">
                <div class="block-inner clearfix">
                    <div id="title-block" class="block seven">
                        <div class="block-inner">
                            <div class="block-content">
                                <!-- replace with page title -->
                                <h1 id="page-title" class="block-title">Theories Timeline<a class="add-icon" href="theory-edit-page.aspx">Add Theory</a></h1>
                                <!-- end - replace page title -->
                            </div>
                        </div>
                    </div>

                    <div id="title-right" class="block five">
                        <div class="block-inner">
                            <div class="block-content">
                                <!-- replace with the real content -->
                                <a href="Browse-Theories.aspx" class="theoryIcon">View Theories List</a>
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
                                                <input title="Enter the terms you wish to search for." type="search" id="search-text" name="search_block_form" value="" class="form-text">
                                            </div>
                                        </div>
                                        <div class="form-actions form-widget" id="form-actions">
                                            <input type="submit" id="form-submit" name="op" value="find theories" class="form-submit">
                                        </div>
                                    </div>
                                <%--</form>--%>
                                <!-- end - replace with search form -->
                            </div>
                        </div>
                    </div>

                    <%--<form action="/" method="post" id="search-block-filters" class="filters-form">--%>
                        <div class="form-wrapper clearfix">

                            <div id="filters-publish-on" class="block three">
                                <div class="block-inner">
                                    <div class="block-content form-widget">
                                        <!-- replace with first published form field -->
                                        <label for="first-published-filter">First published between</label>
                                        <asp:DropDownList ID="ddlPubYear_Filter1" runat ="server" ssClass="form-select"  AppendDataBoundItems="true"
                        DataTextField="YearPublished" DataValueField="YearPublished">
                    <asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem>
                    </asp:DropDownList>

                                        <!-- end - replace with first published form field -->
                                    </div>
                                </div>
                            </div>

                            <div id="filters-constructs" class="block three">
                                <div class="block-inner">
                                    <div class="block-content form-widget">
                                        <!-- replace with construct form field -->
                                        <label for="first-published-filter">and</label>
                                       <div class="form-item form-item-select">
                    <asp:DropDownList ID="ddlPubYear_Filter2" runat ="server" ssClass="form-select"  AppendDataBoundItems="true"
                        DataTextField="YearPublished" DataValueField="YearPublished">
                    <asp:ListItem Text="All" Value ="all" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
			  </div>
                                        <!-- end - replace with construct form field -->
                                    </div>
                                </div>
                            </div>

                            <div id="filters-actions" class="block two">
                                <div class="block-inner">
                                    <div class="block-content form-widget">
                                        <!-- replace with construct form field -->
                                        <div class="action-wrapper action-submit">
                                            <input class="form-submit" type="submit" id="" name="" value="Go"></div>
                                        <div class="action-wrapper action-reset">
                                            <input type="submit" id="" name="op" value="Reset" class="form-submit reset"></div>
                                        <!-- end - replace with construct form field -->
                                    </div>
                                </div>
                            </div>

                        </div>
                    <%--</form>--%>

                </div>
            </div>

            <!--<div class="block twelve w-timeline-pager  w-timeline-pager-top" style="">
	      <ul>
		<li class="w-tm-left"><a href="#"><span class="element-invisible">Go left</span></a></li>
		<li class="w-tm-right"><a href="#"><span class="element-invisible">Go right</span></a></li>
	      </ul>
	    </div>-->

            <div id="main-content-area" class="block twelve ps-nested theo-timeline-new">
                <div class="block-inner">

                    <!--<div id="ps-accordion-1" class="w-accordion w-timeline" style="width:100%; min-width: 310px; height: auto; min-height: 3000px; margin: 0 auto"></div>-->
                    <div id='placement'></div>

                    <!-- end - replace with main page content -->

                </div>
            </div>

            <!--<div class="block twelve w-timeline-pager" style="">
	      <ul>
		<li class="w-tm-left"><a href="#"><span class="element-invisible">Go left</span></a></li>
		<li class="w-tm-right"><a href="#"><span class="element-invisible">Go right</span></a></li>
	      </ul>
	    </div>-->

        </div>
    </section>
  </form>  

    <!-- region below the main content - can be used for extra blocks -->
    <section id="w-content-bottom" class="region">
        <div class="region-inner clearfix">
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JsHolder" Runat="Server">   
    <script src="/public/Scripts/js/timeglider/js/json2.js" type="text/javascript" charset="utf-8"></script>
    <!--<script src="timeglider/js/jquery-ui-1.10.3.custom.min.js" type="text/javascript" charset="utf-8"></script>-->
    <script src="/public/Scripts/js/timeglider/js/underscore-min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/backbone-min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/jquery.tmpl.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/ba-debug.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/ba-tinyPubSub.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/jquery.mousewheel.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/jquery.ui.ipad.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/js/globalize.js" type="text/javascript" charset="utf-8"></script>	
    <script src="/public/Scripts/js/timeglider/timeglider/TG_Date.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/timeglider/TG_Org.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/timeglider/TG_Timeline.js" type="text/javascript" charset="utf-8"></script> 
    <script src="/public/Scripts/js/timeglider/timeglider/TG_TimelineView.js" type="text/javascript" charset="utf-8"></script>
    <script src="/public/Scripts/js/timeglider/timeglider/TG_Mediator.js" type="text/javascript" charset="utf-8"></script> 
    <script src="/public/Scripts/js/timeglider/timeglider/timeglider.timeline.widget.js" type="text/javascript"></script>
    <script src="/public/Scripts/js/timeglider/timeglider/timeglider.datepicker.js" type="text/javascript"></script>
    <script src="/public/Scripts/js/timeglider/js/jquery.jscrollpane.min.js" type="text/javascript"></script>
    <script type='text/javascript'>
      var tg1 = {};
      $(function () { 
        // jQuery widget implementation
        // with some basic options
        tg1 = $("#placement").timeline({ 
          "min_zoom":1, 
          "max_zoom":55, 
          "image_lane_height":100,
          "icon_folder": "/public/Scripts/js/timeglider/timeglider/icons/",
          "data_source": "/public/getTheoryTimeline.aspx",
          "constrain_to_data": false,
          "show_centerline": false,
          //"show_footer": false,
          "mousewheel": "pan", // "zoom" or "none"
        });
        tg_actor = tg1.data("timeline");
        $('.tg-timeline-start').text('Reset Timeline');
        //tg_actor.goTo("today");
        //$(".goTo").click(function() {
        //  var date = "1995-04-01";
        //  var zoom = 35;
        //  tg_actor.goTo(date,zoom);
        //});
        // You'll use tg_actor as the key to access 
        // public API methods like "goTo", etc.
      }); // end document-ready
      $(document).ready(function () {
          $('#bottom-pager').append($('#top-pager-content').html());

          $('body').removeClass("frontpage");
      });
    </script>
    
</asp:Content>

