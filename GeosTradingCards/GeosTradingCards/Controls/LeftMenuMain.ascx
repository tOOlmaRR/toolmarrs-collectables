<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeftMenuMain.ascx.cs" Inherits="GeoTradingCards.Controls.LeftMenuMain" %>

<ul id="leftMenu">
	<li>
		<asp:HyperLink ID="hlHockey" NavigateUrl="~/Shop/Hockey.aspx" ToolTip="Hockey Cards" runat="server"><asp:Label CssClass="leftMenuLink" runat="server">Hockey Cards</asp:Label></asp:HyperLink>
	</li>
	<li>
		<asp:HyperLink ID="hlBaseball" NavigateUrl="~/Shop/Baseball.aspx" ToolTip="Hockey Cards" runat="server"><asp:Label ID="Label1" CssClass="leftMenuLink" runat="server">Baseball Cards</asp:Label></asp:HyperLink>
	</li>
	<%--<li>
		<a href="#"><span class="leftMenuLink">Basketball Cards</span></a>
	</li>
	<li>
		<a href="#"><span class="leftMenuLink">Football Cards</span></a>
	</li>
	<li>
		<a href="#"><span class="leftMenuLink">Soccer Cards</span></a>
	</li>
	<li>
		<a href="#"><span class="leftMenuLink">Non-Sports Cards</span></a>
	</li>
	<li>
		<a href="#"><span class="leftMenuLink">Card Games (CCGs)</span></a>
	</li>--%>
</ul>