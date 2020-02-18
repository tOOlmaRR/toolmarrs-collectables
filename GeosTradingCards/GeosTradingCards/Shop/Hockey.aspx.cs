using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoTradingCards.Controls;
using System.Web.UI.HtmlControls;

namespace GeoTradingCards.Shop
{
	public partial class Hockey : System.Web.UI.Page
	{
		private string _redirectURL = "~/Shop/InventoryListing.aspx?";
		private List<string> _seasons;
		private string _seasonParam = string.Empty;
		private string _setParam = string.Empty;

		#region Page Lifecycle
		protected override void OnInit(EventArgs e)
		{
			try
			{
				base.OnInit(e);
				if (!Page.IsPostBack)
				{
					InitializeSeasonDropdown();
					InitializeCardSetDropdown();
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
				ddlSeason.Enabled = false;
				ddlCardSet.Enabled = false;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				Breadcrumbs ucBreadcrumbs = (Breadcrumbs)this.Master.FindControl("ucBreadcrumbs");
				if (ucBreadcrumbs != null)
				{
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("The Card Shop", "~/Shop/Shop.aspx"));
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("Hockey", "~/Shop/Hockey.aspx"));
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}
		#endregion

		#region Helper Methods
		private void InitializeSeasonDropdown()
		{
			_seasons = DAL.GoogleDocsManager.GetAllSeasons();
			ddlSeason.Items.Add(new ListItem("-- Choose a Season --", "-1"));
			foreach (string season in _seasons)
			{
				ddlSeason.Items.Add(season);
			}
		}

		private void InitializeCardSetDropdown()
		{
			ddlCardSet.Items.Clear();
			ddlCardSet.Items.Add(new ListItem("-- Choose a Card Set --", "-1"));
		}

		#endregion

		#region Event Handlers
		protected void ddlSeason_SelectedIndexChanged(Object sender, EventArgs e)
		{
			InitializeCardSetDropdown();
			List<string> sets = DAL.GoogleDocsManager.GetSetsBySeason(ddlSeason.SelectedValue);
			foreach (string set in sets)
			{
				ddlCardSet.Items.Add(new ListItem(set));
			}
			ddlCardSet.Enabled = true;
			ddlCardSet.Focus();
		}

		protected void btnBrowse_OnClick(object sender, EventArgs e)
		{
			_seasonParam = "season=" + ddlSeason.SelectedValue + "&";
			_setParam = "set=" + ddlCardSet.SelectedItem.Text;
			if (ddlSeason.SelectedIndex > 0 && ddlCardSet.SelectedIndex > 0)
			{
				Response.Redirect(_redirectURL + _seasonParam + _setParam);
			}
			else
			{
				trErrorRow.Visible = true;
				ddlSeason.Focus();
			}
		}

		#endregion
	}
}