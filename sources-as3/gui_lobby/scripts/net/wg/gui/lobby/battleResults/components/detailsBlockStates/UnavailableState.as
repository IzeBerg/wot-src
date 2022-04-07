package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class UnavailableState extends DetailsState
   {
      
      private static const STATUS_BONUS_LABEL_OFFSET:int = 9;
      
      private static const BONUS_LEFT_OFFSET:int = -2;
      
      private static const INFO_ICON_OFFSET:int = 3;
      
      private static const STATUS_LABEL_ICON_OFFSET:int = 4;
       
      
      public var titleTf:TextField = null;
      
      public var descriptionTf:TextField = null;
      
      public var statusBonusTf:TextField = null;
      
      public var infoIcon:Image = null;
      
      private var _data:PremiumBonusVO = null;
      
      public function UnavailableState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTf.autoSize = TextFieldAutoSize.LEFT;
         this.titleTf.text = RTS_BATTLES.BATTLERESULTS_DETAILSBLOCK_TITLE;
         this.statusBonusTf.text = RTS_BATTLES.BATTLERESULTS_DETAILSBLOCK_DESCR;
         this.infoIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON;
         this.infoIcon.addEventListener(Event.CHANGE,this.onInfoIconChangeHandler);
         backgroundIcon.addEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
         backgroundIcon.source = RES_ICONS.MAPS_ICONS_PREMACC_BATTLERESULT_BONUS_X1;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data != null)
            {
               this.descriptionTf.htmlText = this._data.bonusLeft;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.titleTf.height + this.descriptionTf.height + BONUS_LEFT_OFFSET | 0;
            _loc1_ += this.statusBonusTf.height + STATUS_BONUS_LABEL_OFFSET | 0;
            this.titleTf.y = backgroundIcon.height - _loc1_ >> 1;
            this.descriptionTf.y = this.titleTf.y + this.titleTf.height + BONUS_LEFT_OFFSET | 0;
            this.statusBonusTf.y = this.descriptionTf.y + this.descriptionTf.height + STATUS_BONUS_LABEL_OFFSET | 0;
            this.infoIcon.x = this.titleTf.x;
            this.infoIcon.y = this.statusBonusTf.y + INFO_ICON_OFFSET;
            this.statusBonusTf.x = this.infoIcon.x + this.infoIcon.width + STATUS_LABEL_ICON_OFFSET | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.infoIcon.removeEventListener(Event.CHANGE,this.onInfoIconChangeHandler);
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.titleTf = null;
         this.descriptionTf = null;
         this.statusBonusTf = null;
         backgroundIcon.removeEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
         super.onDispose();
      }
      
      public function setData(param1:PremiumBonusVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onInfoIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onBackgroundIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
