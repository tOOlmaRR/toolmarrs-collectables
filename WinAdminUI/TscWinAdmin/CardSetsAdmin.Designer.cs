namespace TscWinAdmin
{
    partial class CardSetAdmin
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.cardSetGrid = new System.Windows.Forms.DataGridView();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnUndo = new System.Windows.Forms.Button();
            this.pageTitle = new System.Windows.Forms.Label();
            this.cardsetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.geosTradingCardsDataSet = new TscWinAdmin.GeosTradingCardsDataSet();
            this.cardsetTableAdapter = new TscWinAdmin.GeosTradingCardsDataSetTableAdapters.cardsetTableAdapter();
            this.geosTradingCardsDataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.manufacturerBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.manufacturerTableAdapter = new TscWinAdmin.GeosTradingCardsDataSetTableAdapters.manufacturerTableAdapter();
            this.iDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.manufacturerIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastInventoryCheckDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastBeckettUpdateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.commentsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.gradingModifierDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rarityDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.sizeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.seasonDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fullNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.insertSetNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.baseSetNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.cardSetGrid)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cardsetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.geosTradingCardsDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.geosTradingCardsDataSetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.manufacturerBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // cardSetGrid
            // 
            this.cardSetGrid.AllowUserToDeleteRows = false;
            this.cardSetGrid.AllowUserToResizeRows = false;
            this.cardSetGrid.AutoGenerateColumns = false;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.cardSetGrid.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.cardSetGrid.ColumnHeadersHeight = 40;
            this.cardSetGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            this.cardSetGrid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.iDDataGridViewTextBoxColumn,
            this.baseSetNameDataGridViewTextBoxColumn,
            this.insertSetNameDataGridViewTextBoxColumn,
            this.fullNameDataGridViewTextBoxColumn,
            this.seasonDataGridViewTextBoxColumn,
            this.sizeDataGridViewTextBoxColumn,
            this.rarityDataGridViewTextBoxColumn,
            this.gradingModifierDataGridViewTextBoxColumn,
            this.commentsDataGridViewTextBoxColumn,
            this.lastBeckettUpdateDataGridViewTextBoxColumn,
            this.lastInventoryCheckDataGridViewTextBoxColumn,
            this.manufacturerIDDataGridViewTextBoxColumn});
            this.cardSetGrid.DataSource = this.cardsetBindingSource;
            this.cardSetGrid.Location = new System.Drawing.Point(12, 61);
            this.cardSetGrid.Name = "cardSetGrid";
            this.cardSetGrid.Size = new System.Drawing.Size(1240, 680);
            this.cardSetGrid.TabIndex = 0;
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(1177, 27);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 1;
            this.btnSave.Text = "SAVE";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnUndo
            // 
            this.btnUndo.Location = new System.Drawing.Point(1096, 27);
            this.btnUndo.Name = "btnUndo";
            this.btnUndo.Size = new System.Drawing.Size(75, 23);
            this.btnUndo.TabIndex = 2;
            this.btnUndo.Text = "UNDO ALL";
            this.btnUndo.UseVisualStyleBackColor = true;
            this.btnUndo.Click += new System.EventHandler(this.btnUndo_Click);
            // 
            // pageTitle
            // 
            this.pageTitle.AutoSize = true;
            this.pageTitle.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pageTitle.Location = new System.Drawing.Point(22, 20);
            this.pageTitle.Name = "pageTitle";
            this.pageTitle.Size = new System.Drawing.Size(193, 29);
            this.pageTitle.TabIndex = 3;
            this.pageTitle.Text = "Card Sets Admin";
            // 
            // cardsetBindingSource
            // 
            this.cardsetBindingSource.DataMember = "cardset";
            this.cardsetBindingSource.DataSource = this.geosTradingCardsDataSet;
            // 
            // geosTradingCardsDataSet
            // 
            this.geosTradingCardsDataSet.DataSetName = "GeosTradingCardsDataSet";
            this.geosTradingCardsDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // cardsetTableAdapter
            // 
            this.cardsetTableAdapter.ClearBeforeFill = true;
            // 
            // geosTradingCardsDataSetBindingSource
            // 
            this.geosTradingCardsDataSetBindingSource.DataSource = this.geosTradingCardsDataSet;
            this.geosTradingCardsDataSetBindingSource.Position = 0;
            // 
            // manufacturerBindingSource
            // 
            this.manufacturerBindingSource.DataMember = "manufacturer";
            this.manufacturerBindingSource.DataSource = this.geosTradingCardsDataSetBindingSource;
            // 
            // manufacturerTableAdapter
            // 
            this.manufacturerTableAdapter.ClearBeforeFill = true;
            // 
            // iDDataGridViewTextBoxColumn
            // 
            this.iDDataGridViewTextBoxColumn.DataPropertyName = "ID";
            this.iDDataGridViewTextBoxColumn.HeaderText = "ID";
            this.iDDataGridViewTextBoxColumn.Name = "iDDataGridViewTextBoxColumn";
            this.iDDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // manufacturerIDDataGridViewTextBoxColumn
            // 
            this.manufacturerIDDataGridViewTextBoxColumn.DataPropertyName = "Manufacturer_ID";
            this.manufacturerIDDataGridViewTextBoxColumn.HeaderText = "Manufacturer_ID";
            this.manufacturerIDDataGridViewTextBoxColumn.Name = "manufacturerIDDataGridViewTextBoxColumn";
            // 
            // lastInventoryCheckDataGridViewTextBoxColumn
            // 
            this.lastInventoryCheckDataGridViewTextBoxColumn.DataPropertyName = "LastInventoryCheck";
            this.lastInventoryCheckDataGridViewTextBoxColumn.HeaderText = "LastInventoryCheck";
            this.lastInventoryCheckDataGridViewTextBoxColumn.Name = "lastInventoryCheckDataGridViewTextBoxColumn";
            // 
            // lastBeckettUpdateDataGridViewTextBoxColumn
            // 
            this.lastBeckettUpdateDataGridViewTextBoxColumn.DataPropertyName = "LastBeckettUpdate";
            this.lastBeckettUpdateDataGridViewTextBoxColumn.HeaderText = "LastBeckettUpdate";
            this.lastBeckettUpdateDataGridViewTextBoxColumn.Name = "lastBeckettUpdateDataGridViewTextBoxColumn";
            // 
            // commentsDataGridViewTextBoxColumn
            // 
            this.commentsDataGridViewTextBoxColumn.DataPropertyName = "Comments";
            this.commentsDataGridViewTextBoxColumn.HeaderText = "Comments";
            this.commentsDataGridViewTextBoxColumn.Name = "commentsDataGridViewTextBoxColumn";
            // 
            // gradingModifierDataGridViewTextBoxColumn
            // 
            this.gradingModifierDataGridViewTextBoxColumn.DataPropertyName = "GradingModifier";
            this.gradingModifierDataGridViewTextBoxColumn.HeaderText = "GradingModifier";
            this.gradingModifierDataGridViewTextBoxColumn.Name = "gradingModifierDataGridViewTextBoxColumn";
            // 
            // rarityDataGridViewTextBoxColumn
            // 
            this.rarityDataGridViewTextBoxColumn.DataPropertyName = "Rarity";
            this.rarityDataGridViewTextBoxColumn.HeaderText = "Rarity";
            this.rarityDataGridViewTextBoxColumn.Name = "rarityDataGridViewTextBoxColumn";
            // 
            // sizeDataGridViewTextBoxColumn
            // 
            this.sizeDataGridViewTextBoxColumn.DataPropertyName = "Size";
            this.sizeDataGridViewTextBoxColumn.HeaderText = "Size";
            this.sizeDataGridViewTextBoxColumn.Name = "sizeDataGridViewTextBoxColumn";
            // 
            // seasonDataGridViewTextBoxColumn
            // 
            this.seasonDataGridViewTextBoxColumn.DataPropertyName = "Season";
            this.seasonDataGridViewTextBoxColumn.HeaderText = "Season";
            this.seasonDataGridViewTextBoxColumn.Name = "seasonDataGridViewTextBoxColumn";
            // 
            // fullNameDataGridViewTextBoxColumn
            // 
            this.fullNameDataGridViewTextBoxColumn.DataPropertyName = "FullName";
            this.fullNameDataGridViewTextBoxColumn.HeaderText = "FullName";
            this.fullNameDataGridViewTextBoxColumn.Name = "fullNameDataGridViewTextBoxColumn";
            // 
            // insertSetNameDataGridViewTextBoxColumn
            // 
            this.insertSetNameDataGridViewTextBoxColumn.DataPropertyName = "InsertSetName";
            this.insertSetNameDataGridViewTextBoxColumn.HeaderText = "InsertSetName";
            this.insertSetNameDataGridViewTextBoxColumn.Name = "insertSetNameDataGridViewTextBoxColumn";
            // 
            // baseSetNameDataGridViewTextBoxColumn
            // 
            this.baseSetNameDataGridViewTextBoxColumn.DataPropertyName = "BaseSetName";
            this.baseSetNameDataGridViewTextBoxColumn.HeaderText = "BaseSetName";
            this.baseSetNameDataGridViewTextBoxColumn.Name = "baseSetNameDataGridViewTextBoxColumn";
            // 
            // CardSetAdmin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1264, 985);
            this.Controls.Add(this.pageTitle);
            this.Controls.Add(this.btnUndo);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.cardSetGrid);
            this.Name = "CardSetAdmin";
            this.Text = "CardSets Admin - tOOlmaRR\'s Collectables WinAdmin Tool";
            this.Load += new System.EventHandler(this.CardSetAdmin_Load);
            ((System.ComponentModel.ISupportInitialize)(this.cardSetGrid)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cardsetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.geosTradingCardsDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.geosTradingCardsDataSetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.manufacturerBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView cardSetGrid;
        private GeosTradingCardsDataSet geosTradingCardsDataSet;
        private System.Windows.Forms.BindingSource cardsetBindingSource;
        private GeosTradingCardsDataSetTableAdapters.cardsetTableAdapter cardsetTableAdapter;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnUndo;
        private System.Windows.Forms.Label pageTitle;
        private System.Windows.Forms.BindingSource geosTradingCardsDataSetBindingSource;
        private System.Windows.Forms.BindingSource manufacturerBindingSource;
        private GeosTradingCardsDataSetTableAdapters.manufacturerTableAdapter manufacturerTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn iDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn baseSetNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn insertSetNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn fullNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn seasonDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn sizeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn rarityDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn gradingModifierDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn commentsDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastBeckettUpdateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastInventoryCheckDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn manufacturerIDDataGridViewTextBoxColumn;
    }
}

