package net.wg.gui.components.questProgress.components.metrics.rangeValues
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsRangeVO;
   import net.wg.utils.ICommons;
   
   public class MetricsRangeValuesComponentTab extends MetricsRangeValuesComponentBase
   {
      
      private static const VALUE_GAP:int = 0;
      
      private static const GOAL_GAP:int = 0;
      
      protected static const SEPARATOR_GAP:int = 0;
       
      
      public var titleTf:TextField = null;
      
      private var _commons:ICommons;
      
      public function MetricsRangeValuesComponentTab()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function doInit(param1:QPMetricsRangeVO) : void
      {
         super.doInit(param1);
         this.titleTf.text = param1.title;
         this._commons.updateTextFieldSize(this.titleTf,true,false);
      }
      
      override protected function updateValueGoal(param1:String, param2:String) : void
      {
         super.updateValueGoal(param1,param2);
         this._commons.updateTextFieldSize(valueTf,true,false);
         this._commons.updateTextFieldSize(goalTf,true,false);
      }
      
      override protected function doUpdateState(param1:int) : void
      {
         super.doUpdateState(param1);
         var _loc2_:Boolean = isCompleted;
         var _loc3_:uint = !!_loc2_ ? uint(QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_COMPLETED_VALUE) : uint(QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_IN_PROGRESS_VALUE);
         var _loc4_:uint = !!_loc2_ ? uint(QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_COMPLETED) : uint(QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_IN_PROGRESS);
         valueTf.textColor = _loc3_;
         separatorTf.textColor = _loc4_;
         goalTf.textColor = _loc4_;
      }
      
      override protected function doLayout() : void
      {
         valueTf.x = this.titleTf.x + this.titleTf.width + VALUE_GAP;
         separatorTf.x = valueTf.x + valueTf.width + SEPARATOR_GAP;
         goalTf.x = separatorTf.x + separatorTf.width + GOAL_GAP;
         componentWidth = goalTf.x + goalTf.width;
         super.doLayout();
      }
   }
}
