package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   
   public class RankedTeamMemberItemRenderer extends TeamMemberRendererBase
   {
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const PLAYER_NAME_WIDTH:int = 121;
      
      private static const DIMM_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.4,0,0,0,0,0,0.4,0,0,0,0,0,0.4,0,0,0,0,0,1,0]);
      
      private static const DAMAGE_DEATH_COLOR:int = 6381391;
      
      private static const DAMAGE_DEFAULT_COLOR:int = 13413751;
      
      private static const STATE_OUT:String = "out";
      
      private static const STATE_OVER:String = "over";
      
      private static const ZERO:String = "0";
      
      private static const SLASH_N:String = "\n";
      
      private static const BADGE_OFFSET:int = 23;
      
      private static const NAME_X:int = 28;
       
      
      public var clickArea:MovieClip = null;
      
      public var selfBg:MovieClip = null;
      
      public var deadBg:MovieClip = null;
      
      public var playerName:UserNameField = null;
      
      public var vehicleName:TextField = null;
      
      public var damageLbl:TextField = null;
      
      public var fragsLbl:TextField = null;
      
      public var xpLbl:TextField = null;
      
      public var xpIcon:Sprite = null;
      
      public var medalIcon:EfficiencyIconRenderer = null;
      
      public var fakeFocusIndicator:MovieClip = null;
      
      public var vehicleIcon:UILoaderAlt = null;
      
      public var rankIcon:UILoaderAlt = null;
      
      public var testerIcon:UILoaderAlt = null;
      
      public var testerBG:UILoaderAlt = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _locale:ILocale;
      
      private var _colorMgr:IColorSchemeManager;
      
      private var _suffixBadgeIcon:String;
      
      private var _suffixBadgeStripIcon:String;
      
      public function RankedTeamMemberItemRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._locale = App.utils.locale;
         this._colorMgr = App.colorSchemeMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         hitArea = this.clickArea;
         this.playerName.addEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
         this.medalIcon.addEventListener(MouseEvent.ROLL_OVER,this.onMedalIconRollOverHandler);
         this.medalIcon.addEventListener(MouseEvent.ROLL_OUT,this.onMedalIconRollOutHandler);
         this.medalIcon.addEventListener(MouseEvent.CLICK,this.onMedalIconClickHandler);
         this.testerBG.visible = this.testerIcon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.playerName.removeEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
         this.medalIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onMedalIconRollOverHandler);
         this.medalIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onMedalIconRollOutHandler);
         this.medalIcon.removeEventListener(MouseEvent.CLICK,this.onMedalIconClickHandler);
         this.medalIcon.dispose();
         this.testerIcon.dispose();
         this.testerIcon = null;
         this.testerBG.dispose();
         this.testerBG = null;
         this.medalIcon = null;
         this._tooltipMgr = null;
         this._locale = null;
         this.clickArea = null;
         this.selfBg = null;
         this.deadBg = null;
         this.playerName.dispose();
         this.playerName = null;
         this.vehicleName = null;
         this.damageLbl = null;
         this.fragsLbl = null;
         this.xpLbl = null;
         this.xpIcon = null;
         this.fakeFocusIndicator = null;
         this.rankIcon.dispose();
         this.rankIcon = null;
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this._colorMgr = null;
         super.onDispose();
      }
      
      override protected function showData(param1:TeamMemberItemVO) : void
      {
         this.playerName.width = PLAYER_NAME_WIDTH;
         this.playerName.x = NAME_X;
         this.selfBg.visible = param1.isSelf;
         this.deadBg.visible = false;
         this.medalIcon.visible = false;
         this._suffixBadgeIcon = param1.suffixBadgeIcon;
         this._suffixBadgeStripIcon = param1.suffixBadgeStripIcon;
         var _loc2_:IColorScheme = null;
         if(param1.isTeamKiller)
         {
            _loc2_ = this._colorMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.TEAMKILLER_DEAD : ColorSchemeNames.TEAMKILLER);
         }
         else if(param1.isOwnSquad)
         {
            _loc2_ = this._colorMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.SELECTED_DEAD : ColorSchemeNames.SELECTED);
         }
         else
         {
            _loc2_ = this._colorMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.NORMAL_DEAD : ColorSchemeNames.NORMAL);
         }
         this.playerName.userVO = param1.userVO;
         var _loc3_:Number = _loc2_.rgb;
         this.playerName.textColor = _loc3_;
         this.playerName.useFakeName = !(param1.isSelf || param1.isOwnSquad);
         this.playerName.showAnonymizerIcon = param1.isSelf;
         this.vehicleIcon.source = Boolean(param1.tankIcon) ? param1.tankIcon : this.vehicleIcon.sourceAlt;
         this.vehicleName.htmlText = param1.vehicleName;
         this.xpLbl.text = this._locale.integer(param1.xp - param1.achievementXP);
         var _loc4_:String = param1.rankIcon;
         var _loc5_:Boolean = StringUtils.isNotEmpty(_loc4_);
         this.rankIcon.visible = _loc5_;
         if(_loc5_)
         {
            this.rankIcon.source = _loc4_;
         }
         if(StringUtils.isNotEmpty(this._suffixBadgeIcon))
         {
            this.playerName.width -= BADGE_OFFSET;
         }
         this.damageLbl.text = ZERO;
         this.vehicleName.textColor = _loc3_;
         this.fragsLbl.textColor = this.damageLbl.textColor = DAMAGE_DEFAULT_COLOR;
         if(param1.deathReason > -1)
         {
            this.damageLbl.textColor = DAMAGE_DEATH_COLOR;
            this.deadBg.visible = true;
            this.vehicleIcon.filters = [DIMM_FILTER];
         }
         else
         {
            this.vehicleIcon.filters = [];
         }
         if(param1.damageDealt > 0)
         {
            this.damageLbl.text = this._locale.integer(param1.damageDealt);
         }
         this.fragsLbl.visible = param1.kills > 0;
         if(this.fragsLbl.visible)
         {
            this.fragsLbl.text = param1.kills.toString();
         }
         if(param1.tkills > 0)
         {
            this.fragsLbl.textColor = getColorForAlias(ColorSchemeNames.TEAMKILLER,DEFAULT_TEAM_KILLER_COLOR);
         }
         if(param1.medalsCount > 0)
         {
            this.medalIcon.value = param1.medalsCount;
            this.medalIcon.validateNow();
            this.medalIcon.visible = true;
         }
         if(param1.isSelf)
         {
            App.utils.commons.formatPlayerName(this.playerName.textField,param1.userVO.userProps,false,true);
         }
      }
      
      private function setSuffixBadge(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = StringUtils.isNotEmpty(param1);
         this.testerIcon.visible = this.testerBG.visible = _loc3_;
         if(_loc3_)
         {
            this.testerIcon.source = param1;
            this.testerBG.source = param2;
            this.testerIcon.x = this.playerName.x + this.playerName.textWidth + FIELD_WIDTH_COMPENSATION >> 0;
            this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.fakeFocusIndicator.gotoAndPlay(STATE_OVER);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.fakeFocusIndicator.gotoAndPlay(STATE_OUT);
      }
      
      private function onPlayerNameChangeHandler(param1:Event) : void
      {
         this.setSuffixBadge(this._suffixBadgeIcon,this._suffixBadgeStripIcon);
      }
      
      private function onMedalIconRollOverHandler(param1:MouseEvent) : void
      {
         var _loc4_:Vector.<String> = null;
         var _loc5_:uint = 0;
         var _loc2_:DataProvider = TeamMemberItemVO(data).achievements;
         var _loc3_:int = _loc2_.length;
         if(_loc3_ > 0)
         {
            _loc4_ = new Vector.<String>();
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_.push(this._locale.makeString(ACHIEVEMENTS.all(_loc2_[_loc5_].type)));
               _loc5_++;
            }
            this._tooltipMgr.show(_loc4_.join(SLASH_N));
         }
      }
      
      private function onMedalIconRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onMedalIconClickHandler(param1:MouseEvent) : void
      {
         handleMouseRelease(param1);
      }
   }
}
