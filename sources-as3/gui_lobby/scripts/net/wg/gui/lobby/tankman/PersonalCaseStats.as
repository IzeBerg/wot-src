package net.wg.gui.lobby.tankman
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.carousels.AchievementCarousel;
   import net.wg.gui.components.carousels.CarouselBase;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalCaseStats extends UIComponentEx implements IViewStackContent
   {
      
      private static const BOTTOM_PADDING:int = 26;
      
      private static const GAP:int = 13;
      
      private static const FIRST_ICON_MARGIN:int = 4;
      
      private static const SECOND_ICON_X:int = 87;
      
      private static const SECOND_ICON_X_WOT_PLUS:int = 83;
      
      private static const SECOND_ICON_Y_MARGIN:int = 2;
       
      
      public var blocksArea:PersonalCaseBlocksArea = null;
      
      public var achievements:AchievementCarousel = null;
      
      public var achivsBg:MovieClip = null;
      
      public var firstIcon:UILoaderAlt = null;
      
      public var firstMsg:TextField = null;
      
      public var secondIcon:UILoaderAlt = null;
      
      public var secondMsg:TextField = null;
      
      public var wotPlusIcon:UILoaderAlt = null;
      
      public var wotPlusMsg:TextField = null;
      
      private var _data:Object = null;
      
      public function PersonalCaseStats()
      {
         super();
         this.firstIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREM_SMALL_ICON;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            if(this._data.achievements.length > 0)
            {
               this.achievements.dataProvider = new DataProvider(this._data.achievements);
               this.achievements.invalidate(CarouselBase.INIT_CAROUSEL);
               this.achivsBg.visible = false;
            }
            this.blocksArea.setData(this._data.stats);
            this.firstMsg.htmlText = this._data.firstMsg;
            this.secondIcon.source = this._data.secondIcon;
            this.secondMsg.htmlText = this._data.secondMsg;
            if(this.isWotPlusVisible)
            {
               this.wotPlusIcon.source = this._data.wotPlusIcon;
               this.wotPlusMsg.htmlText = this._data.wotPlusMsg;
            }
            this.wotPlusIcon.visible = this.wotPlusMsg.visible = this.isWotPlusVisible;
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            if(this.isWotPlusVisible)
            {
               _loc1_ = height - this.wotPlusMsg.height - BOTTOM_PADDING;
               this.wotPlusIcon.y = this.wotPlusMsg.y = _loc1_ >> 0;
               this.secondMsg.y = this.wotPlusMsg.y - this.wotPlusMsg.height - GAP;
               this.secondIcon.y = this.secondMsg.y + SECOND_ICON_Y_MARGIN;
               this.secondIcon.x = SECOND_ICON_X_WOT_PLUS;
            }
            else
            {
               _loc1_ = height - this.secondMsg.height - BOTTOM_PADDING;
               this.secondIcon.y = this.secondMsg.y = _loc1_ >> 0;
               this.secondIcon.x = SECOND_ICON_X;
            }
            this.firstMsg.y = this.secondMsg.y - this.firstMsg.height - GAP >> 0;
            this.firstIcon.y = this.firstMsg.y + FIRST_ICON_MARGIN >> 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.achivsBg = null;
         this.firstMsg = null;
         this.secondMsg = null;
         this.wotPlusMsg = null;
         this.firstIcon.dispose();
         this.firstIcon = null;
         this.secondIcon.dispose();
         this.secondIcon = null;
         this.wotPlusIcon.dispose();
         this.wotPlusIcon = null;
         if(this.achievements)
         {
            this.achievements.dispose();
            this.achievements = null;
         }
         if(this.blocksArea)
         {
            this.blocksArea.dispose();
            this.blocksArea = null;
         }
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.achievements.visible = false;
         this.wotPlusIcon.visible = this.wotPlusMsg.visible = false;
         this.firstMsg.autoSize = this.secondMsg.autoSize = this.wotPlusMsg.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function update(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._data = param1;
         invalidateData();
         invalidateLayout();
      }
      
      public function get isWotPlusVisible() : Boolean
      {
         return this._data && this._data.wotPlusIcon && this._data.wotPlusMsg;
      }
   }
}
