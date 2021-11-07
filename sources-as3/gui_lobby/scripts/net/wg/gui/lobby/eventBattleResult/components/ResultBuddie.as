package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.ComponentState;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.icons.SquadIcon;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.eventBattleResult.data.ResultPlayerVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ResultBuddie extends UIComponentEx
   {
      
      private static const SQUAD_COLOR:uint = 16757350;
      
      private static const TEXT_COLOR:uint = 15461355;
      
      private static const SQUAD_LABEL:String = "Squad";
      
      private static const BADGE_MARGIN:uint = 26;
      
      private static const ICON_GAP:int = 3;
      
      private static const BADGE_GAP:int = 2;
      
      private static const MEDAL_RENDERER:String = "PlayerMedalRendererUI";
      
      private static const KEY_CENTER_X:int = 766;
      
      private static const PLAYER_TF_X:int = 142;
      
      private static const PLAYER_TF_WIDTH:int = 179;
       
      
      public var playerTF:TextField = null;
      
      public var vehicleTF:TextField = null;
      
      public var soulsTF:TextField = null;
      
      public var killsTF:TextField = null;
      
      public var damageTF:TextField = null;
      
      public var blockedTF:TextField = null;
      
      public var keysTF:TextField = null;
      
      public var soulsTopTF:TextField = null;
      
      public var killsTopTF:TextField = null;
      
      public var damageTopTF:TextField = null;
      
      public var blockedTopTF:TextField = null;
      
      public var keysTopTF:TextField = null;
      
      public var keyMC:MovieClip = null;
      
      public var squadIcon:SquadIcon = null;
      
      public var vehicleTypeIcon:MovieClip = null;
      
      public var selectedMC:MovieClip = null;
      
      public var leftPanel:BuddieLeftPanel = null;
      
      public var badgeIcon:BadgeComponent = null;
      
      public var banIcon:MovieClip = null;
      
      public var testerIcon:UILoaderAlt = null;
      
      public var testerBG:UILoaderAlt = null;
      
      public var medals:GroupEx = null;
      
      private var _locale:ILocale;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _banTooltipData:String = "";
      
      public function ResultBuddie()
      {
         this._locale = App.utils.locale;
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.banIcon.addEventListener(MouseEvent.ROLL_OVER,this.onBanIconRollOverHandler);
         this.banIcon.addEventListener(MouseEvent.ROLL_OUT,this.onBanIconRollOutHandler);
         this.keysTF.mouseEnabled = this.keysTopTF.mouseEnabled = this.badgeIcon.mouseEnabled = this.testerIcon.mouseEnabled = this.testerBG.mouseEnabled = false;
         var _loc1_:HorizontalGroupLayout = new HorizontalGroupLayout();
         this.medals.layout = _loc1_;
         this.medals.itemRendererLinkage = MEDAL_RENDERER;
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.banIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onBanIconRollOverHandler);
         this.banIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onBanIconRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.badgeIcon.dispose();
         this.badgeIcon = null;
         this.playerTF = null;
         this.vehicleTF = null;
         this.soulsTF = null;
         this.killsTF = null;
         this.damageTF = null;
         this.blockedTF = null;
         this.keysTF = null;
         this.squadIcon.dispose();
         this.squadIcon = null;
         this.vehicleTypeIcon = null;
         this.selectedMC = null;
         this.leftPanel.dispose();
         this.leftPanel = null;
         this.testerIcon.dispose();
         this.testerIcon = null;
         this.testerBG.dispose();
         this.testerBG = null;
         this.medals.dispose();
         this.medals = null;
         this.soulsTopTF = null;
         this.killsTopTF = null;
         this.damageTopTF = null;
         this.blockedTopTF = null;
         this.keysTopTF = null;
         this.keyMC = null;
         this.banIcon = null;
         this._locale = null;
         this._tooltipMgr = null;
         this._banTooltipData = null;
         super.onDispose();
      }
      
      public function updateFriendButton(param1:Boolean, param2:Boolean) : void
      {
         this.leftPanel.updateFriendButton(param1,param2);
      }
      
      public function restoreSquadButton() : void
      {
         this.leftPanel.restoreSquadButton();
      }
      
      public function setData(param1:ResultPlayerVO, param2:CommonStatsVO, param3:Boolean, param4:Boolean) : void
      {
         this.selectedMC.visible = param1.isSelf;
         this.vehicleTF.htmlText = param1.vehicleName;
         this.soulsTF.text = this._locale.integer(param1.matter);
         this.killsTF.text = this._locale.integer(param1.kills);
         this.damageTF.text = this._locale.integer(param1.damageDealt);
         this.blockedTF.text = this._locale.integer(param1.blocked);
         this.keysTF.text = this._locale.integer(param1.rewardBoxKeys);
         this.soulsTopTF.text = this._locale.integer(param1.matter);
         this.killsTopTF.text = this._locale.integer(param1.kills);
         this.damageTopTF.text = this._locale.integer(param1.damageDealt);
         this.blockedTopTF.text = this._locale.integer(param1.blocked);
         this.keysTopTF.text = this._locale.integer(param1.rewardBoxKeys);
         var _loc5_:int = this.keysTF.textWidth + this.keyMC.width;
         this.keysTopTF.x = this.keysTF.x = KEY_CENTER_X - (_loc5_ >> 1);
         this.keyMC.x = this.keysTF.x + this.keysTF.textWidth + ICON_GAP >> 0;
         this.banIcon.gotoAndStop(param1.banStatus);
         this.medals.dataProvider = param1.medals;
         this._banTooltipData = param1.banStatusTooltip;
         if(param1.squadID > 0)
         {
            this.squadIcon.show(param1.isOwnSquad,param1.squadID);
         }
         else
         {
            this.squadIcon.hide();
         }
         var _loc6_:String = param1.tankType;
         var _loc7_:uint = TEXT_COLOR;
         if(param1.isSelf || param1.isOwnSquad)
         {
            _loc7_ = SQUAD_COLOR;
            _loc6_ += SQUAD_LABEL;
         }
         this.vehicleTypeIcon.gotoAndStop(_loc6_);
         this.leftPanel.setData(param1,param2,param3,param4);
         this.playerTF.x = PLAYER_TF_X;
         this.playerTF.width = PLAYER_TF_WIDTH;
         if(param1.userVO.badgeVisualVO != null && param1.hasSelectedBadge)
         {
            this.badgeIcon.setData(param1.userVO.badgeVisualVO);
            this.playerTF.x += BADGE_MARGIN;
            this.playerTF.width -= BADGE_MARGIN;
         }
         else
         {
            this.badgeIcon.visible = false;
         }
         var _loc8_:Boolean = StringUtils.isNotEmpty(param1.suffixBadgeIcon);
         this.testerIcon.visible = this.testerBG.visible = _loc8_;
         if(_loc8_)
         {
            this.testerIcon.source = param1.suffixBadgeIcon;
            this.testerBG.source = param1.suffixBadgeStripIcon;
            this.playerTF.width -= BADGE_MARGIN;
         }
         App.utils.commons.formatPlayerName(this.playerTF,param1.userVO.userProps);
         this.playerTF.textColor = _loc7_;
         if(_loc8_)
         {
            this.testerIcon.x = this.playerTF.x + this.playerTF.textWidth + BADGE_GAP >> 0;
            this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.originalWidth >> 0;
         }
      }
      
      public function setTop(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         this.soulsTF.visible = !param1;
         this.soulsTopTF.visible = param1;
         this.killsTF.visible = !param2;
         this.killsTopTF.visible = param2;
         this.damageTF.visible = !param3;
         this.damageTopTF.visible = param3;
         this.blockedTF.visible = !param4;
         this.blockedTopTF.visible = param4;
         this.keysTF.visible = !param5;
         this.keysTopTF.visible = param5;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(ComponentState.OVER);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         gotoAndPlay(ComponentState.OUT);
      }
      
      private function onBanIconRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._banTooltipData))
         {
            this._tooltipMgr.showComplex(this._banTooltipData);
         }
      }
      
      private function onBanIconRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
