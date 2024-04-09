package net.wg.gui.lobby.battleResults.components.detailsBlockStates
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.battleResults.data.PremiumBonusVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class WotPlusInfoState extends DetailsState
   {
       
      
      public var description:TextField = null;
      
      public var bonusLeft:TextField = null;
      
      public var detailsBonusBtn:SoundButtonEx = null;
      
      private var _data:PremiumBonusVO = null;
      
      public function WotPlusInfoState()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bonusLeft.htmlText = BATTLE_RESULTS.COMMON_PLUSBONUS_PREMIUMPLUSADD;
         backgroundIcon.source = RES_ICONS.MAPS_ICONS_PREMACC_BATTLERESULT_PLUS_BONUS_ADVERTISING;
         this.detailsBonusBtn.visible = true;
         this.detailsBonusBtn.addEventListener(ButtonEvent.CLICK,this.onDetailsBtnClickHandler);
         this.detailsBonusBtn.label = BATTLE_RESULTS.COMMON_DETAILS_GETPREMBTN;
         backgroundIcon.addEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.description.htmlText = this._data.description;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         backgroundIcon.removeEventListener(Event.CHANGE,this.onBackgroundIconChangeHandler);
         this._data = null;
         this.detailsBonusBtn.removeEventListener(ButtonEvent.CLICK,this.onDetailsBtnClickHandler);
         this.detailsBonusBtn.dispose();
         this.detailsBonusBtn = null;
         this.description = null;
         this.bonusLeft = null;
         super.onDispose();
      }
      
      public function setData(param1:PremiumBonusVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onBackgroundIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onDetailsBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_MANAGEABLE_XP_SCREEN));
      }
   }
}
