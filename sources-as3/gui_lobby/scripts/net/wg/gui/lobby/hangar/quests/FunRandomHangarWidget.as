package net.wg.gui.lobby.hangar.quests
{
   import flash.events.Event;
   import net.wg.infrastructure.base.meta.IFunRandomHangarWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.FunRandomHangarWidgetMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class FunRandomHangarWidget extends FunRandomHangarWidgetMeta implements IFunRandomHangarWidgetMeta, IHeaderFlagsEntryPoint
   {
      
      private static const SIDE_INDENT:int = 2;
      
      private static const OUTER_MARGIN_X_LEFT:int = -104;
      
      private static const OUTER_MARGIN_X_RIGHT:int = -108;
      
      private static const DEFAULT_WIDTH:uint = 320;
      
      private static const HEIGHT:int = 160;
      
      private static const COLS_MEDIUM:uint = 3;
      
      private static const COUNT_LIMIT_LOWER:uint = 4;
      
      private static const COUNT_LIMIT_MEDIUM:uint = 6;
      
      private static const COUNT_LIMIT_LARGE:uint = 9;
      
      private static const HEIGHT_PREFIX:uint = 60;
      
      private static const EXTRA_ROW_HEIGHT_PREFIX:uint = 67;
      
      private static const EXTRA_ROW_HEIGHT_SMALL:uint = 32;
      
      private static const EXTRA_ROW_HEIGHT_MEDIUM:uint = 40;
       
      
      private var _isSmall:Boolean = false;
      
      private var _iconsCount:int = 0;
      
      public function FunRandomHangarWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(App.stage.stageHeight < StageSizeBoundaries.HEIGHT_900)
            {
               this.setIsSmallSize(true);
            }
            else
            {
               this.setIsSmallSize(false);
            }
            width = DEFAULT_WIDTH + SIDE_INDENT;
            height = this.calculateHeight();
            x = -(width >> 1);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         super.onDispose();
      }
      
      public function as_setModifiersCount(param1:int) : void
      {
         if(this._iconsCount != param1)
         {
            this._iconsCount = param1;
            invalidateSize();
         }
      }
      
      private function setIsSmallSize(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
         }
      }
      
      private function calculateHeight() : int
      {
         var _loc1_:uint = 0;
         if(this._iconsCount > COUNT_LIMIT_LARGE)
         {
            _loc1_ = Math.ceil(this._iconsCount / COLS_MEDIUM) * EXTRA_ROW_HEIGHT_SMALL;
            return EXTRA_ROW_HEIGHT_PREFIX + _loc1_;
         }
         if(!this._isSmall && this._iconsCount <= COUNT_LIMIT_MEDIUM && this._iconsCount > COUNT_LIMIT_LOWER)
         {
            return HEIGHT_PREFIX + COLS_MEDIUM * EXTRA_ROW_HEIGHT_MEDIUM;
         }
         return HEIGHT;
      }
      
      public function get marginRight() : int
      {
         return OUTER_MARGIN_X_RIGHT;
      }
      
      public function get marginLeft() : int
      {
         return OUTER_MARGIN_X_LEFT;
      }
      
      public function get marginTop() : int
      {
         return 0;
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
