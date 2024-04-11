package net.wg.gui.battle.battleRoyale.views
{
   import fl.motion.easing.Linear;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.infrastructure.base.meta.IBattleRoyalePostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyalePostmortemPanelMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleRoyalePostmortemPanel extends BattleRoyalePostmortemPanelMeta implements IBattleRoyalePostmortemPanelMeta, IStageSizeDependComponent
   {
      
      private static const FADE_IN_DURATION:Number = 500;
      
      private static const TIP_FADE_IN_ALPHA:Number = 1;
      
      private static const PLAYER_INFO_SMALL_Y_OFFSET:int = 70;
      
      private static const GAP_VEHICLE_PANEL_DEAD_REASON:int = 40;
      
      private static const GAP_VEHICLE_PANEL_DEAD_REASON_SMALL:int = 10;
       
      
      public var firstTipTitle:TextField = null;
      
      public var secondTipTitle:TextField = null;
      
      public var firstTipBody:TextField = null;
      
      public var secondTipBody:TextField = null;
      
      public var mouseIcon:MovieClip = null;
      
      public var escIcon:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      private var _currentTween:Tween = null;
      
      private var _isSmallSize:Boolean = false;
      
      private var PLAYER_INFO_FILTERS:Array;
      
      public function BattleRoyalePostmortemPanel()
      {
         this.PLAYER_INFO_FILTERS = [new DropShadowFilter(0,0,0,0.5,12,12),new DropShadowFilter(0,0,0,1,4,4)];
         super();
         this.firstTipTitle.blendMode = this.secondTipTitle.blendMode = this.firstTipBody.blendMode = this.secondTipBody.blendMode = BlendMode.SCREEN;
      }
      
      override protected function updatePlayerInfoPosition() : void
      {
         super.updatePlayerInfoPosition();
         vehiclePanel.y = -(App.appHeight >> 1) + VEHICLE_PANEL_OFFSET_Y;
         if(this._isSmallSize)
         {
            playerInfoTF.y += PLAYER_INFO_SMALL_Y_OFFSET;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         playerInfoTF.filters = this.PLAYER_INFO_FILTERS;
         deadReasonBG.imageName = BATTLEATLAS.POSTMORTEM_DEAD_REASON_BG;
         this.firstTipTitle.text = BATTLE_ROYALE.POSTMORTEMPANEL_FIRSTTIP_TITLE;
         this.secondTipTitle.text = BATTLE_ROYALE.POSTMORTEMPANEL_SECONDTIP_TITLE;
         this.firstTipBody.text = BATTLE_ROYALE.POSTMORTEMPANEL_FIRSTTIP_BODY;
         this.secondTipBody.text = BATTLE_ROYALE.POSTMORTEMPANEL_SECONDTIP_BODY;
         TextFieldEx.setVerticalAutoSize(deadReasonTF,TextFieldEx.VALIGN_BOTTOM);
         this.updatePlayerInfoPosition();
         App.stageSizeMgr.register(this);
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
         App.stageSizeMgr.unregister(this);
         super.onDispose();
      }
      
      public function as_setPlayerInfo(param1:String) : void
      {
         setPlayerInfo(param1);
      }
      
      public function as_setSpectatorPanelVisible(param1:Boolean) : void
      {
         this.firstTipTitle.visible = this.secondTipTitle.visible = this.firstTipBody.visible = this.secondTipBody.visible = this.mouseIcon.visible = this.escIcon.visible = this.bg.visible = param1;
      }
      
      public function as_showDeadReason() : void
      {
         showDeadReason();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 <= StageSizeBoundaries.WIDTH_1600;
         if(this._isSmallSize != _loc3_)
         {
            this._isSmallSize = _loc3_;
            invalidate(INVALID_PLAYER_INFO_POSITION);
         }
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
      
      override protected function get deadReasonGap() : int
      {
         return _userVO && _userVO.userName != Values.EMPTY_STR ? int(GAP_VEHICLE_PANEL_DEAD_REASON) : int(GAP_VEHICLE_PANEL_DEAD_REASON_SMALL);
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
   }
}
