using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoTradingCards.Controls.Stats
{
	public partial class GoogleAnalytics : System.Web.UI.UserControl
	{
		private string trackingCode;
		public string TrackingCode
		{
			get { return trackingCode; }
			set { trackingCode = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			
		}
	}
}