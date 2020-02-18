using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GeoTradingCards.classes
{
	public class GoogleDocsList
	{
		private static List<GoogleDoc> googleDocsList;

		/// <summary>
		/// Populates this list of Google Docs from the database
		/// </summary>
		public static void Initialize()
		{
			List<DAL.GoogleDocsPage> googleDocEntities = DAL.GoogleDocsManager.GetAllGoogleDocs();
			foreach (DAL.GoogleDocsPage entity in googleDocEntities)
			{
				GoogleDoc thisDoc = new GoogleDoc();
				thisDoc.Season = entity.Season;
				thisDoc.Set = entity.Set;
				thisDoc.Url = entity.GoogleDocsUrl;
				googleDocsList.Add(thisDoc);
			}
		}

		/// <summary>
		/// Retrieves a copy this list of Google Docs
		/// </summary>
		/// <returns></returns>
		public List<GoogleDoc> Select()
		{
			return googleDocsList;
		}

		public void Update(GoogleDoc updatedDoc)
		{
			GoogleDoc docFound = googleDocsList.Find(
				delegate(GoogleDoc doc) { return doc.ID == updatedDoc.ID; });
		}
	}
}
