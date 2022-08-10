package net.wg.infrastructure.uilogging.deprecated.bootcamp
{
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.uilogging.LogLevels;
   import net.wg.infrastructure.uilogging.deprecated.base.DeprecatedLogger;
   import net.wg.infrastructure.uilogging.deprecated.bootcamp.events.TooltipLogEvent;
   
   public class TooltipLogger extends DeprecatedLogger
   {
       
      
      private var _target:EventDispatcher = null;
      
      public function TooltipLogger(param1:EventDispatcher, param2:String, param3:String)
      {
         super(param2,param3);
         this._target = param1;
         this._target.addEventListener(TooltipLogEvent.SHOW_TOOLTIP,this.onTargetShowTooltipHandler);
         this._target.addEventListener(TooltipLogEvent.HIDE_TOOLTIP,this.onTargetHideTooltipHandler);
      }
      
      override public function dispose() : void
      {
         this._target.removeEventListener(TooltipLogEvent.SHOW_TOOLTIP,this.onTargetShowTooltipHandler);
         this._target.removeEventListener(TooltipLogEvent.HIDE_TOOLTIP,this.onTargetHideTooltipHandler);
         this._target = null;
         super.dispose();
      }
      
      private function onTargetShowTooltipHandler(param1:TooltipLogEvent) : void
      {
         startAction(BOOTCAMP_LOGGER_CONSTANTS.TOOLTIP_ACTION);
      }
      
      private function onTargetHideTooltipHandler(param1:TooltipLogEvent) : void
      {
         stopAction(BOOTCAMP_LOGGER_CONSTANTS.TOOLTIP_ACTION,LogLevels.INFO,{"tooltip":param1.key},BOOTCAMP_LOGGER_CONSTANTS.TIME_LIMIT);
      }
   }
}
