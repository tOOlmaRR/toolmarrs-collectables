<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sitemap.aspx.cs" EnableViewState="false" Inherits="GeoTradingCards.Sitemap" MasterPageFile="~/Main.Master" Title="Geo Trading Cards - Sitemap" %>
<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/MainFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="keywords" content="geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables" />
	<meta name="description" content="Geo Trading Cards - A quick and easy way to navigate through our website." />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Sitemap</h1>
	<div id="sitemap">
		<div id="column1">
		<ul class="level1">
			<li><asp:HyperLink NavigateUrl="~/default.aspx" Text="Homepage" ToolTip="Homepage" runat="server" /></li>
			<li><asp:HyperLink NavigateUrl="~/Shop/Shop.aspx" Text="The Card Shop" ToolTip="The Card Shop" runat="server"/></li>
			<ul class="level2">
				<li><asp:HyperLink NavigateUrl="~/Shop/Baseball.aspx" Text="Baseball Cards" ToolTip="Baseball Cards" runat="server" /></li>
				<li><asp:HyperLink NavigateUrl="~/Shop/Hockey.aspx" Text="Hockey Cards" ToolTip="Hockey Cards" runat="server" /></li>
				<ul class="level3">
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=1998-99&set=Pacific Omega" Text="1998-99 Pacific Omega" ToolTip="1998-99 Pacific Omega" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=1998-99&set=Upper Deck Gold Reserve" Text="1998-99 Upper Deck Gold Reserve" ToolTip="1998-99 Upper Deck Gold Reserve" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2000-01&set=Be A Player Memoribilia" Text="2000-01 Be A Player Memoribilia" ToolTip="2000-01 Be A Player Memoribilia" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2000-01&set=Topps Gold Label" Text="2000-01 Topps Gold Label" ToolTip="2000-01 Topps Gold Label" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2002-03&set=Upper Deck" Text="2002-03 Upper Deck" ToolTip="2002-03 Upper Deck" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2003-04&set=Upper Deck Victory" Text="2003-04 Upper Deck Victory" ToolTip="2003-04 Upper Deck Victory" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2005-06&set=Heroes and Prospects" Text="2005-06 In The Game - Heroes and Prospects" ToolTip="2005-06 In The Game - Heroes and Prospects" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2005-06&set=Ultimate Collection" Text="2005-06 Ultimate Collection" ToolTip="2005-06 Ultimate Collection" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2005-06&set=Upper Deck Ice" Text="2005-06 Upper Deck Ice" ToolTip="2005-06 Upper Deck Ice" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2005-06&set=Parkhurst" Text="2005-06 Parkhurst" ToolTip="2005-06 Parkhurst" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2006-07&set=Fleer" Text="2006-07 Fleer" ToolTip="2006-07 Fleer" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2006-07&set=Mini Jersey Collection" Text="2006-07 Mini Jersey Collection" ToolTip="2006-07 Mini Jersey Collection" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2006-07&set=O-Pee-Chee" Text="2006-07 O-Pee-Chee" ToolTip="2006-07 O-Pee-Chee" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2006-07&set=Parkhurst" Text="2006-07 Parkhurst" ToolTip="2006-07 Parkhurst" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2006-07&set=Upper Deck Victory" Text="2006-07 Upper Deck Victory" ToolTip="2006-07 Upper Deck Victory" runat="server" /></li>
					
					<%--2007-08--%>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck Artifacts" Text="2007-08 Upper Deck Artifacts" ToolTip="2007-08 Upper Deck Artifacts" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Black Diamond" Text="2007-08 Upper Deck Black Diamond" ToolTip="2007-08 Upper Deck Black Diamond" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Heroes and Prospects" Text="2007-08 In The Game - Heroes and Prospects" ToolTip="2007-08 In The Game - Heroes and Prospects" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Mini Jersey Collection" Text="2007-08 Mini Jersey Collection" ToolTip="2007-08 Mini Jersey Collection" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=O-Pee-Chee" Text="2007-08 O-Pee-Chee" ToolTip="2007-08 O-Pee-Chee" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck" Text="2007-08 Upper Deck" ToolTip="2007-08 Upper Deck" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck Ice" Text="2007-08 Upper Deck Ice" ToolTip="2007-08 Upper Deck Ice" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck MVP" Text="2007-08 Upper Deck MVP" ToolTip="2007-08 Upper Deck MVP" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck Trilogy" Text="2007-08 Upper Deck Trilogy" ToolTip="2007-08 Upper Deck Trilogy" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck SPx" Text="2007-08 Upper Deck SPx" ToolTip="2007-08 Upper Deck SPx" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2007-08&set=Upper Deck Victory" Text="2007-08 Upper Deck Victory" ToolTip="2007-08 Upper Deck Victory" runat="server" /></li>
					
					<%--2008-09--%>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Be A Player" Text="2008-09 Be A Player" ToolTip="2008-09 Be A Player" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Black Diamond" Text="2008-09 Black Diamond" ToolTip="2008-09 Black Diamond" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Fleer Ultra" Text="2008-09 Fleer Ultra" ToolTip="2008-09 Fleer Ultra" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=O-Pee-Chee" Text="2008-09 O-Pee-Chee" ToolTip="2008-09 O-Pee-Chee" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=O-Pee-Chee Premier" Text="2008-09 O-Pee-Chee Premier" ToolTip="2008-09 O-Pee-Chee Premier" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=SP Authentic" Text="2008-09 SP Authentic" ToolTip="2008-09 SP Authentic" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=SP Game Used" Text="2008-09 SP Game Used" ToolTip="2008-09 SP Game Used" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Upper Deck Artifacts" Text="2008-09 Upper Deck Artifacts" ToolTip="2008-09 Upper Deck Artifacts" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Upper Deck Ice" Text="2008-09 Upper Deck Ice" ToolTip="2008-09 Upper Deck Ice" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Upper Deck MVP" Text="2008-09 Upper Deck MVP" ToolTip="2008-09 Upper Deck MVP" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Upper Deck SPx" Text="2008-09 Upper Deck SPx" ToolTip="2008-09 Upper Deck SPx" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Upper Deck Trilogy" Text="2008-09 Upper Deck Trilogy" ToolTip="2008-09 Upper Deck Trilogy" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2008-09&set=Upper Deck Victory" Text="2008-09 Upper Deck Victory" ToolTip="2008-09 Upper Deck Victory" runat="server" /></li>
					
					<%--2009-10--%>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2009-10&set=McDonalds" Text="2009-10 McDonalds" ToolTip="2009-10 McDonalds" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2009-10&set=Upper Deck Artifacts" Text="2009-10 Upper Deck Artifacts" ToolTip="2009-10 Upper Deck Artifacts" runat="server" /></li>
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2009-10&set=Upper Deck MVP" Text="2009-10 Upper Deck MVP" ToolTip="2009-10 Upper Deck MVP" runat="server" /></li>					
					<li><asp:HyperLink NavigateUrl="~/Shop/InventoryListing.aspx?season=2009-10&set=Upper Deck Victory" Text="2009-10 Upper Deck Victory" ToolTip="2009-10 Upper Deck Victory" runat="server" /></li>

                    <%--2010-11--%>

				</ul>
				<li><asp:Hyperlink NavigateUrl="~/Shop/Ordering.aspx" Text="How To Order" ToolTip="How To Order" runat="server" /></li>
				<li><asp:Hyperlink NavigateUrl="~/Shop/Shipping.aspx" Text="Shipping Policy" ToolTip="Shipping Policy" runat="server" /></li>
				<li><asp:Hyperlink NavigateUrl="~/Shop/Returns.aspx" Text="Return Policy" ToolTip="Return Policy" runat="server" /></li>
				<li><asp:Hyperlink NavigateUrl="~/Shop/Grading.aspx" Text="Grading Guidelines" ToolTip="Grading Guidelines" runat="server" /></li>
			</ul>
			<li><asp:Hyperlink NavigateUrl="~/About.aspx" Text="About Us" ToolTip="About Us" runat="server" /></li>
			<li><asp:Hyperlink NavigateUrl="~/Contact.aspx" Text="Contact Us" ToolTip="Contact Us" runat="server" /></li>
			<li><asp:Hyperlink NavigateUrl="~/Links.aspx" Text="Links" ToolTip="Links" runat="server" /></li>
			<li><asp:Hyperlink NavigateUrl="~/Sitemap.aspx" Text="Sitemap" ToolTip="Sitemap" runat="server" /></li>
		</ul>
		</div>
	</div>
</asp:Content>