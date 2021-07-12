package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.gfx.MouseEventEx;
   
   public class EpicBattlesWidgetButton extends MovieClip implements IDisposable
   {
      
      private static const OUT:String = "out";
      
      private static const OVER:String = "over";
       
      
      public var widget:EpicBattlesWidgetComponent = null;
      
      public var hitMc:MovieClip = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function EpicBattlesWidgetButton()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.init();
      }
      
      public final function dispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onPreventMiddleRightClickHandler);
         this.widget.dispose();
         this.widget = null;
         this.hitMc = null;
         this._toolTipMgr = null;
      }
      
      public function setData(param1:EpicBattlesWidgetVO) : void
      {
         this.widget.setData(param1);
      }
      
      public function updateSize() : void
      {
         this.widget.invalidateSize();
      }
      
      private function init() : void
      {
         buttonMode = mouseEnabled = mouseChildren = true;
         hitArea = this.hitMc;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onPreventMiddleRightClickHandler);
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         gotoAndPlay(OUT);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EVENT_PROGRESSION_PROGRESS_INFO,null);
         gotoAndPlay(OVER);
      }
      
      private function onPreventMiddleRightClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && MouseEventEx(param1).buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            param1.stopImmediatePropagation();
         }
      }
   }
}
