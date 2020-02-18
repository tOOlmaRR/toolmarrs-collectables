﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.21006.1
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GeoTradingCards.DAL
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="CardCollection")]
	public partial class GoogleDocsDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertGoogleDocsPage(GoogleDocsPage instance);
    partial void UpdateGoogleDocsPage(GoogleDocsPage instance);
    partial void DeleteGoogleDocsPage(GoogleDocsPage instance);
    #endregion
		
		public GoogleDocsDataContext() : 
				base(global::System.Configuration.ConfigurationManager.ConnectionStrings["CardCollectionConnectionString"].ConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleDocsDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleDocsDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleDocsDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleDocsDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<GoogleDocsPage> GoogleDocsPages
		{
			get
			{
				return this.GetTable<GoogleDocsPage>();
			}
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.[GoogleDocs.SelectAll]")]
		public ISingleResult<GoogleDocs_SelectAllResult> GoogleDocs_SelectAll()
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())));
			return ((ISingleResult<GoogleDocs_SelectAllResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.[GoogleDocs.SelectRowByID]")]
		public ISingleResult<GoogleDocsPage> GoogleDocs_SelectRowByID([global::System.Data.Linq.Mapping.ParameterAttribute(Name="ID", DbType="Int")] System.Nullable<int> iD)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), iD);
			return ((ISingleResult<GoogleDocsPage>)(result.ReturnValue));
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.GoogleDocsPages")]
	public partial class GoogleDocsPage : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _ID;
		
		private string _Season;
		
		private string _Set;
		
		private string _GoogleDocsUrl;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnIDChanging(int value);
    partial void OnIDChanged();
    partial void OnSeasonChanging(string value);
    partial void OnSeasonChanged();
    partial void OnSetChanging(string value);
    partial void OnSetChanged();
    partial void OnGoogleDocsUrlChanging(string value);
    partial void OnGoogleDocsUrlChanged();
    #endregion
		
		public GoogleDocsPage()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ID", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int ID
		{
			get
			{
				return this._ID;
			}
			set
			{
				if ((this._ID != value))
				{
					this.OnIDChanging(value);
					this.SendPropertyChanging();
					this._ID = value;
					this.SendPropertyChanged("ID");
					this.OnIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Season", DbType="Char(7) NOT NULL", CanBeNull=false)]
		public string Season
		{
			get
			{
				return this._Season;
			}
			set
			{
				if ((this._Season != value))
				{
					this.OnSeasonChanging(value);
					this.SendPropertyChanging();
					this._Season = value;
					this.SendPropertyChanged("Season");
					this.OnSeasonChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Name="[Set]", Storage="_Set", DbType="NVarChar(128) NOT NULL", CanBeNull=false)]
		public string Set
		{
			get
			{
				return this._Set;
			}
			set
			{
				if ((this._Set != value))
				{
					this.OnSetChanging(value);
					this.SendPropertyChanging();
					this._Set = value;
					this.SendPropertyChanged("Set");
					this.OnSetChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_GoogleDocsUrl", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string GoogleDocsUrl
		{
			get
			{
				return this._GoogleDocsUrl;
			}
			set
			{
				if ((this._GoogleDocsUrl != value))
				{
					this.OnGoogleDocsUrlChanging(value);
					this.SendPropertyChanging();
					this._GoogleDocsUrl = value;
					this.SendPropertyChanged("GoogleDocsUrl");
					this.OnGoogleDocsUrlChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
	
	public partial class GoogleDocs_SelectAllResult
	{
		
		private int _ID;
		
		private string _Season;
		
		private string _Set;
		
		private string _GoogleDocsUrl;
		
		public GoogleDocs_SelectAllResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ID", DbType="Int NOT NULL")]
		public int ID
		{
			get
			{
				return this._ID;
			}
			set
			{
				if ((this._ID != value))
				{
					this._ID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Season", DbType="Char(7) NOT NULL", CanBeNull=false)]
		public string Season
		{
			get
			{
				return this._Season;
			}
			set
			{
				if ((this._Season != value))
				{
					this._Season = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Name="[Set]", Storage="_Set", DbType="NVarChar(128) NOT NULL", CanBeNull=false)]
		public string Set
		{
			get
			{
				return this._Set;
			}
			set
			{
				if ((this._Set != value))
				{
					this._Set = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_GoogleDocsUrl", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string GoogleDocsUrl
		{
			get
			{
				return this._GoogleDocsUrl;
			}
			set
			{
				if ((this._GoogleDocsUrl != value))
				{
					this._GoogleDocsUrl = value;
				}
			}
		}
	}
}
#pragma warning restore 1591
