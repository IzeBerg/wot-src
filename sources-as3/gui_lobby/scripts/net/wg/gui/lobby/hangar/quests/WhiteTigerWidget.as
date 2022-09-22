package net.wg.gui.lobby.hangar.quests
{
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IWhiteTigerWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.WhiteTigerWidgetMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class WhiteTigerWidget extends WhiteTigerWidgetMeta implements IWhiteTigerWidgetMeta, IHeaderFlagsEntryPoint
   {
      
      private static const WT_ENTRY_POINT_BOTTOM_INDENT:int = 15;
      
      private static const WT_ENTRY_POINT_SIDE_INDENT:int = 2;
      
      private static const WT_ENTRY_POINT_MARGIN_X:int = 20;
      
      private static const WT_ENTRY_POINT_SMALL_WIDTH:int = 200 + WT_ENTRY_POINT_MARGIN_X * 2;
      
      private static const WT_ENTRY_POINT_SMALL_HEIGHT:int = 130;
      
      private static const WT_ENTRY_POINT_WIDTH:int = 270 + WT_ENTRY_POINT_MARGIN_X * 2;
      
      private static const WT_ENTRY_POINT_HEIGHT:int = 180;
      
      private static const WT_ENTRY_POINT_Y_OFFSET:int = -8;
       
      
      private var _isMouseEnabled:Boolean = true;
      
      private var _isSmall:Boolean = false;
      
      public function WhiteTigerWidget()
      {
         super();
      }
      
      public function get marginRight() : int
      {
         return 0;
      }
      
      public function get marginLeft() : int
      {
         return 0;
      }
      
      public function get marginTop() : int
      {
         return 0;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         y = WT_ENTRY_POINT_Y_OFFSET;
         buttonMode = this._isMouseEnabled;
         useHandCursor = this._isMouseEnabled;
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(App.stage.stageWidth >= StageSizeBoundaries.WIDTH_1600 && App.stage.stageHeight >= StageSizeBoundaries.HEIGHT_900)
            {
               this.setIsSmallSize(false);
            }
            else
            {
               this.setIsSmallSize(true);
            }
            width = (!!this._isSmall ? WT_ENTRY_POINT_SMALL_WIDTH : WT_ENTRY_POINT_WIDTH) + WT_ENTRY_POINT_SIDE_INDENT;
            height = (!!this._isSmall ? WT_ENTRY_POINT_SMALL_HEIGHT : WT_ENTRY_POINT_HEIGHT) + WT_ENTRY_POINT_BOTTOM_INDENT;
            x = -(width >> 1);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      public function as_setIsMouseEnabled(param1:Boolean) : void
      {
         this._isMouseEnabled = param1;
         buttonMode = this._isMouseEnabled;
         useHandCursor = this._isMouseEnabled;
      }
      
      private function setIsSmallSize(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            setIsSmallS(this._isSmall);
         }
      }
      
      public function get marginX() : int
      {
         return WT_ENTRY_POINT_MARGIN_X;
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
