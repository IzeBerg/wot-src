package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetEvent;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.gfx.MouseEventEx;
   
   public class EpicBattlesWidgetButton extends MovieClip implements IDisposable
   {
      
      private static const OUT:String = "out";
      
      private static const OVER:String = "over";
      
      private static const HIT_AREA_SIZE_SMALL:uint = 130;
      
      private static const HIT_AREA_SIZE_BIG:uint = 150;
       
      
      public var widget:EpicBattlesWidgetComponent = null;
      
      public var hitMc:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function EpicBattlesWidgetButton()
      {
         super();
         this.init();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         removeEventListener(MouseEvent.CLICK,this.onPreventMiddleRightClickHandler);
         removeEventListener(EpicBattlesWidgetEvent.LAYOUT_CHANGE,this.onLayoutChange);
         this.hitMc = null;
         this.widget.dispose();
         this.widget = null;
      }
      
      public function setData(param1:EpicBattlesWidgetVO) : void
      {
         this.widget.setData(param1);
      }
      
      public function updateOverState(param1:Boolean) : void
      {
         gotoAndPlay(!!param1 ? OVER : OUT);
      }
      
      public function updateSize() : void
      {
         this.widget.invalidateSize();
      }
      
      private function init() : void
      {
         buttonMode = mouseEnabled = mouseChildren = true;
         this.widget.hitArea = this.hitMc;
         this.widget.buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.onPreventMiddleRightClickHandler);
         addEventListener(EpicBattlesWidgetEvent.LAYOUT_CHANGE,this.onLayoutChange);
      }
      
      public function get ribbonWidth() : Number
      {
         return this.widget.ribbonWidth;
      }
      
      private function onPreventMiddleRightClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && MouseEventEx(param1).buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function onLayoutChange(param1:EpicBattlesWidgetEvent) : void
      {
         var _loc2_:Boolean = App.appHeight <= StageSizeBoundaries.HEIGHT_900;
         this.hitMc.width = this.hitMc.height = !!_loc2_ ? Number(HIT_AREA_SIZE_SMALL) : Number(HIT_AREA_SIZE_BIG);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
