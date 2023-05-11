package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.missions.interfaces.IConditionVO;
   
   public class ConditionRendererVO extends DAAPIDataClass implements IConditionVO
   {
      
      private static const PROGRESS:String = "progress";
      
      private static const PROGRESS_LIST:String = "progressData";
      
      private static const TOOLTIP_DATA:String = "tooltipData";
      
      private static const CONDITION_DATA:String = "conditionData";
       
      
      public var icon:String = "";
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var progress:ProgressBarAnimVO = null;
      
      public var state:String = "";
      
      public var maxDescLines:int = -1;
      
      private var _useWideTextField:Boolean = false;
      
      private var _isCondition:Boolean = false;
      
      private var _tooltipData:ToolTipVO = null;
      
      private var _progressData:MissionProgressVO = null;
      
      private var _conditionData:MissionConditionVO = null;
      
      public function ConditionRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PROGRESS)
         {
            this.progress = new ProgressBarAnimVO(param2);
            return false;
         }
         if(param1 == PROGRESS_LIST)
         {
            this._progressData = new MissionProgressVO(param2);
            return false;
         }
         if(param1 == TOOLTIP_DATA)
         {
            this._tooltipData = new ToolTipVO(param2);
            return false;
         }
         if(param1 == CONDITION_DATA)
         {
            if(param2 != null)
            {
               this._conditionData = new MissionConditionVO(param2);
               this._isCondition = true;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._progressData != null)
         {
            this._progressData.dispose();
            this._progressData = null;
         }
         if(this.progress != null)
         {
            this.progress.dispose();
            this.progress = null;
         }
         if(this._tooltipData != null)
         {
            this._tooltipData.dispose();
            this._tooltipData = null;
         }
         if(this._conditionData != null)
         {
            this._conditionData.dispose();
            this._conditionData = null;
         }
         super.onDispose();
      }
      
      public function get progressData() : MissionProgressVO
      {
         return this._progressData;
      }
      
      public function get tooltipData() : ToolTipVO
      {
         return this._tooltipData;
      }
      
      public function get useWideTextField() : Boolean
      {
         return this._useWideTextField;
      }
      
      public function set useWideTextField(param1:Boolean) : void
      {
         this._useWideTextField = param1;
      }
      
      public function get conditionData() : MissionConditionVO
      {
         return this._conditionData;
      }
      
      public function get isCondition() : Boolean
      {
         return this._isCondition;
      }
   }
}
