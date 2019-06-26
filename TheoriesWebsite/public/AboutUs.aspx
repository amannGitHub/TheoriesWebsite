<%@ Page Title="" Language="VB" MasterPageFile="~/public/Site.master" AutoEventWireup="false" CodeFile="AboutUs.aspx.vb" Inherits="public_AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMasterTitle" Runat="Server">
     <asp:literal ID="ltltitle" runat="server">About-Theories</asp:literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
 <style>
     #leftpane, #MidPane, #RightPane 
     {
      width: 27%;
      float: left;
      padding:20px;
      height: 600px;
     }

      #leftpane{
          margin-top:10px;
          margin-right:20px;
          background-color:#E6EEF5;
      }
      #MidPane{
          margin:10px 20px 20px 20px;
          background-color:#fff7e5;
      }
      #RightPane{
          margin:10px 20px 20px 20px;
          background-color:#EFEEEC;
      }
     h3.block-title {
         font-family: Bitter;
         font-size: 20px;
         line-height: 25px;
         margin-bottom: 10px;
         color: #116172;
         font-weight: 700;
     }
   
 </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
     <section id="w-content" class="region">
          <div class="region-inner clearfix">
	    
	    <div class="block twelve ps-nested">
	      <div class="block-inner clearfix">
		
		<div id="title-block" class="block seven">
		  <div class="block-inner">
		    <div class="block-content">
		      <!-- replace with page title -->
		      <h1 id="page-title" class="block-title">About Theories</h1>
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
            
            <div class="block two-third ps-nested">
              <div class="block-inner">
		  
		<div id="theo-what-is" class="block half about-theory">
		  <div class="block-inner ps-uniHeight">
		    <h2 class="block-title">What is theory?</h2>
		    <div class="block-content ps-uniHeight">
		      <!-- replace with the real content -->
		      <p>
			Regardless of scientific field, a theory is a
systematic set of concepts, definitions, and
propositions that specify the relations
among concepts for the purpose of
explaining or predicting phenomena.
Health behavior theories describe the
relations among concepts (aka constructs)
or factors for the purpose of explaining and
predicting health behaviors such as
smoking, dietary intake, exercise, cancer
screenings, and sun exposure.</p>
<p><em>*Omnimilia volum qui tem volest premqui
dissimp orrovitium nihil mossiminit et
omni. NCI, NIH (2005)</em>
		      </p>
		      
		      
		      <div class="custom-highlight">
			<p class="ct-intro">Learn about theories using the interactive Theories Timeline</p>
			<p><a href="Theories_Timeline.aspx" class="theoryIcon">View Theories Timeline</a></p>
		      </div>
		      <!-- end - replace with the real content -->
		    </div>
		  </div>
		</div>
		
		<div id="theo-diff" class="block half about-theory">
		  <div class="block-inner ps-uniHeight">
		    <h2 class="block-title">What's the difference between a theory, a model and a framework?</h2>
		    <div class="block-content ps-uniHeight">
		      <!-- replace with the real content -->
		      <p>Some of the health behavior theories
entered by the community on the Theory
Portal are not technically "theories" in that
they were not intended to explain or predict
health behaviors but instead to categorize
the various determinants of behavior or
processes of behavior change (e.g., social
ecological model, stages of change).
Technically, these are better described as
conceptual models, not theories, but some
models are named theories and vice versa.
Regardless of terminology, the ability to
explain and predict behavior is a core
attribute of a behavior theory. These
theories and models are often used to
construct frameworks for measurement or
intervention. A theoretical framework may
draw on a number of theories to help
understand a particular problem in a certain
setting or context.*</p>
<p><em>*Adapted from Glanz K, Rimer BK. Theory at a
glance: A guide for health promotion practice.
NCI, NIH (2005)</em></p>
		      <!-- end - replace with the real content -->
		    </div>
		  </div>
		</div>
                  
              </div>
            </div>
            
            <div id="theo-why-use" class="block one-third ps-full-portrait clearafter about-theory">
              <div class="block-inner ps-uniHeight">
                <h2 class="block-title">Why use theory, theoretical model, or theoretical framework?</h2>
                <div class="block-content ps-uniHeight ps-portrait-auto">
		  <!-- replace with the real content -->
		  <p>Theories are derived from observational
data and hypothesis testing but also serve
as the basis for determining what to
observe and hypothesize. Therefore,
health behavior theories play an important
role in deciding what to measure and test
in health behavior research, and the results
from theory-informed research further
supports, modifies, or refutes that theory.
Health behavior theories or theoretical
models and frameworks also can play an
important role in intervention development
and health program planning. They can be
used to design and evaluate health
behavior and health promotion
interventions based on an understanding
of human behavior. Most effective public
health programs achieve desired outcomes
based on a clear understanding of targeted
health behaviors, and the environmental
context in which they occur.*</p><p><em>
*Adapted from Glanz K, Rimer BK. Theory at
a glance: A guide for health promotion
practice. NCI, NIH (2005)</em></p>
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
<asp:Content ID="Content4" ContentPlaceHolderID="JsHolder" Runat="Server">
     <script type="text/javascript">
         $(document).ready(function () {
             $('body').removeClass("frontpage");
         });
    </script>
</asp:Content>

