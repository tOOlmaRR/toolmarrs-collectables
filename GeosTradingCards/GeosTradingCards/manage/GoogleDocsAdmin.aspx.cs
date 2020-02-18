using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoTradingCards.Controls;
using GeoTradingCards.classes;

namespace GeoTradingCards.manage
{
	public partial class GoogleDocsAdmin : System.Web.UI.Page
	{
		protected override void OnInit(EventArgs e)
		{
			base.OnInit(e);
			try
			{
				List<string> seasons = GeoTradingCards.DAL.GoogleDocsManager.GetAllSeasons();
				ddlSeasons.DataSource = seasons;
				ddlSeasons.DataBind();
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}

		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad(e);
			try
			{
				Breadcrumbs ucBreadcrumbs = (Breadcrumbs)this.Master.FindControl("ucBreadcrumbs");
				if (ucBreadcrumbs != null)
				{
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("Management", "~/manage/Default.aspx"));
					ucBreadcrumbs.BreadcrumbCollection.Add(new Breadcrumbs.Breadcrumb("Google Docs Admin Tool", "~/manage/GoogleDocsAdmin.aspx"));
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
		}

		protected void gvGoogleDocs_RowEditing(object sender, GridViewEditEventArgs e)
		{
			gvGoogleDocs.EditIndex = e.NewEditIndex;
			BindData();
		}

		protected void gvGoogleDocs_RowUpdating(object sender, GridViewUpdateEventArgs e)
		{
			bool updateRecord = true;
			GoogleDoc doc = new GoogleDoc();
			if (e.NewValues.Contains("Set") && e.OldValues.Contains("Set"))
			{
				doc.Set = e.NewValues["Set"] != null ? e.NewValues["Set"].ToString() : string.Empty;
			}
			else
			{
				updateRecord = false;
				DAL.ExceptionManager.LogException(new Exception("Google Doc Update Failed"), "Could not find the SET column in the grid view control");
			}

			if (e.NewValues.Contains("Season") && e.OldValues.Contains("Season"))
			{
				doc.Season = e.NewValues["Season"] != null ? e.NewValues["Season"].ToString() : string.Empty;
			}
			else
			{
				updateRecord = false;
				DAL.ExceptionManager.LogException(new Exception("Google Doc Update Failed"), "Could not find the SEASON column in the grid view control");
			}

			if (e.NewValues.Contains("GoogleDocsUrl") && e.OldValues.Contains("GoogleDocsUrl"))
			{
				doc.Url = e.NewValues["GoogleDocsUrl"] != null ? e.NewValues["GoogleDocsUrl"].ToString() : string.Empty;
			}
			else
			{
				updateRecord = false;
				DAL.ExceptionManager.LogException(new Exception("Google Doc Update Failed"), "Could not find the \"GoogleDocsUrl\" column in the grid view control");
			}

			//if (!doc.isValidDbRow())
			//{
			//    updateRecord = false;
			//    // Display error message to user
			//}

			if (!updateRecord)
			{
				e.Cancel = true;
				gvGoogleDocs.EditIndex = -1;
				BindData();
			}
			else
			{

			}
		}

		protected void gvGoogleDocs_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
			
		}

		protected void btnInsert_Click(object sender, EventArgs e)
		{
			if (Page.IsValid)
			{
			GoogleDoc newDoc = new GoogleDoc();
			newDoc.Season = ddlSeasons.SelectedItem.Value;
			newDoc.Set = tbCardSet.Text;
			newDoc.Url = tbGoogleDocUrl.Text;
			bool success = newDoc.InsertIntoDB();
			if (success)
				BindData();
			else
				lbInsertError.Visible = true;
			}
		}

		private void BindData()
		{
			lbInsertError.Visible = false;
			gvGoogleDocs.DataBind();
		}
	}
}