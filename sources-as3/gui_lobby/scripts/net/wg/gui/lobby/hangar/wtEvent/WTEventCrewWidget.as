package net.wg.gui.lobby.hangar.wtEvent
{
   import flash.display.Stage;
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IWTEventCrewWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventCrewWidgetMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class WTEventCrewWidget extends WTEventCrewWidgetMeta implements IWTEventCrewWidgetMeta
   {
      
      private static const WIDGET_WIDTH:int = 469;
      
      private static const WIDGET_HEIGHT:int = 280;
      
      private static const WIDGET_SMALL_WIDTH:int = 369;
      
      private static const WIDGET_SMALL_HEIGHT:int = 218;
       
      
      private var _isSmall:Boolean = false;
      
      private var _stage:Stage;
      
      public function WTEventCrewWidget()
      {
         this._stage = App.stage;
         super();
         setManageSize(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this._isSmall = this._stage.stageHeight < StageSizeBoundaries.HEIGHT_900 || this._stage.stageWidth < StageSizeBoundaries.WIDTH_1600;
            setSize(!!this._isSmall ? Number(WIDGET_SMALL_WIDTH) : Number(WIDGET_WIDTH),!!this._isSmall ? Number(WIDGET_SMALL_HEIGHT) : Number(WIDGET_HEIGHT));
         }
      }
      
      override protected function onDispose() : void
      {
         this._stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         this._stage = null;
         super.onDispose();
      }
      
      public function as_hideWidget() : void
      {
         this.visible = false;
      }
      
      public function as_showWidget() : void
      {
         this.visible = true;
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
