using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace GeoTradingCards.DAL
{
	public static class Databases
	{
		private static GoogleDocsDataContext googleDocs;
		private static ExceptionsDataContext exceptions;

		public static GoogleDocsDataContext GoogleDocs
		{
			get { return googleDocs; }
		}

		public static ExceptionsDataContext Exceptions
		{
			get { return exceptions; }
			set { exceptions = value; }
		}
		
		static Databases()
		{
			googleDocs = new GoogleDocsDataContext(ConfigurationManager.ConnectionStrings["CardCollectionDB"].ToString());
			exceptions = new ExceptionsDataContext(ConfigurationManager.ConnectionStrings["CardCollectionDB"].ToString());
		}
	}
}