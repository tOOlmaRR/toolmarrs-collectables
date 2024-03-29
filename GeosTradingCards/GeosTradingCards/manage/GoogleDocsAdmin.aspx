﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoogleDocsAdmin.aspx.cs" Inherits="GeoTradingCards.manage.GoogleDocsAdmin" MasterPageFile="~/Main.Master" Title="Google Docs Admin Tool" %>

<%@ Register TagPrefix="LeftMenu" TagName="Main" Src="~/Controls/LeftMenuMain.ascx" %>
<%@ Register TagPrefix="Ad" TagName="MediumRectangleROS" Src="~/Controls/Advertising/MedRectangleROS.ascx" %>
<%@ Register TagPrefix="Nav" TagName="Footer" Src="~/Controls/AdminFooter.ascx" %>
<%@ MasterType VirtualPath="~/Main.Master" %>

<asp:Content ID="metaTags" ContentPlaceHolderID="metaTags" runat="server">
	<meta name="ROBOTS" content="NOINDEX, NOFOLLOW" />
</asp:Content>

<asp:Content ID="leftMenuContent" ContentPlaceHolderID="cpleftMenu" runat="server">
	<LeftMenu:Main ID="leftMenuControl" runat="server" />
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="PageContent" runat="server">
	<h1>Google Docs Admin Tool</h1>
	<h2>Insert New Google Doc</h2>
	<table role="presentation" style="width:100%;">
		<tr>
			<td class="style1">
				<asp:Label ID="Label2" AssociatedControlID="ddlSeasons" runat="server" Text="Season"></asp:Label>
			</td>
			<td>
				<asp:DropDownList ID="ddlSeasons" runat="server" />
			</td>
		</tr>
		<tr>
			<td class="style1">
				<asp:Label ID="Label3" AssociatedControlID="tbCardSet" runat="server" Text="Card Set"></asp:Label>
			</td>
			<td>
				<asp:TextBox ID="tbCardSet" runat="server" Width="245px"></asp:TextBox>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
					ControlToValidate="tbCardSet" ErrorMessage="*"></asp:RequiredFieldValidator>
			</td>
		</tr>
		<tr>
			<td class="style1">
				<asp:Label ID="Label4" AssociatedControlID="tbGoogleDocUrl" runat="server" Text="Google Doc URL"></asp:Label>
			</td>
			<td>
				<asp:TextBox ID="tbGoogleDocUrl" runat="server" Width="624px"></asp:TextBox>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
					ControlToValidate="tbGoogleDocUrl" ErrorMessage="*"></asp:RequiredFieldValidator>
			</td>
		</tr>
		<tr>
			<td class="style1">
				&nbsp;</td>
			<td>
				<asp:Button ID="btnInsert" runat="server" onclick="btnInsert_Click" 
					Text="Insert!" />
				<asp:Label ID="lbInsertError" runat="server" ForeColor="Red" 
					Text="Insert Failed!" Visible="False"></asp:Label>
			</td>
		</tr>
	</table>
	<h2></h2>
	<div class="admin">
		<asp:GridView ID="gvGoogleDocs" CssClass="googleDocMgr" runat="server"
			Caption="Manage Existing Google Docs" CaptionAlign="Left"
			AutoGenerateColumns="False" AutoGenerateDeleteButton="True" AutoGenerateEditButton="True"
			DataSourceID="GoogleDocs" OnRowDeleting="gvGoogleDocs_RowDeleting" onrowediting="gvGoogleDocs_RowEditing" 
			onrowupdating="gvGoogleDocs_RowUpdating" DataKeyNames="ID">
			<Columns>
				<asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" 
					SortExpression="ID" InsertVisible="False" />
				<asp:BoundField DataField="Season" HeaderText="Season" 
					SortExpression="Season" />
				<asp:BoundField DataField="Set" HeaderText="Set" SortExpression="Set" />
				<asp:BoundField DataField="GoogleDocsUrl" HeaderText="GoogleDocsUrl"
					SortExpression="GoogleDocsUrl" />
			</Columns>
		</asp:GridView>
		<asp:LinqDataSource ID="GoogleDocs" runat="server" 
			ContextTypeName="GeoTradingCards.DAL.GoogleDocsDataContext" 
			TableName="GoogleDocsPages" OrderBy="Season, Set" EnableDelete="True" 
			EnableInsert="True" EnableUpdate="True">
		</asp:LinqDataSource>
		
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="css">

	<style type="text/css">
		.style1
		{
			width: 125px;
		}
	</style>
</asp:Content>
