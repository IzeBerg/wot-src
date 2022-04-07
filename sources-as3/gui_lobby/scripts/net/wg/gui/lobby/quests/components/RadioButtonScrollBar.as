package net.wg.gui.lobby.quests.components
{
   import flash.events.Event;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.components.controls.events.ScrollEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class RadioButtonScrollBar extends ButtonBarEx
   {
      
      private static const SPACING:Number = 4;
      
      private static const RENDERER_LINK:String = "ItemRadioButtonScrollBarUI";
       
      
      private var _scroller:IScroller;
      
      public function RadioButtonScrollBar()
      {
         super();
         itemRendererName = RENDERER_LINK;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         spacing = SPACING;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._scroller.maxHorizontalScrollPosition - this._scroller.minHorizontalScrollPosition;
            _loc2_ = _loc1_ / this._scroller.pageWidth + 1;
            this.updatePagesCount(_loc2_);
         }
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            container.x = width / scaleX - container.width >> 1;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            visible = _dataProvider.length > 1;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._scroller != null)
         {
            this._scroller.removeEventListener(ScrollEvent.UPDATE_SIZE,this.onScrollerUpdateSizeHandler);
            this._scroller.removeEventListener(Event.SCROLL,this.onScrollerScrollHandler);
            this._scroller = null;
         }
         super.onDispose();
      }
      
      public function setScroller(param1:IScroller) : void
      {
         this._scroller = param1;
         this._scroller.addEventListener(ScrollEvent.UPDATE_SIZE,this.onScrollerUpdateSizeHandler);
         this._scroller.addEventListener(Event.SCROLL,this.onScrollerScrollHandler);
      }
      
      private function updatePagesCount(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(_dataProvider.length != param1)
         {
            _dataProvider.cleanUp();
            _loc2_ = 0;
            while(_loc2_ < param1)
            {
               _dataProvider[_loc2_] = {};
               _loc2_++;
            }
            invalidateData();
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
      }
      
      override protected function handleButtonGroupChange(param1:Event) : void
      {
         if(_group.selectedIndex != selectedIndex)
         {
            this._scroller.goToItem(_group.selectedIndex,true);
         }
      }
      
      private function onScrollerUpdateSizeHandler(param1:ScrollEvent) : void
      {
         invalidateSize();
      }
      
      private function onScrollerScrollHandler(param1:Event) : void
      {
         selectedIndex = Math.round(this._scroller.horizontalScrollPosition / this._scroller.pageWidth);
      }
   }
}
