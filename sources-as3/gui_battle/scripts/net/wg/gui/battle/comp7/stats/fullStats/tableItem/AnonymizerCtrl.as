package net.wg.gui.battle.comp7.stats.fullStats.tableItem
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponentsHolder;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class AnonymizerCtrl extends BattleUIComponentsHolder
   {
       
      
      protected var hitArea:Sprite = null;
      
      private var _isPlayerAnonymized:Boolean = false;
      
      private var _isPlayerInClan:Boolean = false;
      
      private var _playerFakeName:String = null;
      
      private var _tooltip:String = null;
      
      private var _locale:ILocale;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function AnonymizerCtrl(param1:Sprite)
      {
         this._locale = App.utils.locale;
         this._tooltipMgr = App.toolTipMgr;
         super();
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOverHandler);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOutHandler);
         this.hitArea = param1;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._isPlayerAnonymized && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = !!this._isPlayerInClan ? TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN : TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN;
            this._tooltip = this._locale.makeString(_loc1_,{"fakeName":this._playerFakeName});
         }
      }
      
      override protected function onDispose() : void
      {
         this.hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onHitAreaRollOverHandler);
         this.hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onHitAreaRollOutHandler);
         this.hitArea = null;
         this._locale = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function setIsPlayerInClan(param1:Boolean) : void
      {
         if(this._isPlayerInClan != param1)
         {
            this._isPlayerInClan = param1;
            invalidate(InvalidationType.DATA);
         }
      }
      
      public function setPlayerFakeName(param1:String) : void
      {
         if(this._playerFakeName != param1)
         {
            this._playerFakeName = param1;
            this._isPlayerAnonymized = StringUtils.isNotEmpty(this._playerFakeName);
            invalidate(InvalidationType.DATA);
         }
      }
      
      private function onHitAreaRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isPlayerAnonymized)
         {
            this._tooltipMgr.show(this._tooltip);
         }
      }
      
      private function onHitAreaRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
