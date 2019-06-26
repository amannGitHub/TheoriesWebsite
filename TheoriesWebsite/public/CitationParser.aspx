<%@ Page Title="" Language="VB"  AutoEventWireup="false" CodeFile="CitationParser.aspx.vb" Inherits="public_CitationParser" %>
<html>
<head>
    <title></title>
</head>
<body>

    <form id="frm1" runat="server">
     <div class="row">
        <div class="col-md-8">
            <asp:TextBox ID="txtCitation" runat="server" TextMode="MultiLine" Rows="4" Width="800px" style="text-align:left">Albada A, Ausems M, Bensing J, van Dulmen S. 2009. Tailored information about cancer risk and screening: A systematic review. Patient Educ. Couns.  77: 155-171, 2009.</asp:TextBox>
           <br />
            <asp:Button ID="btnParse" runat="server" CssClass="btn btn-primary btn-lg" Text="Parse" OnClick="btnParse_Click"/>     
        </div> 
        <div class="col-md-4">
           
        </div> 
    </div>
      <br /><br />
    <div class="row">
        <div class="col-md-8">
             <strong>Valid:</strong> <asp:Label ID="lblIsValid" runat="server"></asp:Label> <br />
             <strong>Title:</strong> <asp:Label ID="lblTitle" runat="server"></asp:Label>  <br />
             <strong>Authors:</strong> <asp:Label ID="lblAuthors" runat="server"></asp:Label>  <br />
             <strong>Journal:</strong> <asp:Label ID="lblJournal" runat="server"></asp:Label>  <br />
             <strong>Publisher:</strong> <asp:Label ID="lblPublisher" runat="server"></asp:Label>  <br />
             <strong>Volume:</strong> <asp:Label ID="lblVolume" runat="server"></asp:Label>  <br />
             <strong>Pages:</strong> <asp:Label ID="lblPages" runat="server"></asp:Label>  <br />
             <strong>Year:</strong> <asp:Label ID="lblYear" runat="server"></asp:Label>  <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
           <h3>Return XML</h3>
            <strong>Status:</strong> <asp:Label ID="lblStatus" runat="server"></asp:Label> <br />
            <strong>Parser String:</strong> <asp:Literal ID="lblCitation" runat="server" Mode="Encode"></asp:Literal>
        </div>
        <div class="col-md-4">
             
        </div>
    </div>
        </form>

</body>
</html>