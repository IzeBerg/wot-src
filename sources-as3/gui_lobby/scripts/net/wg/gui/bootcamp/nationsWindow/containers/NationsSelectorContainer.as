package net.wg.gui.bootcamp.nationsWindow.containers
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.nationsWindow.data.NationItemVO;
   import net.wg.gui.bootcamp.nationsWindow.events.NationSelectEvent;
   import net.wg.gui.components.carousels.ScrollCarousel;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class NationsSelectorContainer extends MovieClip implements IDisposable
   {
      
      private static const NATION_SELECT_BUTTON_UI:String = "NationSelectButtonUI";
      
      private static const RENDERER_WIDTH:int = 190;
      
      private static const GAP:int = -16;
      
      private static const TOP_BOTTOM_OFFSET:int = -16;
      
      private static const SIDE_OFFSET:int = -2;
      
      private static const SCOLL_PADDING:int = 19;
      
      private static const PROMO_OFFSET:int = 3;
       
      
      public var btnUsa:NationButton = null;
      
      public var btnGe:NationButton = null;
      
      public var btnUssr:NationButton = null;
      
      public var bottomBG:MovieClip = null;
      
      public var scrollCarousel:ScrollCarousel = null;
      
      private var _selectedNation:int = -1;
      
      private var _nationButtons:Vector.<NationButton>;
      
      private var _disposed:Boolean = false;
      
      public function NationsSelectorContainer()
      {
         this._nationButtons = new Vector.<NationButton>();
         super();
         this._nationButtons.push(this.btnUssr,this.btnGe,this.btnUsa);
         this.configUI();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._nationButtons.splice(0,this._nationButtons.length);
         this._nationButtons = null;
         this.btnUsa.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnGe.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnUssr.removeEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.scrollCarousel.removeEventListener(NationSelectEvent.NATION_SELECTED,this.onScrollListNationSelectedHandler);
         this.scrollCarousel.dispose();
         this.scrollCarousel = null;
         this.btnUsa.dispose();
         this.btnUsa = null;
         this.btnGe.dispose();
         this.btnGe = null;
         this.btnUssr.dispose();
         this.btnUssr = null;
         this.bottomBG = null;
      }
      
      public function selectNation(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc2_:int = this._selectedNation;
         if(_loc2_ != param1)
         {
            this._selectedNation = param1;
            if(_loc2_ != Values.DEFAULT_INT)
            {
               if(this._nationButtons.length > _loc2_)
               {
                  this._nationButtons[_loc2_].selected = false;
               }
            }
            if(this._nationButtons.length > param1)
            {
               this._nationButtons[param1].selected = true;
               this.scrollCarousel.selectedIndex = Values.DEFAULT_INT;
            }
            else
            {
               this.scrollCarousel.selectedIndex = param1 - PROMO_OFFSET;
               _loc3_ = this.scrollCarousel.rendererWidth + this.scrollCarousel.horizontalGap;
               _loc4_ = Math.ceil(this.scrollCarousel.scrollList.horizontalScrollPosition / _loc3_);
               _loc5_ = param1 - PROMO_OFFSET;
               _loc6_ = this.scrollCarousel.width / _loc3_;
               _loc7_ = _loc5_ < _loc4_;
               _loc8_ = _loc5_ >= _loc4_ + _loc6_;
               if(_loc7_ || _loc8_)
               {
                  if(_loc8_)
                  {
                     this.scrollCarousel.goToItem(_loc5_ + 1 - _loc6_,true);
                  }
                  else
                  {
                     this.scrollCarousel.goToItem(_loc5_,true);
                  }
               }
            }
         }
      }
      
      public function setNationsOrder(param1:Vector.<NationItemVO>, param2:Vector.<NationItemVO>) : void
      {
         var _loc6_:NationButton = null;
         var _loc7_:NationItemVO = null;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = this._nationButtons[_loc4_];
            _loc7_ = param1[_loc4_];
            _loc6_.data = _loc7_;
            _loc4_++;
         }
         var _loc5_:DataProvider = new DataProvider(App.utils.data.vectorToArray(param2));
         this.scrollCarousel.dataProvider = _loc5_;
      }
      
      public function setWidth(param1:int) : void
      {
         this.bottomBG.width = param1;
         this.scrollCarousel.width = param1 - this.scrollCarousel.x + SCOLL_PADDING;
      }
      
      protected function configUI() : void
      {
         this.scrollCarousel.itemRenderer = NATION_SELECT_BUTTON_UI;
         this.scrollCarousel.rendererWidth = RENDERER_WIDTH;
         this.scrollCarousel.horizontalGap = GAP;
         this.scrollCarousel.roundCountRenderer = false;
         var _loc1_:IScroller = this.scrollCarousel.scrollList;
         _loc1_.cropContent = true;
         _loc1_.maskOffsetLeft = SIDE_OFFSET;
         _loc1_.maskOffsetBottom = TOP_BOTTOM_OFFSET;
         _loc1_.maskOffsetTop = TOP_BOTTOM_OFFSET;
         _loc1_.maskOffsetRight = SIDE_OFFSET;
         _loc1_.showRendererOnlyIfDataExists = true;
         _loc1_.pageWidth = RENDERER_WIDTH + GAP;
         this.btnUsa.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnGe.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.btnUssr.addEventListener(ButtonEvent.CLICK,this.onBtnNationClickHandler);
         this.scrollCarousel.addEventListener(NationSelectEvent.NATION_SELECTED,this.onScrollListNationSelectedHandler);
         this.bottomBG.mouseEnabled = this.bottomBG.mouseChildren = false;
      }
      
      private function onScrollListNationSelectedHandler(param1:NationSelectEvent) : void
      {
         if(param1.selectedNation == this._selectedNation)
         {
            return;
         }
         this.selectNation(param1.selectedNation);
         dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SHOW,this._selectedNation));
      }
      
      private function onBtnNationClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:SoundButtonEx = SoundButtonEx(param1.currentTarget);
         var _loc3_:uint = this._nationButtons.indexOf(_loc2_);
         if(_loc3_ == this._selectedNation)
         {
            return;
         }
         this.selectNation(_loc3_);
         dispatchEvent(new NationSelectEvent(NationSelectEvent.NATION_SHOW,this._selectedNation));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
