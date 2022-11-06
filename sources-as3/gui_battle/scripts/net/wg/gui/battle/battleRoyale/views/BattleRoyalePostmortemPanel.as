package net.wg.gui.battle.battleRoyale.views
{
   import fl.motion.easing.Linear;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.infrastructure.base.meta.IBattleRoyalePostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyalePostmortemPanelMeta;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleRoyalePostmortemPanel extends BattleRoyalePostmortemPanelMeta implements IBattleRoyalePostmortemPanelMeta
   {
      
      private static const FADE_IN_DURATION:Number = 500;
      
      private static const TIP_FADE_IN_ALPHA:Number = 1;
       
      
      public var firstTipTitle:TextField = null;
      
      public var secondTipTitle:TextField = null;
      
      public var firstTipBody:TextField = null;
      
      public var secondTipBody:TextField = null;
      
      public var mouseIcon:MovieClip = null;
      
      public var escIcon:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      private var _currentTween:Tween = null;
      
      public function BattleRoyalePostmortemPanel()
      {
         super();
         this.firstTipTitle.blendMode = this.secondTipTitle.blendMode = this.firstTipBody.blendMode = this.secondTipBody.blendMode = BlendMode.SCREEN;
      }
      
      public function as_showDeadReason() : void
      {
         showDeadReason();
      }
      
      public function as_setPlayerInfo(param1:String) : void
      {
         setPlayerInfo(param1);
      }
      
      public function as_setSpectatorPanelVisible(param1:Boolean) : void
      {
         this.firstTipTitle.visible = this.secondTipTitle.visible = this.firstTipBody.visible = this.secondTipBody.visible = this.mouseIcon.visible = this.escIcon.visible = this.bg.visible = param1;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         this.clearTween();
         if(param1)
         {
            this.tipAlpha = 0;
            this._currentTween = new Tween(FADE_IN_DURATION,this,{"tipAlpha":TIP_FADE_IN_ALPHA},{"ease":Linear.easeNone});
         }
      }
      
      public function get tipAlpha() : Number
      {
         return this.firstTipTitle.alpha;
      }
      
      public function set tipAlpha(param1:Number) : void
      {
         this.bg.alpha = param1;
         this.firstTipTitle.alpha = this.secondTipTitle.alpha = this.firstTipBody.alpha = this.secondTipBody.alpha = this.mouseIcon.alpha = this.mouseIcon.alpha = this.escIcon.alpha = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         deadReasonBG.imageName = BATTLEATLAS.POSTMORTEM_DEAD_REASON_BG;
         this.firstTipTitle.text = BATTLE_ROYALE.POSTMORTEMPANEL_FIRSTTIP_TITLE;
         this.secondTipTitle.text = BATTLE_ROYALE.POSTMORTEMPANEL_SECONDTIP_TITLE;
         this.firstTipBody.text = BATTLE_ROYALE.POSTMORTEMPANEL_FIRSTTIP_BODY;
         this.secondTipBody.text = BATTLE_ROYALE.POSTMORTEMPANEL_SECONDTIP_BODY;
         TextFieldEx.setVerticalAutoSize(deadReasonTF,TextFieldEx.VALIGN_BOTTOM);
         updatePlayerInfoPosition();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.firstTipTitle = null;
         this.secondTipTitle = null;
         this.firstTipBody = null;
         this.secondTipBody = null;
         this.mouseIcon = null;
         this.escIcon = null;
         this.bg = null;
         super.onDispose();
      }
      
      private function clearTween() : void
      {
         if(this._currentTween)
         {
            this._currentTween.paused = true;
            this._currentTween.dispose();
            this._currentTween = null;
         }
      }
   }
}
