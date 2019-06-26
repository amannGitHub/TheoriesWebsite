<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="Home.aspx.vb" Inherits="Home" %>
<asp:Content ID="contentChildTitle" ContentPlaceHolderID="cphMasterTitle" runat="server">
    <asp:literal ID="ltltitle" runat="server">Home</asp:literal>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        h3{
            margin-bottom: 10px;
            margin-top: 15px;
        }
        ul li {
            margin-bottom: 10px;
        }
        h2.block-title {
            margin-bottom: 0px;
        }
        #breadcrumb .block-content {
    /* padding-top: 10px; */
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <section id="w-highlight-home" class="region">
          <div class="region-inner clearfix">
	    
	    <div id="welcome" class="block four">
              <div class="block-inner">
		<h1 id="page-title" class="element-invisible">Welcome Message</h1>
		<div class="block-content">
		  <!-- replace with the real welcome content -->
		  <p>Welcome to the Health Behavior Theories Portal.
		    The Behavioral Research Program (BRP) aim to
		    provide an interactive web portal for theory-related
		    resources and training materials for cancer
		    prevention and control researchers.
		  </p>
		  <p>The target audiences for this theory web resource are:</p>
		  <ul>
		    <li>Individuals who are new to theory and/or have no
			prior theoretical training.</li>
		    <li>Researchers trained in disciplines other than the
			behavioral sciences who have no prior exposure
			to health behavior theories</li>
		    <li>Researchers who would like to augment their
		    theoretical knowledge.</li>
		  </ul>
		  <!-- end - replace with the real welcome content -->
		</div>
	      </div>
	    </div>
	    
            <div id="slide" class="block eight">
              <div class="block-inner">
                <div class="block-content">
		  
                <!-- Slideshow with owl-carousel-->
		  <div id="ps-slider-home" class="owl-carousel owl-theme">
          <div class="item slide1">
		      <img src="../Content/images/slides/image_slider_hand_diagram_850x330.png" alt="slide 1">
		      <div class="caption">
			        <p class="captionDetail">Health Belief Model<br />(HBM)</p>
			        <p class="captionDetailBody">
                            The Health Belief Model (HBM) was developed in the 1950s as an explanation for why medical 
                            screening programs offered by the U.S. Public Health Service, such as the one for tuberculosis, 
                            were not successful.
			        </p>
			        <p class="captionButton">
			            <span class="item-type theory"><span class="element-invisible">Theory</span></span>
			            <a href="Theory_details.aspx?TID=12" role="button">learn more</a>
			        </p>
		      </div>
          </div>
          <div class="item slide2">
		        <img src="../Content/images/slides/image_slider_heads_gears_850x330.png" alt="slide 2">
                <div class="caption">
			        <p class="captionDetail">6th Annual Advanced Training Institute on Health Behavior Theory<br />(HBM)</p>
			        <p class="captionDetailBody">
                        The Advanced Training Institute on Health Behavior Theory is a 7-day intensive learning course for new or early investigators.
			        </p>
			        <p class="captionButton">
            			  <span class="item-type biblio"><span class="element-invisible">Bibliography</span></span>
			              <a href="http://cancercontrol.cancer.gov/workshop/" role="button" target="_blank">learn more</a>
        			</p>
                </div>
            </div>
            <div class="item slide3">
                <img src="../Content/images/slides/image_slider_cigarette_850x330.png" alt="slide 3">
                      <div class="caption">
			    <p class="captionDetail">Predicting smoking reduction among adolescents</p>
			    <p class="captionDetailBody">
                    This study tested the ability of the theory of planned behaviour (TPB) to predict adolescents’ intentions to reduce 
                    smoking and the subsequent behaviour one year later.
			    </p>
			    <p class="captionButton">
			        <span class="item-type biblio"><span class="element-invisible">Bibliography</span></span>
			        <a href="Citation_details.aspx?citationid=9" role="button">learn more</a>
			    </p>
		      </div>
            </div>
            <div class="item slide4">
                <img src="../Content/images/slides/image_slider_femaleDoc_patients_850x330.png" alt="slide 4">
                    <div class="caption">
			            <p class="captionDetail">Behaviorism Wiki</p>
			            <p class="captionDetailBody">
                                Behaviorism (or behaviourism) is an approach to psychology that focuses on an individual's behavior. 
                                It combines elements of philosophy, methodology, and theory.
                        </p>
                        <p class="captionButton">
			                <span class="item-type resource"><span class="element-invisible">Resource</span></span>
			                <a href="Resource_details.aspx?RID=13" role="button">learn more</a>
			            </p>
		            </div>
            </div>
		  </div>
		  
                </div>                
              </div>
            </div>
            
          </div>          
        </section>
        <section id="w-content" class="region">
          <div class="region-inner clearfix">
            
            <div class="block two-third ps-nested">
              <div class="block-inner">
		  
		<div id="theory-model" class="block half">
		  <div class="block-inner">
		     <h2 class="block-title">
                <div style="float: left;padding-top: 5px;">Theories and Models</div>
              
		    </h2>
            
		    <div class="block-content ps-uniHeight">
		      <!-- replace with the real content -->
		      <h3 style="margin-top:0px;">Most Viewed Theories</h3>
                 <asp:Repeater id="rptCommonTheories" EnableViewState="false"  runat="server" DataSourceID="dsobjCommonTheories" > 
    <HeaderTemplate>
   <ul class="linkList">
</HeaderTemplate> 
		       <ItemTemplate >
			<li><a href='Theory_details.aspx?tid=<%# Eval("TheoryID")%>'><%# Eval("TheoryName") %></a></li>
                   </ItemTemplate>
			   <FooterTemplate>
    </ul>
    </FooterTemplate>
    </asp:Repeater>
                 <asp:ObjectDataSource ID="dsobjCommonTheories" runat="server" SelectMethod="LoadCommonTheories"
    TypeName="HomePageBLL" >
    
</asp:ObjectDataSource>
		      <h3>Recently Added</h3>
		       <asp:Repeater id="rptRecentTheories" EnableViewState="false"  runat="server" DataSourceID="dsobjRecentTheories" > 
    <HeaderTemplate>
   <ul class="linkList">
</HeaderTemplate> 
		       <ItemTemplate >
			<li><a href='Theory_details.aspx?tid=<%# Eval("TheoryID")%>'><%# Eval("TheoryName") %> -  <%# Eval("CreateDT", "{0:d}")%></a></li>
                   </ItemTemplate>
			   <FooterTemplate>
    </ul>
    </FooterTemplate>
    </asp:Repeater>
                 <asp:ObjectDataSource ID="dsobjRecentTheories" runat="server" SelectMethod="LoadRecentTheories"
    TypeName="HomePageBLL" >
                     </asp:ObjectDataSource>

		      <div class="block-content" style="padding-top:20px;">
		      <!-- replace with the real content -->
		      <a href="Theories_Timeline.aspx" class="theoryIcon" style="display:inline;float:inherit;">View Theories Timeline</a>
		      <!-- end - replace with the real content -->
		    </div>
		      <!-- end - replace with the real content -->
		    </div>
		  </div>
		</div>
		
		<div id="train-educ" class="block half">
		  <div class="block-inner">
		    <h2 class="block-title">
                 <div style="float: left;padding-top: 5px;">Resources</div>
               
		    </h2>
		    <div class="block-content ps-uniHeight">
		      <!-- replace with the real content -->
              <h3 style="margin-top: 0px;">Recently Added</h3>
                  <asp:Repeater id="rptRecentResources" EnableViewState="false"  runat="server" DataSourceID="dsobjRecentResources" > 
    <HeaderTemplate>
   <ul class="linkList">
</HeaderTemplate> 
		       <ItemTemplate >
			<li><a href='Resource_details.aspx?RID=<%# Eval("ResourceID")%>'><%# Eval("ResourceTitle")%></a>
                <p>
                    <%# HTPUtil.TruncateAtWord(Eval("ResourceDesc"), HTPUtil.HomeDescCount)%>
                <asp:hyperlink ID="hlmore" runat="server" Cssclass="theory-more theory-more-link" NavigateUrl='<%#"~/public/Resource_details.aspx?RID=" & DataBinder.Eval(Container.DataItem, "ResourceID")%>' Visible ='<%# IIf((Eval("ResourceDesc").ToString().Length > HTPUtil.HomeDescCount), True, False)%>' Text="Read more"></asp:hyperlink>
                </p>
            
			</li>
                   </ItemTemplate>
			   <FooterTemplate>
    </ul>
    </FooterTemplate>
    </asp:Repeater>
                 <asp:ObjectDataSource ID="dsobjRecentResources" runat="server" SelectMethod="LoadRecentResources"
    TypeName="HomePageBLL" >
                     </asp:ObjectDataSource>
		      <ul class="linkList">
		    <li><a href="Browse-Resources">Browse full list of additional resources</a></li>
		  </ul>
		      <!-- end - replace with the real content -->
		    </div>
		  </div>
		</div>
                  
              </div>
            </div>

              <div id="biblio" class="block one-third ps-full-portrait clearafter">
                  <div class="block-inner">
                      <h2 class="block-title">
                          <div style="float: left; padding-top: 5px;">Bibliography</div>
                         </h2>
                      <div class="block-content ps-uniHeight ps-portrait-auto">
                          <!-- replace with the real content -->
                          <h3 style="margin-top: 0px;">Recently Added</h3>
                          <asp:Repeater ID="RptBibilography" runat="server" OnItemDataBound="RptBibilography_ItemDataBound">
                              <HeaderTemplate>
                                  <ul>
                              </HeaderTemplate>
                              <ItemTemplate>
                                  <li>
                                      <asp:Label id="hlCitation" runat= "server" Text='<%# DataBinder.Eval(Container.DataItem, "Citation")%>'></asp:Label>
                                  </li>
                              </ItemTemplate>
                              <FooterTemplate>
                                  </ul>
                              </FooterTemplate>
                          </asp:Repeater>


                          <ul class="linkList">
                              <li><a href="Bibliography">Browse full bibliography</a></li>
                          </ul>
                          <!-- end - replace with the real content -->
                      </div>
                  </div>
              </div>
          </div>
        </section>
</asp:Content>
   <asp:Content ID="Content3" ContentPlaceHolderID="jsHolder" Runat="Server">   
                 
    <script type="text/javascript">
        $(document).ready(function () {
            
            $('.breadcrumb').hide();
        });
    </script>                      
</asp:Content>
         