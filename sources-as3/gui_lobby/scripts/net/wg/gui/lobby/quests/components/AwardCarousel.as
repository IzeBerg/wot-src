package net.wg.gui.lobby.quests.components
{
   import flash.events.Event;
   import net.wg.gui.components.carousels.ScrollCarousel;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AwardCarousel extends ScrollCarousel
   {
      
      private static const ITEMS_ON_PAGE:int = 4;
      
      private static const RENDERER_WIDTH:int = 48;
      
      private static const RENDERER_HEIGHT:int = 48;
      
      private static const RENDERER_GAP:int = 50;
      
      private static const GO_TO_DURATION:Number = 0.5;
       
      
      private var _dataProvider:IDataProvider;
      
      public function AwardCarousel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         scrollList.useTimer = true;
         scrollList.cropContent = true;
         scrollList.snapToPages = true;
         rendererWidth = RENDERER_WIDTH;
         rendererHeight = RENDERER_HEIGHT;
         horizontalGap = RENDERER_GAP;
         pageWidth = (rendererWidth + horizontalGap) * ITEMS_ON_PAGE;
         scrollList.width = pageWidth - horizontalGap;
         var _loc1_:SoundButtonEx = rightArrow as SoundButtonEx;
         var _loc2_:SoundButtonEx = leftArrow as SoundButtonEx;
         if(_loc1_ && _loc2_)
         {
            _loc2_.soundEnabled = true;
            _loc1_.soundEnabled = true;
         }
      }
      
      override protected function updateLayout(param1:int, param2:int = 0) : void
      {
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            scrollList.goToDuration = 0;
            goToItem(0);
            scrollList.validateNow();
            scrollList.goToDuration = GO_TO_DURATION;
            _loc1_ = Boolean(this._dataProvider) ? int(this._dataProvider.length) : int(0);
            if(_loc1_ > ITEMS_ON_PAGE)
            {
               leftArrow.visible = rightArrow.visible = scrollList.touchScrollEnabled = scrollList.mouseWheelEnabled = scrollList.cropContent = true;
            }
            else
            {
               leftArrow.visible = rightArrow.visible = scrollList.touchScrollEnabled = scrollList.mouseWheelEnabled = scrollList.cropContent = false;
               scrollList.horizontalScrollPosition = _loc1_ * rendererWidth + (_loc1_ - 1) * horizontalGap - scrollList.width >> 1;
            }
         }
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(param1 != this._dataProvider)
         {
            if(this._dataProvider != null)
            {
               this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            super.dataProvider = param1;
            this._dataProvider = param1;
            if(this._dataProvider != null)
            {
               this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            invalidateData();
         }
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         invalidateData();
      }
   }
}
