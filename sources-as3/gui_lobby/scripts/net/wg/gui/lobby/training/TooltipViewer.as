package net.wg.gui.lobby.training
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TooltipViewer implements IDisposable
   {
       
      
      private var _tooltip:String;
      
      private var _target:IEventDispatcher;
      
      public function TooltipViewer(param1:IEventDispatcher)
      {
         super();
         this._target = param1;
         this._target.addEventListener(MouseEvent.ROLL_OVER,this.show,false,0,true);
         this._target.addEventListener(MouseEvent.ROLL_OUT,this.hide,false,0,true);
      }
      
      private function hide(param1:MouseEvent) : void
      {
         if(App.toolTipMgr)
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function show(param1:MouseEvent) : void
      {
         if(this._tooltip && App.toolTipMgr)
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
      
      public function setTooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      public function dispose() : void
      {
         this._tooltip = null;
         this._target.removeEventListener(MouseEvent.ROLL_OVER,this.show);
         this._target.removeEventListener(MouseEvent.ROLL_OUT,this.hide);
         this._target = null;
      }
   }
}
