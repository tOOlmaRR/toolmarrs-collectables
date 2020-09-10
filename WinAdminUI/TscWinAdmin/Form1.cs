using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TscWinAdmin
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'geosTradingCardsDataSet.cardset' table. You can move, or remove it, as needed.
            this.cardsetTableAdapter.Fill(this.geosTradingCardsDataSet.cardset);

        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Save all changes?", "SAVE", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2, MessageBoxOptions.ServiceNotification);
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Undo all changes?", "UNDO", MessageBoxButtons.YesNo, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button2, MessageBoxOptions.ServiceNotification);
        }
    }
}
