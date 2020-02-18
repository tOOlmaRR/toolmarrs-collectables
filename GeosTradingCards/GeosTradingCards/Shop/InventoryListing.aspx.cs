using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoTradingCards.Controls;

namespace GeoTradingCards.Shop
{
	public partial class InventoryListing : System.Web.UI.Page
	{
		private string _season;
		private string _set;
		private string _listingsURL;
		private string _cardSetCategory = "Hockey";

		#region Page Lifecycle
		protected override void OnInit(EventArgs e)
		{
			try
			{
				base.OnInit(e);
				if (Request.QueryString.Count > 0)
				{
					if (Request.QueryString.AllKeys.Contains("season"))
					{
						_season = Request.QueryString["season"].ToString() ?? string.Empty;
					}
					if (Request.QueryString.AllKeys.Contains("set"))
					{
						_set = Request.QueryString["set"].ToString() ?? string.Empty;
					}

					// security: check for "script" in case someone turns server request validation off for some reason
					if (string.IsNullOrEmpty(_season) || (string.IsNullOrEmpty(_set))
					|| (_season.ToLower().Contains("script")) || (_set.ToLower().Contains("script")))
					{
						Response.Redirect("/Shop/Shop.aspx");
					}
				}
				else
				{
					Response.Redirect("/Shop/Shop.aspx");
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
			
		}

		protected override void OnLoad(EventArgs e)
		{
			try
			{
				base.OnLoad(e);

				// determine and set page title
				string pageTitle = _season + " " + _set;
				litPageTitle.Text = Page.Title = pageTitle;

				// Set Breadcrumbs
				Breadcrumbs ucBreadcrumbs = (Breadcrumbs)this.Master.FindControl("ucBreadcrumbs");
				if (ucBreadcrumbs != null)
				{
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("The Card Shop", "~/Shop/Shop.aspx"));
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("Hockey Cards", "~/Shop/Hockey.aspx"));
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb(pageTitle, Request.RawUrl));
				}

				// set meta tags
				metaKeywords.Attributes.Add("content", "geo trading cards, george u marr enterprises, hockey cards, trading cards, hockey, collectables, " + string.Format("{0} {1}, ", _season, _set) + string.Format("{0} {1} hockey, ", _season, _set) + string.Format("{0} {1} hockey cards", _season, _set));
				metaDescription.Attributes.Add("content", string.Format("Geo Trading Cards - A listing of all {0} {1} hockey cards which we have available for purchase or trade, including any insert or parallel sets.", _season, _set));

				// Determine the source URL of the listings IFRAME
				string url = DAL.GoogleDocsManager.GetGoogleDocUrl(_season, _set);
				if (string.IsNullOrEmpty(url))
					Response.Redirect("/Shop/Shop.aspx");
				else
					_listingsURL = url;
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}

		protected override void OnPreRender(EventArgs e)
		{
			try
			{
				base.OnPreRender(e);
				if (!string.IsNullOrEmpty(_listingsURL))
				{
					cardListingFrame.Attributes["src"] = _listingsURL;
					this.Page.Title = string.Format("Geo Trading Cards - {0} {1} {2} Cards", _season, _set, _cardSetCategory);
				}
				else
				{
					pnlCardListing.Visible = false;
					pnlError.Visible = true;
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}
		#endregion
	}
}