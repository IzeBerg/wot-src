package net.wg.gui.lobby.battleResults.components
{
   import net.wg.data.constants.generated.BATTLE_RESULTS_PREMIUM_STATES;
   import net.wg.gui.lobby.battleResults.components.detailsBlockStates.AdvertisingState;
   import net.wg.gui.lobby.battleResults.components.detailsBlockStates.ComparePremiumState;
   import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumBonusState;
   import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumInfoState;
   import net.wg.gui.lobby.battleResults.components.detailsBlockStates.UnavailableState;
   import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
   import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DetailsBlock extends UIComponentEx
   {
       
      
      public var compareState:ComparePremiumState = null;
      
      public var bonusState:PremiumBonusState = null;
      
      public var premiumInfoState:PremiumInfoState = null;
      
      public var advertisingState:AdvertisingState = null;
      
      public var unavailableState:UnavailableState = null;
      
      private var _currentSelectedVehIdx:int = 0;
      
      private var _data:PersonalDataVO = null;
      
      public function DetailsBlock()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.bonusState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_BONUS;
               this.compareState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_EARNINGS;
               this.premiumInfoState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_INFO;
               this.advertisingState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_ADVERTISING;
               this.unavailableState.visible = this._data.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_UNAVAILABLE;
               if(this.premiumInfoState.visible)
               {
                  this.premiumInfoState.setData(this._data.premiumInfo);
                  this._data.addEventListener(BattleResultsViewEvent.BATTLE_QUEUE_ENTERED,this.onBattleQueueEnteredHandler);
                  this._data.addEventListener(BattleResultsViewEvent.BATTLE_QUEUE_EXITED,this.onBattleQueueExitedHandler);
               }
               if(this.compareState.visible)
               {
                  this.compareState.setData(this._data);
               }
               if(this.bonusState.visible)
               {
                  this.bonusState.setData(this._data.premiumBonus);
               }
               if(this.advertisingState.visible)
               {
                  this.advertisingState.setData(this._data.premiumInfo);
               }
               if(this.unavailableState.visible)
               {
                  this.unavailableState.setData(this._data.premiumBonus);
               }
            }
            if(isInvalid(InvalidationType.SELECTED_INDEX))
            {
               this.compareState.currentSelectedVehIdx = this._currentSelectedVehIdx;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.bonusState.dispose();
         this.bonusState = null;
         this.compareState.dispose();
         this.compareState = null;
         this.premiumInfoState.dispose();
         this.premiumInfoState = null;
         this.advertisingState.dispose();
         this.advertisingState = null;
         this.unavailableState.dispose();
         this.unavailableState = null;
         if(this._data != null)
         {
            this._data.removeEventListener(BattleResultsViewEvent.BATTLE_QUEUE_ENTERED,this.onBattleQueueEnteredHandler);
            this._data.removeEventListener(BattleResultsViewEvent.BATTLE_QUEUE_EXITED,this.onBattleQueueExitedHandler);
         }
         this._data = null;
         super.onDispose();
      }
      
      private function updateIsInBattleQueue(param1:Boolean) : void
      {
         if(this.premiumInfoState.visible)
         {
            this._data.premiumInfo.inBattleQueue = param1;
            this.premiumInfoState.invalidateData();
         }
      }
      
      public function set data(param1:PersonalDataVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function set currentSelectedVehIdx(param1:int) : void
      {
         this._currentSelectedVehIdx = param1;
         invalidate(InvalidationType.SELECTED_INDEX);
      }
      
      private function onBattleQueueEnteredHandler(param1:BattleResultsViewEvent) : void
      {
         this.updateIsInBattleQueue(true);
      }
      
      private function onBattleQueueExitedHandler(param1:BattleResultsViewEvent) : void
      {
         this.updateIsInBattleQueue(false);
      }
   }
}
