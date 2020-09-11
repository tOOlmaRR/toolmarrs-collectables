using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TscWinAdmin.GeosTradingCardsDataSetTableAdapters;

namespace TscWinAdmin
{
    public partial class CardSetAdmin : Form
    {
        public CardSetAdmin()
        {
            InitializeComponent();
        }

        private void CardSetAdmin_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'geosTradingCardsDataSet.manufacturer' table. You can move, or remove it, as needed.
            this.manufacturerTableAdapter.Fill(this.geosTradingCardsDataSet.manufacturer);
            
            // TODO: This line of code loads data into the 'geosTradingCardsDataSet.cardset' table. You can move, or remove it, as needed.
            this.cardsetTableAdapter.Fill(this.geosTradingCardsDataSet.cardset);

            //DataRelation relation = new DataRelation(
            //    "manufacturerName",
            //    this.geosTradingCardsDataSet.cardset.Columns["Manufacturer_ID"],
            //    this.geosTradingCardsDataSet.manufacturer.Columns["ID"]
            //);
            //this.geosTradingCardsDataSet.Relations.Add(relation);

            // Populates the dropdown but doesn't set the appropriate name
            //manufacturerTableAdapter manufacturerDataAdapter = new manufacturerTableAdapter();
            //manufacturerDataAdapter.Fill(this.geosTradingCardsDataSet.manufacturer);

            //DataGridViewComboBoxColumn manufacturer = new DataGridViewComboBoxColumn();
            //manufacturer.DataSource = this.geosTradingCardsDataSet.manufacturer;
            //manufacturer.DisplayMember = "Name";
            //manufacturer.ValueMember = "ID";
            //this.cardSetGrid.Columns.Add(manufacturer);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DialogResult choice = MessageBox.Show("Save all changes?", "SAVE", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2);
            if (choice == DialogResult.Yes)
            {
                this.cardsetTableAdapter.Update(this.geosTradingCardsDataSet.cardset);
            }
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            DialogResult choice = MessageBox.Show("Undo all changes?", "UNDO", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2);
            if (choice == DialogResult.Yes)
            {
                this.cardsetTableAdapter.Fill(this.geosTradingCardsDataSet.cardset);
            }
        }
    }
}
