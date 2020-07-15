using uniERP.AppFramework.UI.Module;
using Microsoft.Practices.CompositeUI;
using Microsoft.Practices.ObjectBuilder;

namespace uniERP.App.UI.HR.H4006M4_KO883
{

    public class ModuleInitializer : uniERP.AppFramework.UI.Module.Module
    {
        [InjectionConstructor]
        public ModuleInitializer([ServiceDependency] WorkItem rootWorkItem)
            : base(rootWorkItem) { }

        protected override void RegisterModureViewer()
        {
            base.AddModule<ModuleViewer>();
        }
    }

    partial class ModuleViewer
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            this.uniGrid1 = new uniERP.AppFramework.UI.Controls.uniGrid(this.components);
            this.uniTBL_OuterMost = new uniERP.AppFramework.UI.Controls.uniTableLayoutPanel(this.components);
            this.uniTBL_MainData = new uniERP.AppFramework.UI.Controls.uniTableLayoutPanel(this.components);
            this.uniTBL_MainCondition = new uniERP.AppFramework.UI.Controls.uniTableLayoutPanel(this.components);
            this.lblYYYYMM = new uniERP.AppFramework.UI.Controls.uniLabel(this.components);
            this.popDeptCd = new uniERP.AppFramework.UI.Controls.uniOpenPopup();
            this.lblDeptCd = new uniERP.AppFramework.UI.Controls.uniLabel(this.components);
            this.lblEmpNo = new uniERP.AppFramework.UI.Controls.uniLabel(this.components);
            this.dtYYYYMM = new uniERP.AppFramework.UI.Controls.uniDateTime(this.components);
            this.uniLabel1 = new uniERP.AppFramework.UI.Controls.uniLabel(this.components);
            this.popEmpNo = new uniERP.AppFramework.UI.Controls.uniOpenPopup();
            this.uniTBL_MainReference = new uniERP.AppFramework.UI.Controls.uniTableLayoutPanel(this.components);
            this.uniTBL_MainBatch = new uniERP.AppFramework.UI.Controls.uniTableLayoutPanel(this.components);
            this.btnConfirm = new uniERP.AppFramework.UI.Controls.uniButton(this.components);
            this.dtDocumentDt = new uniERP.AppFramework.UI.Controls.uniDateTime(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.uniGrid1)).BeginInit();
            this.uniTBL_OuterMost.SuspendLayout();
            this.uniTBL_MainData.SuspendLayout();
            this.uniTBL_MainCondition.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtYYYYMM)).BeginInit();
            this.uniTBL_MainBatch.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtDocumentDt)).BeginInit();
            this.SuspendLayout();
            // 
            // uniLabel_Path
            // 
            this.uniLabel_Path.LabelType = uniERP.AppFramework.UI.Variables.enumDef.LabelType.PathInfo;
            this.uniLabel_Path.Size = new System.Drawing.Size(500, 14);
            // 
            // uniGrid1
            // 
            this.uniGrid1.AddEmptyRow = false;
            this.uniGrid1.DirectPaste = false;
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.uniGrid1.DisplayLayout.Appearance = appearance1;
            this.uniGrid1.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.uniGrid1.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.uniGrid1.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.uniGrid1.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.uniGrid1.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.uniGrid1.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.uniGrid1.DisplayLayout.MaxColScrollRegions = 1;
            this.uniGrid1.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.uniGrid1.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            this.uniGrid1.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.uniGrid1.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.uniGrid1.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance6.BackColor = System.Drawing.SystemColors.Window;
            this.uniGrid1.DisplayLayout.Override.CardAreaAppearance = appearance6;
            appearance7.BorderColor = System.Drawing.Color.Silver;
            appearance7.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.uniGrid1.DisplayLayout.Override.CellAppearance = appearance7;
            this.uniGrid1.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.CellSelect;
            this.uniGrid1.DisplayLayout.Override.CellPadding = 0;
            appearance8.BackColor = System.Drawing.SystemColors.Control;
            appearance8.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance8.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance8.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance8.BorderColor = System.Drawing.SystemColors.Window;
            this.uniGrid1.DisplayLayout.Override.GroupByRowAppearance = appearance8;
            appearance9.TextHAlignAsString = "Left";
            this.uniGrid1.DisplayLayout.Override.HeaderAppearance = appearance9;
            this.uniGrid1.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.uniGrid1.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance10.BackColor = System.Drawing.SystemColors.Window;
            appearance10.BorderColor = System.Drawing.Color.Silver;
            this.uniGrid1.DisplayLayout.Override.RowAppearance = appearance10;
            this.uniGrid1.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance11.BackColor = System.Drawing.SystemColors.ControlLight;
            this.uniGrid1.DisplayLayout.Override.TemplateAddRowAppearance = appearance11;
            this.uniGrid1.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.uniGrid1.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.uniGrid1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniGrid1.EnableContextMenu = true;
            this.uniGrid1.EnableGridInfoContextMenu = true;
            this.uniGrid1.ExceptInExcel = false;
            this.uniGrid1.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.uniGrid1.gComNumDec = uniERP.AppFramework.UI.Variables.enumDef.ComDec.Decimal;
            this.uniGrid1.GridStyle = uniERP.AppFramework.UI.Variables.enumDef.GridStyle.Master;
            this.uniGrid1.Location = new System.Drawing.Point(0, 0);
            this.uniGrid1.Margin = new System.Windows.Forms.Padding(0);
            this.uniGrid1.Name = "uniGrid1";
            this.uniGrid1.OutlookGroupBy = uniERP.AppFramework.UI.Variables.enumDef.IsOutlookGroupBy.No;
            this.uniGrid1.PopupDeleteMenuVisible = true;
            this.uniGrid1.PopupInsertMenuVisible = true;
            this.uniGrid1.PopupUndoMenuVisible = true;
            this.uniGrid1.Search = uniERP.AppFramework.UI.Variables.enumDef.IsSearch.Yes;
            this.uniGrid1.ShowHeaderCheck = true;
            this.uniGrid1.Size = new System.Drawing.Size(937, 468);
            this.uniGrid1.StyleSetName = "uniGrid_Query";
            this.uniGrid1.TabIndex = 0;
            this.uniGrid1.Text = "uniGrid1";
            this.uniGrid1.UseDynamicFormat = false;
            this.uniGrid1.AfterExitEditMode += new System.EventHandler(this.uniGrid1_AfterExitEditMode);
            this.uniGrid1.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.uniGrid1_AfterCellUpdate);
            this.uniGrid1.BeforePopupOpen += new uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventHandler(this.uniGrid1_BeforePopupOpen);
            this.uniGrid1.AfterPopupClosed += new uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventHandler(this.uniGrid1_AfterPopupClosed);
            // 
            // uniTBL_OuterMost
            // 
            this.uniTBL_OuterMost.AutoFit = false;
            this.uniTBL_OuterMost.AutoFitColumnCount = 4;
            this.uniTBL_OuterMost.AutoFitRowCount = 4;
            this.uniTBL_OuterMost.BackColor = System.Drawing.Color.Transparent;
            this.uniTBL_OuterMost.ColumnCount = 1;
            this.uniTBL_OuterMost.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_OuterMost.Controls.Add(this.uniTBL_MainData, 0, 4);
            this.uniTBL_OuterMost.Controls.Add(this.uniTBL_MainCondition, 0, 2);
            this.uniTBL_OuterMost.Controls.Add(this.uniTBL_MainReference, 0, 0);
            this.uniTBL_OuterMost.Controls.Add(this.uniTBL_MainBatch, 0, 6);
            this.uniTBL_OuterMost.DefaultRowSize = 23;
            this.uniTBL_OuterMost.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniTBL_OuterMost.EasyBaseBatchType = uniERP.AppFramework.UI.Controls.EasyBaseTBType.NONE;
            this.uniTBL_OuterMost.HEIGHT_TYPE_00_REFERENCE = 21F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_01 = 6F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_01_CONDITION = 38F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_02 = 9F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_02_DATA = 0F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_03 = 3F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_03_BOTTOM = 28F;
            this.uniTBL_OuterMost.HEIGHT_TYPE_04 = 1F;
            this.uniTBL_OuterMost.Location = new System.Drawing.Point(1, 10);
            this.uniTBL_OuterMost.Margin = new System.Windows.Forms.Padding(0);
            this.uniTBL_OuterMost.Name = "uniTBL_OuterMost";
            this.uniTBL_OuterMost.PanelType = uniERP.AppFramework.UI.Variables.enumDef.PanelType.Default;
            this.uniTBL_OuterMost.RowCount = 8;
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 21F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 6F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 61F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 9F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 3F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 28F));
            this.uniTBL_OuterMost.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 1F));
            this.uniTBL_OuterMost.Size = new System.Drawing.Size(937, 597);
            this.uniTBL_OuterMost.SizeTD5 = 14F;
            this.uniTBL_OuterMost.SizeTD6 = 36F;
            this.uniTBL_OuterMost.TabIndex = 0;
            this.uniTBL_OuterMost.uniERPTableLayout = uniERP.AppFramework.UI.Controls.uniERPTableLayOutStyle.DefaultTableLayout;
            this.uniTBL_OuterMost.uniLR_SPACE_TYPE = uniERP.AppFramework.UI.Controls.LR_SPACE_TYPE.LR_SPACE_TYPE_00;
            // 
            // uniTBL_MainData
            // 
            this.uniTBL_MainData.AutoFit = false;
            this.uniTBL_MainData.AutoFitColumnCount = 4;
            this.uniTBL_MainData.AutoFitRowCount = 4;
            this.uniTBL_MainData.BackColor = System.Drawing.Color.Transparent;
            this.uniTBL_MainData.ColumnCount = 1;
            this.uniTBL_MainData.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainData.Controls.Add(this.uniGrid1, 0, 0);
            this.uniTBL_MainData.DefaultRowSize = 23;
            this.uniTBL_MainData.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniTBL_MainData.EasyBaseBatchType = uniERP.AppFramework.UI.Controls.EasyBaseTBType.NONE;
            this.uniTBL_MainData.HEIGHT_TYPE_00_REFERENCE = 32F;
            this.uniTBL_MainData.HEIGHT_TYPE_01 = 3F;
            this.uniTBL_MainData.HEIGHT_TYPE_01_CONDITION = 29F;
            this.uniTBL_MainData.HEIGHT_TYPE_02 = 5F;
            this.uniTBL_MainData.HEIGHT_TYPE_02_DATA = 0F;
            this.uniTBL_MainData.HEIGHT_TYPE_03 = 3F;
            this.uniTBL_MainData.HEIGHT_TYPE_03_BOTTOM = 32F;
            this.uniTBL_MainData.HEIGHT_TYPE_04 = 3F;
            this.uniTBL_MainData.Location = new System.Drawing.Point(0, 97);
            this.uniTBL_MainData.Margin = new System.Windows.Forms.Padding(0);
            this.uniTBL_MainData.Name = "uniTBL_MainData";
            this.uniTBL_MainData.PanelType = uniERP.AppFramework.UI.Variables.enumDef.PanelType.Data;
            this.uniTBL_MainData.RowCount = 1;
            this.uniTBL_MainData.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainData.Size = new System.Drawing.Size(937, 468);
            this.uniTBL_MainData.SizeTD5 = 14F;
            this.uniTBL_MainData.SizeTD6 = 36F;
            this.uniTBL_MainData.TabIndex = 0;
            this.uniTBL_MainData.uniERPTableLayout = uniERP.AppFramework.UI.Controls.uniERPTableLayOutStyle.DefaultTableLayout;
            this.uniTBL_MainData.uniLR_SPACE_TYPE = uniERP.AppFramework.UI.Controls.LR_SPACE_TYPE.LR_SPACE_TYPE_00;
            // 
            // uniTBL_MainCondition
            // 
            this.uniTBL_MainCondition.AutoFit = false;
            this.uniTBL_MainCondition.AutoFitColumnCount = 4;
            this.uniTBL_MainCondition.AutoFitRowCount = 4;
            this.uniTBL_MainCondition.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(244)))), ((int)(((byte)(245)))), ((int)(((byte)(247)))));
            this.uniTBL_MainCondition.ColumnCount = 4;
            this.uniTBL_MainCondition.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.uniTBL_MainCondition.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 36F));
            this.uniTBL_MainCondition.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 14F));
            this.uniTBL_MainCondition.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 36F));
            this.uniTBL_MainCondition.Controls.Add(this.lblYYYYMM, 0, 0);
            this.uniTBL_MainCondition.Controls.Add(this.popDeptCd, 3, 0);
            this.uniTBL_MainCondition.Controls.Add(this.lblDeptCd, 2, 0);
            this.uniTBL_MainCondition.Controls.Add(this.lblEmpNo, 0, 1);
            this.uniTBL_MainCondition.Controls.Add(this.dtYYYYMM, 1, 0);
            this.uniTBL_MainCondition.Controls.Add(this.uniLabel1, 2, 1);
            this.uniTBL_MainCondition.Controls.Add(this.popEmpNo, 1, 1);
            this.uniTBL_MainCondition.Controls.Add(this.dtDocumentDt, 3, 1);
            this.uniTBL_MainCondition.DefaultRowSize = 23;
            this.uniTBL_MainCondition.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniTBL_MainCondition.EasyBaseBatchType = uniERP.AppFramework.UI.Controls.EasyBaseTBType.NONE;
            this.uniTBL_MainCondition.HEIGHT_TYPE_00_REFERENCE = 32F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_01 = 3F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_01_CONDITION = 29F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_02 = 5F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_02_DATA = 0F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_03 = 3F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_03_BOTTOM = 32F;
            this.uniTBL_MainCondition.HEIGHT_TYPE_04 = 3F;
            this.uniTBL_MainCondition.Location = new System.Drawing.Point(0, 27);
            this.uniTBL_MainCondition.Margin = new System.Windows.Forms.Padding(0);
            this.uniTBL_MainCondition.Name = "uniTBL_MainCondition";
            this.uniTBL_MainCondition.Padding = new System.Windows.Forms.Padding(0, 5, 0, 10);
            this.uniTBL_MainCondition.PanelType = uniERP.AppFramework.UI.Variables.enumDef.PanelType.Condition;
            this.uniTBL_MainCondition.RowCount = 2;
            this.uniTBL_MainCondition.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 23F));
            this.uniTBL_MainCondition.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainCondition.Size = new System.Drawing.Size(937, 61);
            this.uniTBL_MainCondition.SizeTD5 = 14F;
            this.uniTBL_MainCondition.SizeTD6 = 36F;
            this.uniTBL_MainCondition.TabIndex = 1;
            this.uniTBL_MainCondition.uniERPTableLayout = uniERP.AppFramework.UI.Controls.uniERPTableLayOutStyle.DefaultTableLayout;
            this.uniTBL_MainCondition.uniLR_SPACE_TYPE = uniERP.AppFramework.UI.Controls.LR_SPACE_TYPE.LR_SPACE_TYPE_00;
            // 
            // lblYYYYMM
            // 
            appearance12.TextHAlignAsString = "Left";
            appearance12.TextVAlignAsString = "Middle";
            this.lblYYYYMM.Appearance = appearance12;
            this.lblYYYYMM.AutoPopupID = null;
            this.lblYYYYMM.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblYYYYMM.LabelType = uniERP.AppFramework.UI.Variables.enumDef.LabelType.Title;
            this.lblYYYYMM.Location = new System.Drawing.Point(15, 6);
            this.lblYYYYMM.Margin = new System.Windows.Forms.Padding(15, 1, 0, 0);
            this.lblYYYYMM.Name = "lblYYYYMM";
            this.lblYYYYMM.Size = new System.Drawing.Size(116, 22);
            this.lblYYYYMM.StyleSetName = "Default";
            this.lblYYYYMM.TabIndex = 2;
            this.lblYYYYMM.Text = "년도";
            this.lblYYYYMM.UseMnemonic = false;
            // 
            // popDeptCd
            // 
            this.popDeptCd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.popDeptCd.AutoPopupCodeParameter = null;
            this.popDeptCd.AutoPopupID = null;
            this.popDeptCd.AutoPopupNameParameter = null;
            this.popDeptCd.CodeMaxLength = 10;
            this.popDeptCd.CodeName = "";
            this.popDeptCd.CodeSize = 100;
            this.popDeptCd.CodeStyle = uniERP.AppFramework.UI.Controls.TextBox_Style.Default;
            this.popDeptCd.CodeTextBoxName = null;
            this.popDeptCd.CodeValue = "";
            this.popDeptCd.FieldType = uniERP.AppFramework.UI.Variables.enumDef.FieldType.Default;
            this.popDeptCd.Location = new System.Drawing.Point(599, 7);
            this.popDeptCd.LockedField = false;
            this.popDeptCd.Margin = new System.Windows.Forms.Padding(0);
            this.popDeptCd.Name = "popDeptCd";
            this.popDeptCd.NameDisplay = true;
            this.popDeptCd.NameId = null;
            this.popDeptCd.NameMaxLength = 50;
            this.popDeptCd.NamePopup = false;
            this.popDeptCd.NameSize = 150;
            this.popDeptCd.NameStyle = uniERP.AppFramework.UI.Controls.TextBox_Style.Default;
            this.popDeptCd.Parameter = null;
            this.popDeptCd.PopupButtonEnable = uniERP.AppFramework.UI.Variables.enumDef.uniOpenPopupButton.Enable;
            this.popDeptCd.PopupId = null;
            this.popDeptCd.PopupType = uniERP.AppFramework.UI.Variables.enumDef.PopupType.CommonPopup;
            this.popDeptCd.QueryIfEnterKeyPressed = true;
            this.popDeptCd.RequiredField = false;
            this.popDeptCd.Size = new System.Drawing.Size(271, 21);
            this.popDeptCd.TabIndex = 5;
            this.popDeptCd.uniALT = "Dept";
            this.popDeptCd.uniCharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.popDeptCd.UseDynamicFormat = false;
            this.popDeptCd.ValueTextBoxName = null;
            this.popDeptCd.BeforePopupOpen += new uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventHandler(this.popDeptCd_BeforePopupOpen);
            this.popDeptCd.AfterPopupClosed += new uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventHandler(this.popDeptCd_AfterPopupClosed);
            // 
            // lblDeptCd
            // 
            appearance13.TextHAlignAsString = "Left";
            appearance13.TextVAlignAsString = "Middle";
            this.lblDeptCd.Appearance = appearance13;
            this.lblDeptCd.AutoPopupID = null;
            this.lblDeptCd.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblDeptCd.LabelType = uniERP.AppFramework.UI.Variables.enumDef.LabelType.Title;
            this.lblDeptCd.Location = new System.Drawing.Point(483, 6);
            this.lblDeptCd.Margin = new System.Windows.Forms.Padding(15, 1, 0, 0);
            this.lblDeptCd.Name = "lblDeptCd";
            this.lblDeptCd.Size = new System.Drawing.Size(116, 22);
            this.lblDeptCd.StyleSetName = "Default";
            this.lblDeptCd.TabIndex = 4;
            this.lblDeptCd.Text = "부서";
            this.lblDeptCd.UseMnemonic = false;
            // 
            // lblEmpNo
            // 
            appearance14.TextHAlignAsString = "Left";
            appearance14.TextVAlignAsString = "Middle";
            this.lblEmpNo.Appearance = appearance14;
            this.lblEmpNo.AutoPopupID = null;
            this.lblEmpNo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblEmpNo.LabelType = uniERP.AppFramework.UI.Variables.enumDef.LabelType.Title;
            this.lblEmpNo.Location = new System.Drawing.Point(15, 29);
            this.lblEmpNo.Margin = new System.Windows.Forms.Padding(15, 1, 0, 0);
            this.lblEmpNo.Name = "lblEmpNo";
            this.lblEmpNo.Size = new System.Drawing.Size(116, 22);
            this.lblEmpNo.StyleSetName = "Default";
            this.lblEmpNo.TabIndex = 6;
            this.lblEmpNo.Text = "사번";
            this.lblEmpNo.UseMnemonic = false;
            // 
            // dtYYYYMM
            // 
            this.dtYYYYMM.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            appearance15.TextHAlignAsString = "Center";
            this.dtYYYYMM.Appearance = appearance15;
            this.dtYYYYMM.DateTime = new System.DateTime(2007, 9, 12, 0, 0, 0, 0);
            this.dtYYYYMM.DateType = uniERP.AppFramework.UI.Variables.enumDef.DateType.Default;
            this.dtYYYYMM.DropDownButtonDisplayStyle = Infragistics.Win.ButtonDisplayStyle.Never;
            this.dtYYYYMM.FieldType = uniERP.AppFramework.UI.Variables.enumDef.FieldType.Default;
            this.dtYYYYMM.Location = new System.Drawing.Point(131, 7);
            this.dtYYYYMM.LockedField = false;
            this.dtYYYYMM.Margin = new System.Windows.Forms.Padding(0);
            this.dtYYYYMM.MaxDate = new System.DateTime(9998, 1, 1, 0, 0, 0, 0);
            this.dtYYYYMM.MinDate = new System.DateTime(1973, 1, 1, 0, 0, 0, 0);
            this.dtYYYYMM.Name = "dtYYYYMM";
            this.dtYYYYMM.QueryIfEnterKeyPressed = true;
            this.dtYYYYMM.RequiredField = false;
            this.dtYYYYMM.Size = new System.Drawing.Size(70, 21);
            this.dtYYYYMM.SpinButtonDisplayStyle = Infragistics.Win.ButtonDisplayStyle.Always;
            this.dtYYYYMM.Style = uniERP.AppFramework.UI.Controls.DateTime_Style.YYYY;
            this.dtYYYYMM.StyleSetName = "Default";
            this.dtYYYYMM.TabIndex = 8;
            this.dtYYYYMM.uniALT = "Year";
            this.dtYYYYMM.uniValue = new System.DateTime(2007, 1, 1, 0, 0, 0, 0);
            this.dtYYYYMM.Value = new System.DateTime(2007, 9, 12, 0, 0, 0, 0);
            // 
            // uniLabel1
            // 
            appearance16.TextHAlignAsString = "Left";
            appearance16.TextVAlignAsString = "Middle";
            this.uniLabel1.Appearance = appearance16;
            this.uniLabel1.AutoPopupID = null;
            this.uniLabel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniLabel1.LabelType = uniERP.AppFramework.UI.Variables.enumDef.LabelType.Title;
            this.uniLabel1.Location = new System.Drawing.Point(483, 29);
            this.uniLabel1.Margin = new System.Windows.Forms.Padding(15, 1, 0, 0);
            this.uniLabel1.Name = "uniLabel1";
            this.uniLabel1.Size = new System.Drawing.Size(116, 22);
            this.uniLabel1.StyleSetName = "Default";
            this.uniLabel1.TabIndex = 10;
            this.uniLabel1.Text = "기준일";
            this.uniLabel1.UseMnemonic = false;
            // 
            // popEmpNo
            // 
            this.popEmpNo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.popEmpNo.AutoPopupCodeParameter = null;
            this.popEmpNo.AutoPopupID = null;
            this.popEmpNo.AutoPopupNameParameter = null;
            this.popEmpNo.CodeMaxLength = 13;
            this.popEmpNo.CodeName = "";
            this.popEmpNo.CodeSize = 100;
            this.popEmpNo.CodeStyle = uniERP.AppFramework.UI.Controls.TextBox_Style.Default;
            this.popEmpNo.CodeTextBoxName = null;
            this.popEmpNo.CodeValue = "";
            this.popEmpNo.FieldType = uniERP.AppFramework.UI.Variables.enumDef.FieldType.Default;
            this.popEmpNo.Location = new System.Drawing.Point(131, 30);
            this.popEmpNo.LockedField = false;
            this.popEmpNo.Margin = new System.Windows.Forms.Padding(0);
            this.popEmpNo.Name = "popEmpNo";
            this.popEmpNo.NameDisplay = true;
            this.popEmpNo.NameId = null;
            this.popEmpNo.NameMaxLength = 50;
            this.popEmpNo.NamePopup = false;
            this.popEmpNo.NameSize = 150;
            this.popEmpNo.NameStyle = uniERP.AppFramework.UI.Controls.TextBox_Style.Default;
            this.popEmpNo.Parameter = null;
            this.popEmpNo.PopupButtonEnable = uniERP.AppFramework.UI.Variables.enumDef.uniOpenPopupButton.Enable;
            this.popEmpNo.PopupId = null;
            this.popEmpNo.PopupType = uniERP.AppFramework.UI.Variables.enumDef.PopupType.CommonPopup;
            this.popEmpNo.QueryIfEnterKeyPressed = true;
            this.popEmpNo.RequiredField = false;
            this.popEmpNo.Size = new System.Drawing.Size(271, 21);
            this.popEmpNo.TabIndex = 7;
            this.popEmpNo.uniALT = "Emp No";
            this.popEmpNo.uniCharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.popEmpNo.UseDynamicFormat = false;
            this.popEmpNo.ValueTextBoxName = null;
            this.popEmpNo.BeforePopupOpen += new uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventHandler(this.popEmpNo_BeforePopupOpen);
            this.popEmpNo.OnExitEditCode += new uniERP.AppFramework.UI.Controls.Popup.OnExitEditCodeEventHandler(this.popEmpNo_OnExitEditCode);
            this.popEmpNo.AfterPopupClosed += new uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventHandler(this.popEmpNo_AfterPopupClosed);
            // 
            // uniTBL_MainReference
            // 
            this.uniTBL_MainReference.AutoFit = false;
            this.uniTBL_MainReference.AutoFitColumnCount = 4;
            this.uniTBL_MainReference.AutoFitRowCount = 4;
            this.uniTBL_MainReference.BackColor = System.Drawing.Color.Transparent;
            this.uniTBL_MainReference.ColumnCount = 3;
            this.uniTBL_MainReference.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainReference.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.uniTBL_MainReference.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.uniTBL_MainReference.DefaultRowSize = 23;
            this.uniTBL_MainReference.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniTBL_MainReference.EasyBaseBatchType = uniERP.AppFramework.UI.Controls.EasyBaseTBType.NONE;
            this.uniTBL_MainReference.HEIGHT_TYPE_00_REFERENCE = 32F;
            this.uniTBL_MainReference.HEIGHT_TYPE_01 = 3F;
            this.uniTBL_MainReference.HEIGHT_TYPE_01_CONDITION = 29F;
            this.uniTBL_MainReference.HEIGHT_TYPE_02 = 5F;
            this.uniTBL_MainReference.HEIGHT_TYPE_02_DATA = 0F;
            this.uniTBL_MainReference.HEIGHT_TYPE_03 = 3F;
            this.uniTBL_MainReference.HEIGHT_TYPE_03_BOTTOM = 32F;
            this.uniTBL_MainReference.HEIGHT_TYPE_04 = 3F;
            this.uniTBL_MainReference.Location = new System.Drawing.Point(0, 0);
            this.uniTBL_MainReference.Margin = new System.Windows.Forms.Padding(0);
            this.uniTBL_MainReference.Name = "uniTBL_MainReference";
            this.uniTBL_MainReference.PanelType = uniERP.AppFramework.UI.Variables.enumDef.PanelType.Default;
            this.uniTBL_MainReference.RowCount = 1;
            this.uniTBL_MainReference.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainReference.Size = new System.Drawing.Size(937, 21);
            this.uniTBL_MainReference.SizeTD5 = 14F;
            this.uniTBL_MainReference.SizeTD6 = 36F;
            this.uniTBL_MainReference.TabIndex = 2;
            this.uniTBL_MainReference.uniERPTableLayout = uniERP.AppFramework.UI.Controls.uniERPTableLayOutStyle.DefaultTableLayout;
            this.uniTBL_MainReference.uniLR_SPACE_TYPE = uniERP.AppFramework.UI.Controls.LR_SPACE_TYPE.LR_SPACE_TYPE_00;
            // 
            // uniTBL_MainBatch
            // 
            this.uniTBL_MainBatch.AutoFit = false;
            this.uniTBL_MainBatch.AutoFitColumnCount = 4;
            this.uniTBL_MainBatch.AutoFitRowCount = 4;
            this.uniTBL_MainBatch.BackColor = System.Drawing.Color.Transparent;
            this.uniTBL_MainBatch.ColumnCount = 5;
            this.uniTBL_MainBatch.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.uniTBL_MainBatch.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.uniTBL_MainBatch.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainBatch.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.uniTBL_MainBatch.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.uniTBL_MainBatch.Controls.Add(this.btnConfirm, 0, 0);
            this.uniTBL_MainBatch.DefaultRowSize = 23;
            this.uniTBL_MainBatch.Dock = System.Windows.Forms.DockStyle.Fill;
            this.uniTBL_MainBatch.EasyBaseBatchType = uniERP.AppFramework.UI.Controls.EasyBaseTBType.NONE;
            this.uniTBL_MainBatch.HEIGHT_TYPE_00_REFERENCE = 32F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_01 = 3F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_01_CONDITION = 29F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_02 = 5F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_02_DATA = 0F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_03 = 3F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_03_BOTTOM = 32F;
            this.uniTBL_MainBatch.HEIGHT_TYPE_04 = 3F;
            this.uniTBL_MainBatch.Location = new System.Drawing.Point(0, 568);
            this.uniTBL_MainBatch.Margin = new System.Windows.Forms.Padding(0);
            this.uniTBL_MainBatch.Name = "uniTBL_MainBatch";
            this.uniTBL_MainBatch.PanelType = uniERP.AppFramework.UI.Variables.enumDef.PanelType.Default;
            this.uniTBL_MainBatch.RowCount = 1;
            this.uniTBL_MainBatch.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.uniTBL_MainBatch.Size = new System.Drawing.Size(937, 28);
            this.uniTBL_MainBatch.SizeTD5 = 14F;
            this.uniTBL_MainBatch.SizeTD6 = 36F;
            this.uniTBL_MainBatch.TabIndex = 3;
            this.uniTBL_MainBatch.uniERPTableLayout = uniERP.AppFramework.UI.Controls.uniERPTableLayOutStyle.DefaultTableLayout;
            this.uniTBL_MainBatch.uniLR_SPACE_TYPE = uniERP.AppFramework.UI.Controls.LR_SPACE_TYPE.LR_SPACE_TYPE_00;
            // 
            // btnConfirm
            // 
            this.btnConfirm.AutoPopupID = null;
            this.btnConfirm.ButtonText = uniERP.AppFramework.UI.Variables.enumDef.ButtonText.UserDefined;
            this.btnConfirm.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnConfirm.Enabled = false;
            this.btnConfirm.Location = new System.Drawing.Point(0, 1);
            this.btnConfirm.Margin = new System.Windows.Forms.Padding(0, 1, 3, 3);
            this.btnConfirm.Name = "btnConfirm";
            this.btnConfirm.PopupID = null;
            this.btnConfirm.Size = new System.Drawing.Size(97, 24);
            this.btnConfirm.Style = uniERP.AppFramework.UI.Controls.Button_Style.Default;
            this.btnConfirm.TabIndex = 1;
            this.btnConfirm.Text = "반영";
            this.btnConfirm.UserDefinedText = null;
            this.btnConfirm.Visible = false;
            this.btnConfirm.Click += new System.EventHandler(this.btnConfirm_Click);
            // 
            // dtDocumentDt
            // 
            this.dtDocumentDt.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            appearance17.TextHAlignAsString = "Center";
            this.dtDocumentDt.Appearance = appearance17;
            this.dtDocumentDt.DateTime = new System.DateTime(2007, 8, 31, 0, 0, 0, 0);
            this.dtDocumentDt.DateType = uniERP.AppFramework.UI.Variables.enumDef.DateType.Default;
            this.dtDocumentDt.DropDownButtonDisplayStyle = Infragistics.Win.ButtonDisplayStyle.Never;
            this.dtDocumentDt.FieldType = uniERP.AppFramework.UI.Variables.enumDef.FieldType.Default;
            this.dtDocumentDt.Location = new System.Drawing.Point(599, 30);
            this.dtDocumentDt.LockedField = false;
            this.dtDocumentDt.Margin = new System.Windows.Forms.Padding(0);
            this.dtDocumentDt.MaxDate = new System.DateTime(9998, 1, 1, 0, 0, 0, 0);
            this.dtDocumentDt.MinDate = new System.DateTime(1973, 1, 1, 0, 0, 0, 0);
            this.dtDocumentDt.Name = "dtDocumentDt";
            this.dtDocumentDt.QueryIfEnterKeyPressed = true;
            this.dtDocumentDt.RequiredField = false;
            this.dtDocumentDt.Size = new System.Drawing.Size(100, 21);
            this.dtDocumentDt.SpinButtonDisplayStyle = Infragistics.Win.ButtonDisplayStyle.Always;
            this.dtDocumentDt.Style = uniERP.AppFramework.UI.Controls.DateTime_Style.Default;
            this.dtDocumentDt.StyleSetName = "Default";
            this.dtDocumentDt.TabIndex = 11;
            this.dtDocumentDt.uniALT = "Receipt Date";
            this.dtDocumentDt.uniValue = new System.DateTime(2007, 8, 31, 0, 0, 0, 0);
            this.dtDocumentDt.Value = new System.DateTime(2007, 8, 31, 0, 0, 0, 0);
            // 
            // ModuleViewer
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.Controls.Add(this.uniTBL_OuterMost);
            this.MinimumSize = new System.Drawing.Size(0, 0);
            this.Name = "ModuleViewer";
            this.Size = new System.Drawing.Size(948, 617);
            this.Controls.SetChildIndex(this.uniTBL_OuterMost, 0);
            this.Controls.SetChildIndex(this.uniLabel_Path, 0);
            ((System.ComponentModel.ISupportInitialize)(this.uniGrid1)).EndInit();
            this.uniTBL_OuterMost.ResumeLayout(false);
            this.uniTBL_MainData.ResumeLayout(false);
            this.uniTBL_MainCondition.ResumeLayout(false);
            this.uniTBL_MainCondition.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtYYYYMM)).EndInit();
            this.uniTBL_MainBatch.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dtDocumentDt)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private uniERP.AppFramework.UI.Controls.uniTableLayoutPanel uniTBL_OuterMost;
        private uniERP.AppFramework.UI.Controls.uniTableLayoutPanel uniTBL_MainData;
        private uniERP.AppFramework.UI.Controls.uniTableLayoutPanel uniTBL_MainCondition;
        private uniERP.AppFramework.UI.Controls.uniTableLayoutPanel uniTBL_MainReference;
        private uniERP.AppFramework.UI.Controls.uniTableLayoutPanel uniTBL_MainBatch;
        private uniERP.AppFramework.UI.Controls.uniGrid uniGrid1;
        private uniERP.AppFramework.UI.Controls.uniLabel lblYYYYMM;
        private uniERP.AppFramework.UI.Controls.uniLabel lblDeptCd;
        private uniERP.AppFramework.UI.Controls.uniOpenPopup popDeptCd;
        private uniERP.AppFramework.UI.Controls.uniLabel lblEmpNo;
        private uniERP.AppFramework.UI.Controls.uniOpenPopup popEmpNo;
        private uniERP.AppFramework.UI.Controls.uniButton btnConfirm;
        private uniERP.AppFramework.UI.Controls.uniDateTime dtYYYYMM;
        private uniERP.AppFramework.UI.Controls.uniLabel uniLabel1;
        private uniERP.AppFramework.UI.Controls.uniDateTime dtDocumentDt;

    }
}
