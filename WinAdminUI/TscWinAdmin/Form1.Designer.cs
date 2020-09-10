namespace TscWinAdmin
{
    partial class Form1
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
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.cardsetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.geosTradingCardsDataSet = new TscWinAdmin.GeosTradingCardsDataSet();
            this.cardsetTableAdapter = new TscWinAdmin.GeosTradingCardsDataSetTableAdapters.cardsetTableAdapter();
            this.iDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.fullNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.seasonDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.manufacturerIDDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.baseSetNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.insertSetNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.sizeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.rarityDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.gradingModifierDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.commentsDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastBeckettUpdateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.lastInventoryCheckDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnUndo = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cardsetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.geosTradingCardsDataSet)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.iDDataGridViewTextBoxColumn,
            this.fullNameDataGridViewTextBoxColumn,
            this.seasonDataGridViewTextBoxColumn,
            this.manufacturerIDDataGridViewTextBoxColumn,
            this.baseSetNameDataGridViewTextBoxColumn,
            this.insertSetNameDataGridViewTextBoxColumn,
            this.sizeDataGridViewTextBoxColumn,
            this.rarityDataGridViewTextBoxColumn,
            this.gradingModifierDataGridViewTextBoxColumn,
            this.commentsDataGridViewTextBoxColumn,
            this.lastBeckettUpdateDataGridViewTextBoxColumn,
            this.lastInventoryCheckDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.cardsetBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(12, 61);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(1240, 680);
            this.dataGridView1.TabIndex = 0;
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
            // iDDataGridViewTextBoxColumn
            // 
            this.iDDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.iDDataGridViewTextBoxColumn.DataPropertyName = "ID";
            this.iDDataGridViewTextBoxColumn.HeaderText = "ID";
            this.iDDataGridViewTextBoxColumn.Name = "iDDataGridViewTextBoxColumn";
            this.iDDataGridViewTextBoxColumn.ReadOnly = true;
            this.iDDataGridViewTextBoxColumn.Width = 43;
            // 
            // fullNameDataGridViewTextBoxColumn
            // 
            this.fullNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.fullNameDataGridViewTextBoxColumn.DataPropertyName = "FullName";
            this.fullNameDataGridViewTextBoxColumn.HeaderText = "FullName";
            this.fullNameDataGridViewTextBoxColumn.Name = "fullNameDataGridViewTextBoxColumn";
            this.fullNameDataGridViewTextBoxColumn.Width = 76;
            // 
            // seasonDataGridViewTextBoxColumn
            // 
            this.seasonDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.seasonDataGridViewTextBoxColumn.DataPropertyName = "Season";
            this.seasonDataGridViewTextBoxColumn.HeaderText = "Season";
            this.seasonDataGridViewTextBoxColumn.Name = "seasonDataGridViewTextBoxColumn";
            this.seasonDataGridViewTextBoxColumn.Width = 68;
            // 
            // manufacturerIDDataGridViewTextBoxColumn
            // 
            this.manufacturerIDDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.manufacturerIDDataGridViewTextBoxColumn.DataPropertyName = "Manufacturer_ID";
            this.manufacturerIDDataGridViewTextBoxColumn.HeaderText = "Manufacturer_ID";
            this.manufacturerIDDataGridViewTextBoxColumn.Name = "manufacturerIDDataGridViewTextBoxColumn";
            this.manufacturerIDDataGridViewTextBoxColumn.Width = 112;
            // 
            // baseSetNameDataGridViewTextBoxColumn
            // 
            this.baseSetNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.baseSetNameDataGridViewTextBoxColumn.DataPropertyName = "BaseSetName";
            this.baseSetNameDataGridViewTextBoxColumn.HeaderText = "BaseSetName";
            this.baseSetNameDataGridViewTextBoxColumn.Name = "baseSetNameDataGridViewTextBoxColumn";
            // 
            // insertSetNameDataGridViewTextBoxColumn
            // 
            this.insertSetNameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.insertSetNameDataGridViewTextBoxColumn.DataPropertyName = "InsertSetName";
            this.insertSetNameDataGridViewTextBoxColumn.HeaderText = "InsertSetName";
            this.insertSetNameDataGridViewTextBoxColumn.Name = "insertSetNameDataGridViewTextBoxColumn";
            this.insertSetNameDataGridViewTextBoxColumn.Width = 102;
            // 
            // sizeDataGridViewTextBoxColumn
            // 
            this.sizeDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.sizeDataGridViewTextBoxColumn.DataPropertyName = "Size";
            this.sizeDataGridViewTextBoxColumn.HeaderText = "Size";
            this.sizeDataGridViewTextBoxColumn.Name = "sizeDataGridViewTextBoxColumn";
            this.sizeDataGridViewTextBoxColumn.Width = 52;
            // 
            // rarityDataGridViewTextBoxColumn
            // 
            this.rarityDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.rarityDataGridViewTextBoxColumn.DataPropertyName = "Rarity";
            this.rarityDataGridViewTextBoxColumn.HeaderText = "Rarity";
            this.rarityDataGridViewTextBoxColumn.Name = "rarityDataGridViewTextBoxColumn";
            this.rarityDataGridViewTextBoxColumn.Width = 59;
            // 
            // gradingModifierDataGridViewTextBoxColumn
            // 
            this.gradingModifierDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.gradingModifierDataGridViewTextBoxColumn.DataPropertyName = "GradingModifier";
            this.gradingModifierDataGridViewTextBoxColumn.HeaderText = "GradingModifier";
            this.gradingModifierDataGridViewTextBoxColumn.Name = "gradingModifierDataGridViewTextBoxColumn";
            this.gradingModifierDataGridViewTextBoxColumn.Width = 106;
            // 
            // commentsDataGridViewTextBoxColumn
            // 
            this.commentsDataGridViewTextBoxColumn.DataPropertyName = "Comments";
            this.commentsDataGridViewTextBoxColumn.HeaderText = "Comments";
            this.commentsDataGridViewTextBoxColumn.Name = "commentsDataGridViewTextBoxColumn";
            this.commentsDataGridViewTextBoxColumn.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable;
            this.commentsDataGridViewTextBoxColumn.Width = 200;
            // 
            // lastBeckettUpdateDataGridViewTextBoxColumn
            // 
            this.lastBeckettUpdateDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.lastBeckettUpdateDataGridViewTextBoxColumn.DataPropertyName = "LastBeckettUpdate";
            this.lastBeckettUpdateDataGridViewTextBoxColumn.HeaderText = "LastBeckettUpdate";
            this.lastBeckettUpdateDataGridViewTextBoxColumn.Name = "lastBeckettUpdateDataGridViewTextBoxColumn";
            this.lastBeckettUpdateDataGridViewTextBoxColumn.Width = 124;
            // 
            // lastInventoryCheckDataGridViewTextBoxColumn
            // 
            this.lastInventoryCheckDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.lastInventoryCheckDataGridViewTextBoxColumn.DataPropertyName = "LastInventoryCheck";
            this.lastInventoryCheckDataGridViewTextBoxColumn.HeaderText = "LastInventoryCheck";
            this.lastInventoryCheckDataGridViewTextBoxColumn.Name = "lastInventoryCheckDataGridViewTextBoxColumn";
            this.lastInventoryCheckDataGridViewTextBoxColumn.Width = 127;
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
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1264, 985);
            this.Controls.Add(this.btnUndo);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.dataGridView1);
            this.Name = "Form1";
            this.Text = "CardSets Admin - tOOlmaRR\'s Collectables WinAdmin Tool";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cardsetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.geosTradingCardsDataSet)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private GeosTradingCardsDataSet geosTradingCardsDataSet;
        private System.Windows.Forms.BindingSource cardsetBindingSource;
        private GeosTradingCardsDataSetTableAdapters.cardsetTableAdapter cardsetTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn iDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn fullNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn seasonDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn manufacturerIDDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn baseSetNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn insertSetNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn sizeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn rarityDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn gradingModifierDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn commentsDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastBeckettUpdateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn lastInventoryCheckDataGridViewTextBoxColumn;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnUndo;
    }
}

