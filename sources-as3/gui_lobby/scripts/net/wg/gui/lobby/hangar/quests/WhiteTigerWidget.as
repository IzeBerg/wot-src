package net.wg.gui.lobby.hangar.quests
{
   import flash.events.Event;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class WhiteTigerWidget extends HangarWidgetInject
   {
      
      private static const WT_ENTRY_POINT_BOTTOM_INDENT:int = 15;
      
      private static const WT_ENTRY_POINT_SIDE_INDENT:int = 2;
      
      private static const WT_ENTRY_POINT_MARGIN_X:int = 20;
      
      private static const WT_ENTRY_POINT_SMALL_WIDTH:int = 200 + WT_ENTRY_POINT_MARGIN_X * 2;
      
      private static const WT_ENTRY_POINT_SMALL_HEIGHT:int = 150;
      
      private static const WT_ENTRY_POINT_WIDTH:int = 270 + WT_ENTRY_POINT_MARGIN_X * 2;
      
      private static const WT_ENTRY_POINT_HEIGHT:int = 250;
      
      private static const WT_ENTRY_POINT_Y_OFFSET:int = -8;
       
      
      private var _isSmall:Boolean = false;
      
      public function WhiteTigerWidget()
      {
         super();
         setManageSize(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         y = WT_ENTRY_POINT_Y_OFFSET;
         buttonMode = useHandCursor = true;
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = App.stage.stageWidth < StageSizeBoundaries.WIDTH_1600 || App.stage.stageHeight < StageSizeBoundaries.HEIGHT_900;
            if(this._isSmall != _loc1_ || width == 0)
            {
               this._isSmall = _loc1_;
               width = (!!this._isSmall ? WT_ENTRY_POINT_SMALL_WIDTH : WT_ENTRY_POINT_WIDTH) + WT_ENTRY_POINT_SIDE_INDENT;
               height = (!!this._isSmall ? WT_ENTRY_POINT_SMALL_HEIGHT : WT_ENTRY_POINT_HEIGHT) + WT_ENTRY_POINT_BOTTOM_INDENT;
               x = -(width >> 1);
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
