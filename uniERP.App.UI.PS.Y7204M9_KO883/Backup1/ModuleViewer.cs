#region ● Namespace declaration

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;
using System.Web.Services.Protocols;

using Microsoft.Practices.CompositeUI.SmartParts;

using Infragistics.Shared;
using Infragistics.Win;
using Infragistics.Win.UltraWinGrid;

using uniERP.AppFramework.UI.Common;
using uniERP.AppFramework.UI.Controls;
using uniERP.AppFramework.UI.Module;
using uniERP.AppFramework.UI.Variables;
using uniERP.AppFramework.UI.Common.Exceptions;
using uniERP.AppFramework.DataBridge;
//using System.Xml.Linq;
using System.Linq;


#endregion

namespace uniERP.App.UI.HR.H4006M4_KO883
{
    [SmartPart]
    public partial class ModuleViewer : ViewBase
    {

        #region ▶ 1. Declaration part

        #region ■ 1.1 Program information
        /// <TemplateVersion>0.0.1.0</TemplateVersion>
        /// <NameSpace>①uniERP.App.UI.HR.H4006M4_KO883</NameSpace>
        /// <Module>②PS</Module>
        /// <Class>③ModuleViewer name</Class>
        /// <Desc>④
        ///   This part describe the summary information about class 
        /// </Desc>
        /// <History>⑤
        ///   <FirstCreated>
        ///     <history name="KSK" Date="2018-07-26">Make …</history>
        ///   </FirstCreated>
        ///   <Lastmodified>
        ///     <history name="modifier"  Date="modified date"> contents </history>
        ///     <history name="modifier"  Date="modified date"> contents </history>
        ///     <history name="modifier"  Date="modified date"> contents </history>
        ///   </Lastmodified>
        /// </History>
        /// <Remarks>⑥
        ///   <remark name="modifier"  Date="modified date">… </remark>
        ///   <remark name="modifier"  Date="modified date">… </remark>
        /// </Remarks>

        #endregion

        #region ■ 1.2. Class global constants (common)

        #endregion

        #region ■ 1.3. Class global variables (common)

        #endregion

        #region ■ 1.4 Class global constants (grid)


        #endregion

        #region ■ 1.5 Class global variables (grid)

        // change your code
        private tdsY8101M2_KO883 cstdsY8101M2_KO883 = new tdsY8101M2_KO883();

        #endregion

        #endregion

        #region ▶ 2. Initialization part

        #region ■ 2.1 Constructor(common)

        public ModuleViewer()
        {
            InitializeComponent();
        }

        #endregion

        #region ■ 2.2 Form_Load(common)

        protected override void Form_Load()
        {
            uniBase.UData.SetWorkingDataSet(this.cstdsY8101M2_KO883);
            uniBase.UCommon.SetViewType(enumDef.ViewType.T02_Multi);

            uniBase.UCommon.LoadInfTB19029(enumDef.FormType.Input, enumDef.ModuleInformation.Common);  // Load company numeric format. I: Input Program, *: All Module
            //uniBase.UCommon.LoadInfTB19029(enumDef.FormType.Query, enumDef.ModuleInformation.Purchase);  // Load company numeric format. I: Input Program, *: All Module

            this.LoadCustomInfTB19029();                                                   // Load custoqm numeric format
        }

        protected override void Form_Load_Completed()
        {
           // popProject.Focus();                // Set focus
            dtYYYYMM.Value = uniBase.UDate.GetDBServerDateTime();
            dtDocumentDt.Value = uniBase.UDate.GetDBServerDateTime();

            //uniBase.UCommon.SetToolBarMulti(enumDef.ToolBitMulti.DeleteRow, false);

            uniBase.UCommon.DisableButton(btnConfirm, true);
            //uniBase.UCommon.SetToolBarCommon(enumDef.ToolBitCommon.Save, false);
            //uniBase.UCommon.SetToolBarMultiAll(false);
            //uniBase.UCommon.SetToolBarSingleAll(false);

            ////uniBase.UCommon.SetToolBarCommon(enumDef.ToolBitCommon.Save, false);
            //uniBase.UCommon.SetToolBarSingle(enumDef.ToolBitSingle.Copy, false);
            ////uniBase.UCommon.SetToolBarSingle(enumDef.ToolBitSingle.Delete, false);
            ////uniBase.UCommon.SetToolBarSingle(enumDef.ToolBitSingle.First,false);
            ////uniBase.UCommon.SetToolBarSingle(enumDef.ToolBitSingle.Last, false);
            ////uniBase.UCommon.SetToolBarSingle(enumDef.ToolBitSingle.Next, false);
            ////uniBase.UCommon.SetToolBarSingle(enumDef.ToolBitSingle.Prev, false);
            ////uniBase.UCommon.SetToolBarMulti(enumDef.ToolBitMulti.Cancel, false);
            //uniBase.UCommon.SetToolBarMulti(enumDef.ToolBitMulti.CopyRow, false);
            //uniBase.UCommon.SetToolBarMulti(enumDef.ToolBitMulti.DeleteAll, false);
            //uniBase.UCommon.SetToolBarMulti(enumDef.ToolBitMulti.DeleteRow, false);
            //uniBase.UCommon.SetToolBarMulti(enumDef.ToolBitMulti.InsertRow, false);
        }

        #endregion

        #region ■ 2.3 Initializatize local global variables

        protected override void InitLocalVariables()
        {
            // init Dataset Row : change your code
            cstdsY8101M2_KO883.Clear();
        }

        #endregion

        #region ■ 2.4 Set local global default variables

        protected override void SetLocalDefaultValue()
        {
            // Assign default value to controls
            return;
        }

        #endregion

        #region ■ 2.5 Gathering combo data(GatheringComboData)

        protected override void GatheringComboData()
        {
            // Example: Set ComboBox List (Column Name, Select, From, Where)
            //uniBase.UData.ComboMajorAdd("TaxPolicy", "B0004");
            //uniBase.UData.ComboCustomAdd("MSG_TYPE", "MINOR_CD , MINOR_NM ", "B_MINOR", "MAJOR_CD='A1001'");
        }
        #endregion

        #region ■ 2.6 Define user defined numeric info

        public void LoadCustomInfTB19029()
        {

            #region User Define Numeric Format Data Setting  ☆
            base.viewTB19029.ggUserDefined6.DecPoint = 1;
            base.viewTB19029.ggUserDefined6.Integeral = 18;
            #endregion
        }

        #endregion

        #endregion

        #region ▶ 3. Grid method part

        #region ■ 3.1 Initialize Grid (InitSpreadSheet)

        private void InitSpreadSheet()
        {
            #region ■■ 3.1.1 Pre-setting grid information

            tdsY8101M2_KO883.E_PMS_PROJECT_RATEDataTable uniGridTB1 = cstdsY8101M2_KO883.E_PMS_PROJECT_RATE;

            uniGrid1.SSSetEdit(uniGridTB1.DILIG_EMP_NOColumn.ColumnName, "사번", 100, enumDef.FieldType.Primary, enumDef.CharCase.Upper, true, enumDef.HAlign.Left, 13);
            uniGrid1.SSSetEdit(uniGridTB1.EMP_NAMEColumn.ColumnName, "성명", 120, enumDef.FieldType.ReadOnly);
            uniGrid1.SSSetEdit(uniGridTB1.ROLL_PSTNColumn.ColumnName, "직위", 100, enumDef.FieldType.ReadOnly);
            uniGrid1.SSSetEdit(uniGridTB1.ROLL_PSTN_NMColumn.ColumnName, "직위명", 130, enumDef.FieldType.ReadOnly);            
            uniGrid1.SSSetEdit(uniGridTB1.dept_cdColumn.ColumnName, "부서", 100, enumDef.FieldType.ReadOnly);
            uniGrid1.SSSetEdit(uniGridTB1.dept_nmColumn.ColumnName, "부서명", 130, enumDef.FieldType.ReadOnly);
            uniGrid1.SSSetDate(uniGridTB1.DILIG_DTColumn.ColumnName, "근태일", enumDef.FieldType.ReadOnly, CommonVariable.gDateFormat, enumDef.HAlign.Center);
            uniGrid1.SSSetFloat(uniGridTB1.BASIC_QTYColumn.ColumnName, "연차수량", 100, viewTB19029.ggUserDefined6, enumDef.FieldType.NotNull);
            uniGrid1.SSSetFloat(uniGridTB1.USER_QTYColumn.ColumnName, "사용수량", 100, viewTB19029.ggUserDefined6, enumDef.FieldType.NotNull);
            uniGrid1.SSSetEdit(uniGridTB1.YYYYColumn.ColumnName, "년도", 120, enumDef.FieldType.ReadOnly);

            
            tdsY8101M2_KO883.E_PMS_PROJECT_RATE_CommonDataTable uniGridTB2 = cstdsY8101M2_KO883.E_PMS_PROJECT_RATE_Common;


            


            #endregion

            #region ■■ 3.1.2 Formatting grid information

            this.uniGrid1.InitializeGrid(enumDef.IsOutlookGroupBy.No, enumDef.IsSearch.No);

            #endregion

            #region ■■ 3.1.3 Setting etc grid
            this.uniGrid1.SSSetColHidden(uniGridTB1.YYYYColumn.ColumnName);
            this.uniGrid1.SSSetColHidden(uniGridTB1.DILIG_DTColumn.ColumnName);

            #endregion
        }
        #endregion

        #region ■ 3.2 InitData

        private void InitData()
        {
            // TO-DO: 컨트롤을 초기화(또는 초기값)할때 할일 
            // SetDefaultVal과의 차이점은 전자는 Form_Load 시점에 콘트롤에 초기값을 세팅하는것이고
            // 후자는 특정 시점(조회후 또는 행추가후 등 특정이벤트)에서 초기값을 셋팅한다.
        }

        #endregion

        #region ■ 3.3 SetSpreadColor

        private void SetSpreadColor(int pvStartRow, int pvEndRow)
        {
            // TO-DO: InsertRow후 그리드 컬러 변경
            //uniGrid1.SSSetProtected(gridCol.LastNum, pvStartRow, pvEndRow);
        }
        #endregion

        #region ■ 3.4 InitControlBinding
        protected override void InitControlBinding()
        {
            // Grid binding with global dataset variable.
            this.InitSpreadSheet();
            this.uniGrid1.uniGridSetDataBinding(this.cstdsY8101M2_KO883.E_PMS_PROJECT_RATE);
            //this.uniGrid2.uniGridSetDataBinding(this.cstdsY8101M2_KO883.E_PMS_PROJECT_RATE_Common);
        }
        #endregion

        #endregion

        #region ▶ 4. Toolbar method part

        #region ■ 4.1 Common Fnction group

        #region ■■ 4.1.1 OnFncQuery(old:FncQuery)

        protected override bool OnFncQuery()
        {
            //TO-DO : code business oriented logic


            return DBQuery();
        }

        #endregion

        #region ■■ 4.1.2 OnFncSave(old:FncSave)

        protected override bool OnFncSave()
        {
            //TO-DO : code business oriented logic

            string strCloseFlag = "";

            try
            {
                StringBuilder iSQL = new StringBuilder();
                iSQL.Remove(0, iSQL.Length);

                iSQL.AppendFormat(@"
Select ISNULL(CLOSE_FLAG,'')
From C_CLOSE_STATUS
Where 1=1
    And yyyymm = '{0}'
    "
                            , dtYYYYMM.uniValue.ToString("yyyyMM")
                      );

                if (iSQL.Length > 0)
                {                    
                    uniERP.AppFramework.DataBridge.uniCommand uniCmd = uniBase.UDatabase.GetSqlStringCommand(iSQL.ToString());
                    DataSet dsCloseStatus = uniBase.UDatabase.ExecuteDataSet(uniCmd);

                    if (dsCloseStatus != null && dsCloseStatus.Tables[0].Rows.Count > 0)
                    {
                        strCloseFlag = dsCloseStatus.Tables[0].Rows[0][0].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                bool reThrow = uniBase.UExceptionController.AutoProcessException(ex);
                if (reThrow)
                    throw;
                return false;
            }

            if (strCloseFlag == "I")
            {
                uniBase.UMessage.DisplayMessageBox("DT9999", MessageBoxButtons.OK, "해당월에 수불마감되어 자료를 \n 저장/삭제/변경 할 수 없습니다.");
                //236002 --해당월의 수불마감이 이미 되었습니다.
                return false;
            }

            return DBSave();
        }

        #endregion

        #endregion

        #region ■ 4.2 Single Fnction group

        #region ■■ 4.2.1 OnFncNew(old:FncNew)

        protected override bool OnFncNew()
        {

            //TO-DO : code business oriented logic

            return true;
        }

        #endregion

        #region ■■ 4.2.2 OnFncDelete(old:FncDelete)

        protected override bool OnFncDelete()
        {
            //TO-DO : code business oriented logic
            return true;
        }

        #endregion

        #region ■■ 4.2.3 OnFncCopy(old:FncCopy)

        protected override bool OnFncCopy()
        {
            //TO-DO : code business oriented logic
            return true;
        }

        #endregion

        #region ■■ 4.2.4 OnFncFirst(No implementation)

        #endregion

        #region ■■ 4.2.5 OnFncPrev(old:FncPrev)

        protected override bool OnFncPrev()
        {
            //TO-DO : code business oriented logic
            return true;
        }

        #endregion

        #region ■■ 4.2.6 OnFncNext(old:FncNext)

        protected override bool OnFncNext()
        {
            //TO-DO : code business oriented logic
            return true;
        }

        #endregion

        #region ■■ 4.2.7 OnFncLast(No implementation)

        #endregion

        #endregion

        #region ■ 4.3 Grid Fnction group

        #region ■■ 4.3.1 OnFncInsertRow(old:FncInsertRow)
        protected override bool OnPreFncInsertRow()
        {
            //if (uniTabControl1.ActiveTab.Index != 0)
            //{
            //    return false;
            //}

            return base.OnPreFncInsertRow();
        }

        protected override bool OnFncInsertRow()
        {
            //TO-DO : code business oriented logic           
            
            if (this.uniGrid1.ActiveRow != null)
            {
                this.uniGrid1.ActiveRow.Cells["yyyy"].Value = dtYYYYMM.uniValue.ToString("yyyy");
            }
            return true;
        }
        #endregion

        #region ■■ 4.3.2 OnFncDeleteRow(old:FncDeleteRow)
        protected override bool OnFncDeleteRow()
        {
            //TO-DO : code business oriented logic
            return true;
        }
        #endregion

        #region ■■ 4.3.3 OnFncCancel(old:FncCancel)
        protected override bool OnFncCancel()
        {
            //TO-DO : code business oriented logic
            return true;
        }
        #endregion

        #region ■■ 4.3.4 OnFncCopyRow(old:FncCopy)
        protected override bool OnFncCopyRow()
        {
            //TO-DO : code business oriented logic
            return true;
        }
        #endregion

        #endregion

        #region ■ 4.4 Db function group

        #region ■■ 4.4.1 DBQuery(Common)

        private bool DBQuery()
        {
            cstdsY8101M2_KO883.Clear();

            DataSet dsResult = null;
           

            try
            {
                using (uniCommand uniCommand = uniBase.UDatabase.GetStoredProcCommand("USP_H4006M1_KO883P_111"))
                {
                    uniBase.UDatabase.AddInParameter(uniCommand, "@YYYY", SqlDbType.NVarChar, dtYYYYMM.uniValue.ToString("yyyy"));
                    uniBase.UDatabase.AddInParameter(uniCommand, "@DILIG_EMP_NO", SqlDbType.NVarChar, popEmpNo.CodeValue.Trim());
                    uniBase.UDatabase.AddInParameter(uniCommand, "@DEPT_CD", SqlDbType.NVarChar, popDeptCd.CodeValue.Trim());
                    uniBase.UDatabase.AddInParameter(uniCommand, "@STD_DATE", SqlDbType.DateTime, dtDocumentDt.uniValue.ToString());
           

                    dsResult = uniBase.UDatabase.ExecuteDataSet(uniCommand);
                }

                if (dsResult == null || dsResult.Tables.Count == 0 || dsResult.Tables[0].Rows.Count == 0)
                {
                    uniBase.UMessage.DisplayMessageBox("900014", MessageBoxButtons.OK);
                    return false;
                }
                cstdsY8101M2_KO883.E_PMS_PROJECT_RATE.Merge(dsResult.Tables[0], false, MissingSchemaAction.Ignore);
            }

            catch (Exception ex)
            {
                bool reThrow = ExceptionControler.AutoProcessException(ex);
                if (reThrow)
                    throw;
                return false;
            }
            finally
            {

            }

            return true;
        }

        #endregion

        #region ■■ 4.4.2 DBDelete(Single)

        private bool DBDelete()
        {
            //TO-DO : code business oriented logic

            return true;
        }

        #endregion

        #region ■■ 4.4.3 DBSave(Common)

        private bool DBSave()
        {
            this.uniGrid1.UpdateData();
            cstdsY8101M2_KO883.I_PMS_PROJECT_RATE.Clear();
            DataTable saveDt = new DataTable();

            try
            {


                cstdsY8101M2_KO883.I_PMS_PROJECT_RATE.Merge(cstdsY8101M2_KO883.E_PMS_PROJECT_RATE.GetChanges(), false, MissingSchemaAction.Ignore);
                saveDt.Merge(cstdsY8101M2_KO883.I_PMS_PROJECT_RATE, false, MissingSchemaAction.Add);
                saveDt.AcceptChanges();

                using (uniCommand _uniCmd = uniBase.UDatabase.GetStoredProcCommand("dbo.USP_H4006M4_KO883_CUD"))
                {
                    uniBase.UDatabase.AddInParameter(_uniCmd, "@TBL_DATA", SqlDbType.Structured, saveDt);
                    uniBase.UDatabase.AddInParameter(_uniCmd, "@USER_ID", SqlDbType.NVarChar, 15, CommonVariable.gUsrID);
                    uniBase.UDatabase.AddOutParameter(_uniCmd, "@MSG_CD", SqlDbType.NVarChar, 6);
                    uniBase.UDatabase.AddOutParameter(_uniCmd, "@MESSAGE", SqlDbType.NVarChar, 200);
                    uniBase.UDatabase.AddOutParameter(_uniCmd, "@ERR_POS", SqlDbType.Int, 6);

                    uniBase.UDatabase.AddReturnParameter(_uniCmd, "RETURN_VALUE", SqlDbType.Int, 1);

                    uniBase.UDatabase.ExecuteNonQuery(_uniCmd, false);

                    int iReturn = (int)uniBase.UDatabase.GetParameterValue(_uniCmd, "RETURN_VALUE");

                    if (iReturn < 0)
                    {
                        string sMsgCd = uniBase.UDatabase.GetParameterValue(_uniCmd, "@MSG_CD") as string;
                        string sMessage = uniBase.UDatabase.GetParameterValue(_uniCmd, "@MESSAGE") as string;

                        if (string.IsNullOrEmpty(sMsgCd)) sMsgCd = "DT9999";

                        uniBase.UMessage.DisplayMessageBox(sMsgCd, MessageBoxButtons.OK, sMessage);

                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                bool reThrow = ExceptionControler.AutoProcessException(ex);
                if (reThrow)
                    throw;
                return false;
            }
            finally
            {

            }


            return true;

        }

        #endregion

        #endregion

        #endregion

        #region ▶ 5. Event method part

        #region ■ 5.1 Single control event implementation group

        #endregion

        #region ■ 5.2 Grid   control event implementation group

        #region ■■ 5.2.1 ButtonClicked >>> ClickCellButton
        /// <summary>
        /// Cell 내의 버튼을 클릭했을때의 일련작업들을 수행합니다.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void uniGrid1_ClickCellButton(object sender, CellEventArgs e)
        {
        }
        #endregion ■■ ButtonClicked >>> ClickCellButton

        #region ■■ 5.2.2 Change >>> CellChange
        /// <summary>
        /// fpSpread의 Change 이벤트는 UltraGrid의 BeforeExitEditMode 또는 AfterExitEditMode 이벤트로 대체됩니다.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void uniGrid1_BeforeExitEditMode(object sender, Infragistics.Win.UltraWinGrid.BeforeExitEditModeEventArgs e)
        {
        }

        private void uniGrid1_AfterExitEditMode(object sender, EventArgs e)
        {
            if (uniGrid1.ActiveRow == null || uniGrid1.ActiveCell == null) return;

            string sKey = uniGrid1.ActiveCell.Column.Key.ToUpper();
            DataSet pDataSet = null;


            switch (sKey)
            {
                case "EMP_NO":

                    if (dtYYYYMM.Value == null)
                    {
                        uniGrid1.ActiveRow.Cells["EMP_NO"].Value = "";
                        uniBase.UMessage.DisplayMessageBox("17A002", MessageBoxButtons.OK, dtYYYYMM.uniALT);
                        return;
                    }

                    string strEmpNo = string.Format(@"SELECT EMP_NO, NAME, DEPT_CD, DEPT_NM FROM HAA010T(NOLOCK) WHERE (EMP_NO LIKE {0} + '%' or NAME Like '%' + {0} + '%')AND (RETIRE_DT IS NULL OR RETIRE_DT >='{1}')",
uniBase.UCommon.FilterVariable(uniGrid1.ActiveRow.Cells["emp_no"].Value, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true)
, Convert.ToDateTime(dtYYYYMM.uniValue.ToString("yyyy-MM-01")).ToShortDateString());
                    pDataSet = uniBase.UDataAccess.CommonQuerySQL(strEmpNo);

                    if (pDataSet == null || pDataSet.Tables[0].Rows.Count == 0)
                    {
                        uniGrid1.ActiveRow.Cells["EMP_NO"].Value = "";
                        uniGrid1.ActiveRow.Cells["NAME"].Value = "";
                        uniGrid1.ActiveRow.Cells["DEPT_CD"].Value = "";
                        uniGrid1.ActiveRow.Cells["DEPT_NM"].Value = "";
                    }
                    else
                    {
                        uniGrid1.ActiveRow.Cells["EMP_NO"].Value = pDataSet.Tables[0].Rows[0][0];
                        uniGrid1.ActiveRow.Cells["NAME"].Value = pDataSet.Tables[0].Rows[0][1];
                        uniGrid1.ActiveRow.Cells["DEPT_CD"].Value = pDataSet.Tables[0].Rows[0][2];
                        uniGrid1.ActiveRow.Cells["DEPT_NM"].Value = pDataSet.Tables[0].Rows[0][3];
                    }

                    break;

                case "PROJECT_CODE":

                    string strPrj = string.Format(@"SELECT PROJECT_CODE, PROJECT_NM, PLAN_START_DT, PLAN_END_DT FROM PMS_PROJECT(NOLOCK) WHERE PROJECT_CODE = {0}
                      UNION ALL SELECT PROJECT_CODE, PROJECT_NM, '', '' FROM PMS_PROJECT_KO883(NOLOCK) WHERE PROJECT_CODE = {0} ",
                      uniBase.UCommon.FilterVariable(uniGrid1.ActiveRow.Cells["project_code"].Value, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true));
                    pDataSet = uniBase.UDataAccess.CommonQuerySQL(strPrj);

                    if (pDataSet == null || pDataSet.Tables[0].Rows.Count == 0)
                    {
                        uniGrid1.ActiveRow.Cells["project_code"].Value = "";
                        uniGrid1.ActiveRow.Cells["project_nm"].Value = "";
                        uniGrid1.ActiveRow.Cells["plan_start_dt"].Value = DBNull.Value;
                        uniGrid1.ActiveRow.Cells["plan_end_dt"].Value = DBNull.Value;
                    }
                    else
                    {
                        uniGrid1.ActiveRow.Cells["project_code"].Value = pDataSet.Tables[0].Rows[0][0];
                        uniGrid1.ActiveRow.Cells["project_nm"].Value = pDataSet.Tables[0].Rows[0][1];
                        uniGrid1.ActiveRow.Cells["plan_start_dt"].Value = Convert.ToDateTime(pDataSet.Tables[0].Rows[0][2]);
                        uniGrid1.ActiveRow.Cells["plan_end_dt"].Value = Convert.ToDateTime(pDataSet.Tables[0].Rows[0][3]);
                    }

                    break;
            }

        }
        #endregion ■■ Change >>> CellChange

        #region ■■ 5.2.3 Click >>> AfterCellActivate | AfterRowActivate | AfterSelectChange
        private void uniGrid1_AfterSelectChange(object sender, AfterSelectChangeEventArgs e)
        {
        }

        private void uniGrid1_AfterCellActivate(object sender, EventArgs e)
        {
        }

        private void uniGrid1_AfterRowActivate(object sender, EventArgs e)
        {
        }
        #endregion ■■ Click >>> AfterSelectChange

        #region ■■ 5.2.4 ComboSelChange >>> CellListSelect
        /// <summary>
        /// Cell 내의 콤보박스의 Item을 선택 변경했을때 이벤트가 발생합니다.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void uniGrid1_CellListSelect(object sender, CellEventArgs e)
        {
        }
        #endregion ■■ ComboSelChange >>> CellListSelect

        #region ■■ 5.2.5 DblClick >>> DoubleClickCell
        /// <summary>
        /// fpSpread의 DblClick이벤트는 UltraGrid의 DoubleClickCell이벤트로 변경 하실 수 있습니다.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void uniGrid1_DoubleClickCell(object sender, DoubleClickCellEventArgs e)
        {
        }
        #endregion ■■ DblClick >>> DoubleClickCell

        #region ■■ 5.2.6 MouseDown >>> MouseDown
        /// <summary>
        /// 마우스 우측 버튼 클릭시 Context메뉴를 보여주는 일련의 작업들을 이 이벤트에서 수행합니다.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void uniGrid1_MouseDown(object sender, MouseEventArgs e)
        {
        }
        #endregion ■■ MouseDown >>> MouseDown

        #region ■■ 5.2.7 ScriptLeaveCell >>> BeforeCellDeactivate
        /// <summary>
        /// fpSpread의 ScripLeaveCell 이벤트는 UltraGrid의 
        /// BeforeCellDeactivate 이벤트와 AfterCellActivate 이벤트를 겸해서 사용합니다.
        /// BeforeCellDeactivate    : 기존Cell에서 새로운 Cell로 이동하기 전에 기존Cell위치에서 처리 할 일련의 작업들을 기술합니다.
        /// AfterCellActivate       : 새로운 Cell로 이동해서 처리할 일련의 작업들을 기술합니다.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void uniGrid1_BeforeCellDeactivate(object sender, CancelEventArgs e)
        {
        }
        #endregion ■■ ScriptLeaveCell >>> BeforeCellDeactivate

        #endregion

        #region ■ 5.3 TAB    control event implementation group
        #endregion

        #endregion

        #region ▶ 6. Popup method part

        #region ■ 6.1 Common popup implementation group

        #endregion

        #region ■ 6.2 User-defined popup implementation group

        private void OpenNumberingType(string iWhere)
        {
            #region ▶▶▶ 10.1.2.1 Popup Constructors


            #endregion

            #region ▶▶▶ 10.1.2.2 Setting Returned Data



            #endregion

        }

        #endregion

        private void popDeptCd_BeforePopupOpen(object sender, uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventArgs e)
        {
            e.PopupPassData.PopupWinTitle = "P/R Dept.";
            e.PopupPassData.ConditionCaption = "P/R Dept.";

            e.PopupPassData.SQLFromStatements = "B_ACCT_DEPT(NOLOCK)";
            e.PopupPassData.SQLWhereInputCodeValue = this.popDeptCd.CodeValue.Trim();
            e.PopupPassData.SQLWhereInputNameValue = "";
            e.PopupPassData.SQLWhereStatements = "ORG_CHANGE_ID= " + uniBase.UCommon.FilterVariable(CommonVariable.gChangeOrgId, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true);
            e.PopupPassData.DistinctOrNot = true;

            e.PopupPassData.GridCellCode = new String[2];
            e.PopupPassData.GridCellCaption = new String[2];
            e.PopupPassData.GridCellType = new enumDef.GridCellType[2];

            e.PopupPassData.GridCellCode[0] = "DEPT_CD";
            e.PopupPassData.GridCellCode[1] = "DEPT_NM";

            e.PopupPassData.GridCellCaption[0] = "P/R Dept.";
            e.PopupPassData.GridCellCaption[1] = "P/R Dept. Name";

            e.PopupPassData.GridCellType[0] = enumDef.GridCellType.Edit;
            e.PopupPassData.GridCellType[1] = enumDef.GridCellType.Edit;
        }


        #endregion

        private void popDeptCd_AfterPopupClosed(object sender, uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventArgs e)
        {
            DataSet iDataSet = new DataSet();
            if (e.ResultData.Data == null)
                return;

            iDataSet = (DataSet)e.ResultData.Data;
            popDeptCd.CodeValue = iDataSet.Tables[0].Rows[0]["dept_cd"].ToString().Trim();
            popDeptCd.CodeName = iDataSet.Tables[0].Rows[0]["dept_nm"].ToString().Trim();
            //txtInternalCd.Text = iDataSet.Tables[0].Rows[0]["internal_cd"].ToString();

            popEmpNo.CodeValue = string.Empty;
            popEmpNo.CodeName = string.Empty;
        }

        private void popEmpNo_BeforePopupOpen(object sender, uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventArgs e)
        {
            string strDate = dtYYYYMM.Value == null ? uniBase.UDate.GetDBServerDateTime().ToString(CommonVariable.CDT_YYYY_MM_DD) : uniBase.UDate.GetFirstDay(Convert.ToDateTime(dtYYYYMM.Value.ToString())).ToShortDateString();
            
            string[] param_array = new string[] { popEmpNo.CodeValue, popEmpNo.CodeName, strDate};
            e.PopupPassData.CalledPopupID = "uniERP.App.UI.Popup.EmpPopup_KO883";            
            e.PopupPassData.PopupWinTitle = "Employee ID";
            e.PopupPassData.PopupWinWidth = 800;
            e.PopupPassData.PopupWinHeight = 700;
            e.PopupPassData.Data = param_array;
            
        }

        private void popEmpNo_AfterPopupClosed(object sender, uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventArgs e)
        {
           

            DataSet iDataSet = new DataSet();

            if (e.ResultData.Data == null)
                return;

            iDataSet = (DataSet)e.ResultData.Data;

            popEmpNo.CodeValue = iDataSet.Tables[0].Rows[0]["emp_no"].ToString();
            popEmpNo.CodeName = iDataSet.Tables[0].Rows[0]["name"].ToString();


        }

        private void uniGrid1_BeforePopupOpen(object sender, uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventArgs e)
        {
            switch (uniGrid1.ActiveCell.Column.ToString().ToUpper().Trim())
            {
                case "DILIG_EMP_NO":

                    if (dtYYYYMM.Value == null)
                    {
                        e.Cancel = true;
                        break;
                    }
                    
                    e.PopupPassData.CalledPopupID = "uniERP.App.UI.Popup.EmpPopup_KO883";
                    e.PopupPassData.PopupWinTitle = "Employee PopUp";
                    e.PopupPassData.PopupWinWidth = 800;
                    e.PopupPassData.PopupWinHeight = 700;

                    string strDate = dtYYYYMM.Value == null ? uniBase.UDate.GetDBServerDateTime().ToString(CommonVariable.CDT_YYYY_MM_DD) : uniBase.UDate.GetFirstDay(Convert.ToDateTime(dtYYYYMM.Value.ToString())).ToShortDateString();

                    //e.PopupPassData.Data = new string[] { popEmpNo.CodeValue, popEmpNo.CodeName, strDate, "1", "" };
                    e.PopupPassData.Data = new string[] { "", "", strDate, "1", "" };

                    break;

                case "PROJECT_CODE":

                    e.PopupPassData.CalledPopupID = "uniERP.App.UI.POPUP.Y7001PA_KO883";
                    e.PopupPassData.PopupWinTitle = "Projecct State Pop-up";
                    e.PopupPassData.Data = null;

                    break;

                default:
                    break;
            }
        }

        private void uniGrid1_AfterPopupClosed(object sender, uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventArgs e)
        {
            DataSet iDataSet = new DataSet();

            if (e.ResultData.Data == null) return;

            iDataSet = (DataSet)e.ResultData.Data;

            switch (uniGrid1.ActiveCell.Column.Key.ToUpper().Trim())
            {
                case "DILIG_EMP_NO":
                    uniBase.UGrid.SetGridValue(uniGrid1, "DILIG_EMP_NO", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["EMP_NO"].ToString());
                    uniBase.UGrid.SetGridValue(uniGrid1, "EMP_NAME", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["NAME"].ToString());
                    uniBase.UGrid.SetGridValue(uniGrid1, "dept_cd", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["dept_cd"].ToString());
                    uniBase.UGrid.SetGridValue(uniGrid1, "dept_nm", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["dept_nm"].ToString());
                    break;

                case "PROJECT_CODE":
                    uniBase.UGrid.SetGridValue(uniGrid1, "project_code", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["project_code"].ToString());
                    uniBase.UGrid.SetGridValue(uniGrid1, "project_nm", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["project_nm"].ToString());
                    uniBase.UGrid.SetGridValue(uniGrid1, "plan_start_dt", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["plan_start_dt"].ToString());
                    uniBase.UGrid.SetGridValue(uniGrid1, "plan_end_dt", uniGrid1.ActiveRow.Index, iDataSet.Tables[0].Rows[0]["plan_end_dt"].ToString());
                    break;

                default:
                    break;
            }
        }

        private void popProject_BeforePopupOpen(object sender, uniERP.AppFramework.UI.Controls.Popup.BeforePopupOpenEventArgs e)
        {
            e.PopupPassData.CalledPopupID = "uniERP.App.UI.POPUP.Y7001PA_KO883";
            e.PopupPassData.PopupWinTitle = "Projecct State Pop-up";
            e.PopupPassData.Data = null;
        }

        private void popProject_AfterPopupClosed(object sender, uniERP.AppFramework.UI.Controls.Popup.AfterPopupCloseEventArgs e)
        {
            DataSet iDataSet = new DataSet();

            if (e.ResultData.Data == null)
                return;

            iDataSet = (DataSet)e.ResultData.Data;
        }

        private void uniTabControl1_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            if (e.Tab.Index == 0)
            {
                uniBase.UCommon.SetToolBarMultiAll(true);
            }
            else
            {
                uniBase.UCommon.SetToolBarMultiAll(false);
            }
        }

        private void popEmpNo_OnExitEditCode(object sender, EventArgs e)
        {
            if (popEmpNo.CodeValue == "")
            {
                popEmpNo.CodeName = "";
                return;
            }

            string[] UNISqlId = new string[] { "ZN_HR_EMP_NM2" };
            string[][] UNIValue = new string[1][];
            UNIValue[0] = new string[5];


            string strDate = dtYYYYMM.Value == null ? uniBase.UDate.GetDBServerDateTime().ToString(CommonVariable.CDT_YYYY_MM_DD) : uniBase.UDate.GetFirstDay(Convert.ToDateTime(dtYYYYMM.Value.ToString())).ToShortDateString();            

            UNIValue[0][0] = uniBase.UCommon.FilterVariable(CommonVariable.gUsrID, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true);
            UNIValue[0][1] = uniBase.UCommon.FilterVariable(strDate, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true);
            UNIValue[0][2] = uniBase.UCommon.FilterVariable(popEmpNo.CodeValue, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true);
            UNIValue[0][3] = uniBase.UCommon.FilterVariable(popEmpNo.CodeValue, "''", enumDef.FilterVarType.BraceWithSingleQuotation, true);
            UNIValue[0][4] = " ";

            DataSet pDataSet = null;

            try
            {
                pDataSet = uniBase.UDataAccess.DBAgentQryRS(UNISqlId, UNIValue);

                if (pDataSet == null || pDataSet.Tables[0].Rows.Count == 0)
                {
                    uniBase.UMessage.DisplayMessageBox("810010", MessageBoxButtons.OK);
                    popEmpNo.CodeName = "";
                    popEmpNo.Focus();
                    return;

                }
                popEmpNo.CodeValue = pDataSet.Tables[0].Rows[0]["emp_no"].ToString();
                popEmpNo.CodeName = pDataSet.Tables[0].Rows[0]["name"].ToString();
            }
            catch (Exception ex)
            {
                bool reThrow = uniBase.UExceptionController.AutoProcessException(ex);
                if (reThrow)
                    throw;
                return;
            }
        }

        private void btnConfirm_Click(object sender, EventArgs e)
        {


            if (uniGrid1.ActiveRow == null)
            {
                uniBase.UMessage.DisplayMessageBox("181216", MessageBoxButtons.OK); //선택된 행이 없습니다.
                return;
            }

            DataTable saveDt = new DataTable();

            Ext1_Amt_Calc();



            DataTable saveDataTable = new DataTable();
            saveDataTable = uniGrid1.uniGridGetDataChanges();

           int iCount = saveDataTable.Rows.Count;



            StringBuilder strSQL = new StringBuilder();

            try
            {

            }
            catch (Exception ex)
            {
                bool reThrow = uniBase.UExceptionController.AutoProcessException(ex);
                if (reThrow)
                    throw;
                return;
            }
       
        }

        private void Ext1_Amt_Calc()
        {

        }

        private void uniGrid1_AfterCellUpdate(object sender, CellEventArgs e)
        {
           
         
        }


        #region ▶ 7. User-defined method part

        #region ■ 7.1 User-defined function group

        #endregion

        #endregion

    }
}