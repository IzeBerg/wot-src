package net.wg.gui.lobby.progressiveReward.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProgressiveRewardVO extends DAAPIDataClass
   {
      
      private static const FIELD_STEPS:String = "steps";
       
      
      public var stepIdx:uint = 0;
      
      public var titleText:String = "";
      
      public var descText:String = "";
      
      public var widgetAlign:uint = 0;
      
      public var btnTooltip:String = "";
      
      public var rewardTooltip:String = "";
      
      public var showBg:Boolean;
      
      public var isEnabled:Boolean;
      
      private var _steps:Vector.<ProgressiveRewardStepVO> = null;
      
      public function ProgressiveRewardVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ProgressiveRewardStepVO = null;
         if(this._steps)
         {
            for each(_loc1_ in this._steps)
            {
               _loc1_.dispose();
            }
            this._steps.fixed = false;
            this._steps.splice(0,this._steps.length);
            this._steps = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_STEPS)
         {
            if(param2 is Array)
            {
               this._steps = Vector.<ProgressiveRewardStepVO>(App.utils.data.convertVOArrayToVector(param1,param2,ProgressiveRewardStepVO));
               return false;
            }
            throw new Error(FIELD_STEPS + Errors.INVALID_TYPE);
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function getSteps() : Vector.<ProgressiveRewardStepVO>
      {
         return this._steps;
      }
   }
}
