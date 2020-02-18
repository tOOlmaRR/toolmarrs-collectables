using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace GeoTradingCards
{
    public partial class Main : System.Web.UI.MasterPage
    {
		private string _currentEnvironment = string.Empty;

		protected void Page_Load(object sender, EventArgs e)
        {
			try
			{
				_currentEnvironment = ConfigurationManager.AppSettings["Environment"];
				switch (_currentEnvironment)
				{
					case "Localhost":
						this.GoogleAnalyticsControl.Visible = false;
						break;
					case "Development":
						this.GoogleAnalyticsControl.Visible = false;
						break;
					case "AspSpider.ws":
						this.GoogleAnalyticsControl.Visible = true;
						this.GoogleAnalyticsControl.TrackingCode = "UA-7246545-3";
						break;
					case "Staging":
						this.GoogleAnalyticsControl.Visible = true;
						this.GoogleAnalyticsControl.TrackingCode = "UA-7246545-4";
						break;
					case "Production":
						this.GoogleAnalyticsControl.Visible = true;
						this.GoogleAnalyticsControl.TrackingCode = "UA-7246545-5";
						break;
				}
			}
			catch (Exception ex)
			{
				DAL.ExceptionManager.LogException(ex);
			}
        }
    }
}