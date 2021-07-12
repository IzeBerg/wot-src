package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.text.TextField;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.lobby.epicBattles.events.EpicBattleInfoViewClickEvent;
   import net.wg.gui.lobby.epicBattles.utils.EpicHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class TitleElement extends UIComponentEx
   {
      
      private static const BUTTON_X_OFFSET:int = 10;
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var infoButton:IButtonIconLoader = null;
      
      private var _isSmallMode:Boolean = false;
      
      private var _smallTitle:String = "";
      
      private var _bigTitle:String = "";
      
      private var _description:String = "";
      
      public function TitleElement()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.descriptionTF.htmlText = this._description;
            this.titleTF.htmlText = !!this._isSmallMode ? this._smallTitle : this._bigTitle;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
            App.utils.commons.updateTextFieldSize(this.descriptionTF,true,true);
            this.titleTF.x = -this.titleTF.textWidth >> 1;
            _loc1_ = this.descriptionTF.textWidth + BUTTON_X_OFFSET + this.infoButton.width;
            _loc2_ = -_loc1_ >> 1;
            this.descriptionTF.x = _loc2_;
            this.infoButton.x = _loc2_ + this.descriptionTF.textWidth + BUTTON_X_OFFSET;
            this.descriptionTF.y = !!this._isSmallMode ? Number(EpicHelper.HERO_TITLE_SUBTITLE_DISTANCE) : Number(EpicHelper.EPIC_TITLE_SUBTITLE_DISTANCE);
            this.infoButton.y = !!this._isSmallMode ? Number(EpicHelper.HERO_TITLE_SUBTITLE_BUTTON_Y_PADDING) : Number(EpicHelper.EPIC_TITLE_SUBTITLE_BUTTON_Y_PADDING);
         }
      }
      
      override protected function onDispose() : void
      {
         this.infoButton.removeEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
         this.infoButton.dispose();
         this.infoButton = null;
         this.titleTF = null;
         this.descriptionTF = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_INFO;
         this.infoButton.addEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
      }
      
      public function setData(param1:String, param2:String, param3:String) : void
      {
         this._smallTitle = param1;
         this._bigTitle = param2;
         this._description = param3;
         invalidateData();
         invalidateSize();
      }
      
      public function set isSmallMode(param1:Boolean) : void
      {
         this._isSmallMode = param1;
         this.titleTF.htmlText = !!this._isSmallMode ? this._smallTitle : this._bigTitle;
         invalidateSize();
      }
      
      private function onInfoButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new EpicBattleInfoViewClickEvent(EpicBattleInfoViewClickEvent.INFO_BUTTON_CLICK));
      }
   }
}
