package net.wg.gui.battle.eventBattle.views.bossWidget
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventBossShield extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_SHIELD_ONLINE:String = "shieldOnline";
      
      private static const FRAME_LABEL_SHIELD_OFFLINE:String = "shieldOffline";
       
      
      public var eventGeneratorBar:EventGeneratorBar = null;
      
      public var eventBossTankIcon:EventBossTankIcon = null;
      
      public var eventBossBackground:EventBossBackground = null;
      
      public var eventBossHyperion:EventBossHyperion = null;
      
      public var hyperionDisabled:MovieClip = null;
      
      public var hyperionOn:MovieClip = null;
      
      private var _isShieldOnline:Boolean = false;
      
      private var _hyperionCharge:Number = 0;
      
      private var _hyperionMaxCharge:Number = 0;
      
      public function EventBossShield()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         this.setShieldOnline();
         super.configUI();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.handleHyperionAbility();
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.hyperionOn = null;
         this.hyperionDisabled = null;
         this.eventGeneratorBar.dispose();
         this.eventGeneratorBar = null;
         this.eventBossTankIcon.dispose();
         this.eventBossTankIcon = null;
         this.eventBossBackground.dispose();
         this.eventBossBackground = null;
         this.eventBossHyperion.dispose();
         this.eventBossHyperion = null;
         super.onDispose();
      }
      
      public function updateHyperionCharge(param1:Number, param2:Number) : void
      {
         this._hyperionCharge = param1;
         this._hyperionMaxCharge = param2;
         invalidate(InvalidationType.DATA);
      }
      
      public function setShieldOffline() : void
      {
         this._isShieldOnline = false;
         if(currentFrameLabel != FRAME_LABEL_SHIELD_OFFLINE)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_OFFLINE);
            invalidate(InvalidationType.DATA);
         }
         this.eventBossTankIcon.setShieldOffline();
         this.eventBossBackground.setShieldOffline();
      }
      
      public function setShieldOnline() : void
      {
         this._isShieldOnline = true;
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ONLINE);
            invalidate(InvalidationType.DATA);
         }
         this.eventBossTankIcon.setShieldOnline();
         this.eventBossBackground.setShieldOnline();
      }
      
      private function handleHyperionAbility() : void
      {
         if(this.eventBossHyperion)
         {
            this.eventBossHyperion.updateHyperionCharge(this._hyperionCharge,this._hyperionMaxCharge,this._isShieldOnline);
         }
      }
   }
}
