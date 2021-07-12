package net.wg.gui.components.tooltips
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.data.managers.IToolTipParams;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TooltipWrapper implements IDisposable
   {
       
      
      private var _target:DisplayObject;
      
      private var _tooltip:String;
      
      private var _tooltipParams:IToolTipParams;
      
      private var _isTooltipShown:Boolean;
      
      public function TooltipWrapper(param1:DisplayObject, param2:String, param3:IToolTipParams = null)
      {
         super();
         this._target = param1;
         this._target.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this._target.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this._tooltip = param2;
         this._tooltipParams = param3;
      }
      
      public function dispose() : void
      {
         this._target.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this._target.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this._target = null;
         this._tooltipParams = null;
      }
      
      private function hideTooltip() : void
      {
         if(App.toolTipMgr)
         {
            this._isTooltipShown = false;
            App.toolTipMgr.hide();
         }
      }
      
      private function showTooltip() : void
      {
         if(this._tooltip && App.toolTipMgr)
         {
            this._isTooltipShown = true;
            if(this._tooltipParams)
            {
               App.toolTipMgr.showComplexWithParams(this._tooltip,this._tooltipParams);
            }
            else
            {
               App.toolTipMgr.show(this._tooltip);
            }
         }
      }
      
      protected function onMouseDownHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      protected function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this.showTooltip();
      }
      
      protected function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
