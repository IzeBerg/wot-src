package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class EarlyAccessIcon extends Sprite implements IDisposable
   {
       
      
      public var icon:Image = null;
      
      public var hitMc:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function EarlyAccessIcon()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.source = RES_ICONS.MAPS_ICONS_EARLY_ACCESS_CAROUSEL_FILTER_POST_PROGRESSION;
         hitArea = this.hitMc;
         mouseChildren = false;
         buttonMode = true;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.hitMc = null;
         this._tooltipMgr = null;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.EARLY_ACCESS_CAROUSEL_VEHICLE_POST_PROGRESSION);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.icon.x = -this.icon.width >> 1;
         this.icon.y = -this.icon.height >> 1;
      }
   }
}
