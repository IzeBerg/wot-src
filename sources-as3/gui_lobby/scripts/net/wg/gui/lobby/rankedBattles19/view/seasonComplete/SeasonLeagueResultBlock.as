package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.components.RibbonAwards;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.components.events.RibbonAwardAnimEvent;
   import net.wg.gui.lobby.rankedBattles19.events.SeasonCompleteEvent;
   import net.wg.gui.lobby.rankedBattles19.events.SoundEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class SeasonLeagueResultBlock extends SeasonBaseResultBlock
   {
      
      private static const SPRINTER_FADE_DURATION:int = 300;
       
      
      public var ribbonAwards:RibbonAwards = null;
      
      public var sprinterLabel:SeasonTextWrapper = null;
      
      private var _sprinterFadeTween:Tween = null;
      
      public function SeasonLeagueResultBlock()
      {
         super();
      }
      
      override public function setAwardsData(param1:RibbonAwardsVO) : void
      {
         this.ribbonAwards.setData(param1);
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         if(data)
         {
            placeResult.setInfoTooltip(data.placeTooltip);
         }
         this.disposeTween();
         if(data && StringUtils.isNotEmpty(data.sprinterLabel))
         {
            this.sprinterLabel.visible = true;
            this.sprinterLabel.setHtmlText(data.sprinterLabel);
         }
         else
         {
            this.sprinterLabel.alpha = 0;
            this.sprinterLabel.visible = false;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.RIBBON_FADE_IN_COMPLETE,this.onRibbonAwardsRibbonFadeInCompleteHandler);
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.MONEY_FADE_IN,this.onRibbonAwardsMoneyFadeInHandler);
         this.ribbonAwards.addEventListener(RibbonAwardAnimEvent.CONSUMABLE_FADE_IN,this.onRibbonAwardsConsumableFadeInHandler);
         this.sprinterLabel.alpha = 0;
         this.sprinterLabel.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.RIBBON_FADE_IN_COMPLETE,this.onRibbonAwardsRibbonFadeInCompleteHandler);
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.MONEY_FADE_IN,this.onRibbonAwardsMoneyFadeInHandler);
         this.ribbonAwards.removeEventListener(RibbonAwardAnimEvent.CONSUMABLE_FADE_IN,this.onRibbonAwardsConsumableFadeInHandler);
         this.ribbonAwards.dispose();
         this.ribbonAwards = null;
         this.sprinterLabel.dispose();
         this.sprinterLabel = null;
         this.disposeTween();
         this._sprinterFadeTween = null;
         super.onDispose();
      }
      
      override protected function onEndFadeInAnim() : void
      {
         super.onEndFadeInAnim();
         this.showAwards();
      }
      
      private function disposeTween() : void
      {
         if(this._sprinterFadeTween)
         {
            this._sprinterFadeTween.paused = true;
            this._sprinterFadeTween.dispose();
         }
      }
      
      private function showAwards() : void
      {
         this.ribbonAwards.show();
         dispatchEvent(new SoundEvent(SoundEvent.TRIGGER_SOUND,RANKEDBATTLES_ALIASES.SOUND_SEASON_COMPLETE_SHOW_RIBBON,true));
      }
      
      private function onRibbonAwardsRibbonFadeInCompleteHandler(param1:RibbonAwardAnimEvent) : void
      {
         dispatchEvent(new SeasonCompleteEvent(SeasonCompleteEvent.RESULT_BLOCK_READY));
         if(data && StringUtils.isNotEmpty(data.sprinterLabel))
         {
            this._sprinterFadeTween = new Tween(SPRINTER_FADE_DURATION,this.sprinterLabel,{"alpha":Values.DEFAULT_ALPHA});
         }
      }
      
      private function onRibbonAwardsMoneyFadeInHandler(param1:RibbonAwardAnimEvent) : void
      {
         dispatchEvent(new SoundEvent(SoundEvent.TRIGGER_SOUND,RANKEDBATTLES_ALIASES.SOUND_SEASON_COMPLETE_SHOW_AWARD,true));
      }
      
      private function onRibbonAwardsConsumableFadeInHandler(param1:RibbonAwardAnimEvent) : void
      {
         dispatchEvent(new SoundEvent(SoundEvent.TRIGGER_SOUND,RANKEDBATTLES_ALIASES.SOUND_SEASON_COMPLETE_SHOW_AWARD,true));
      }
   }
}
