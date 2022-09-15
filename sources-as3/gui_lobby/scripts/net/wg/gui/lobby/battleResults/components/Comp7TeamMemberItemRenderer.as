package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.components.icons.SquadIcon;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class Comp7TeamMemberItemRenderer extends TeamMemberRendererBase
   {
      
      private static var _dimmFilter:ColorMatrixFilter = null;
      
      private static const DAMAGE_DEATH_COLOR:uint = 6381391;
      
      private static const DAMAGE_DEFAULT_COLOR:uint = 13413751;
      
      private static const DIMMED_COLOR_VALUE:Number = 0.4;
      
      private static const PLAYER_NAME_WIDTH:int = 121;
      
      private static const STATE_OUT:String = "out";
      
      private static const STATE_OVER:String = "over";
      
      private static const PLAYER_NAME_OFFSET:int = 6;
      
      private static const BADGE_OFFSET:int = 23;
      
      private static const SQUAD_WIDTH:int = 28;
      
      private static const ZERO:String = "0";
      
      private static const BADGE_GAP:int = 2;
       
      
      public var clickArea:MovieClip = null;
      
      public var selfBg:MovieClip = null;
      
      public var deadBg:MovieClip = null;
      
      public var playerName:UserNameField = null;
      
      public var vehicleName:TextFieldShort = null;
      
      public var damageLbl:TextField = null;
      
      public var fragsLbl:TextField = null;
      
      public var xpLbl:TextField = null;
      
      public var xpIcon:Sprite = null;
      
      public var fakeFocusIndicator:MovieClip = null;
      
      public var squadIcon:SquadIcon = null;
      
      public var vehicleIcon:UILoaderAlt = null;
      
      public var testerIcon:UILoaderAlt = null;
      
      public var testerBG:UILoaderAlt = null;
      
      public var prestigePointsLbl:TextField = null;
      
      public var prestigePointsIcon:Sprite = null;
      
      private var _isOwnSquad:Boolean = false;
      
      private var _squadID:int = -1;
      
      private var _locale:ILocale;
      
      private var _suffixBadgeIcon:String = "";
      
      private var _suffixBadgeStripIcon:String = "";
      
      private var _colorMgr:IColorSchemeManager;
      
      public function Comp7TeamMemberItemRenderer()
      {
         this._locale = App.utils.locale;
         this._colorMgr = App.colorSchemeMgr;
         super();
      }
      
      private static function getDimmFilter() : ColorMatrixFilter
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         if(_dimmFilter == null)
         {
            _dimmFilter = new ColorMatrixFilter();
            _loc1_ = [DIMMED_COLOR_VALUE,0,0,0,0];
            _loc2_ = [0,DIMMED_COLOR_VALUE,0,0,0];
            _loc3_ = [0,0,DIMMED_COLOR_VALUE,0,0];
            _loc4_ = [0,0,0,1,0];
            _loc5_ = [];
            _loc5_ = _loc5_.concat(_loc1_);
            _loc5_ = _loc5_.concat(_loc2_);
            _loc5_ = _loc5_.concat(_loc3_);
            _loc5_ = _loc5_.concat(_loc4_);
            _dimmFilter.matrix = _loc5_;
         }
         return _dimmFilter;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         hitArea = this.clickArea;
         this.vehicleName.mouseEnabled = true;
         this.playerName.addEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.playerName.removeEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
         this.playerName.dispose();
         this.playerName = null;
         this.testerIcon.dispose();
         this.testerIcon = null;
         this.testerBG.dispose();
         this.testerBG = null;
         this.vehicleName.dispose();
         this.vehicleName = null;
         this.squadIcon.dispose();
         this.squadIcon = null;
         this.vehicleIcon.filters = [];
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.clickArea = null;
         this.selfBg = null;
         this.deadBg = null;
         this.damageLbl = null;
         this.fragsLbl = null;
         this.xpLbl = null;
         this.xpIcon = null;
         this.fakeFocusIndicator = null;
         this.prestigePointsLbl = null;
         this.prestigePointsIcon = null;
         this._locale = null;
         this._colorMgr = null;
         super.onDispose();
      }
      
      override protected function showData(param1:TeamMemberItemVO) : void
      {
         this.playerName.width = PLAYER_NAME_WIDTH;
         this._suffixBadgeIcon = param1.suffixBadgeIcon;
         this._suffixBadgeStripIcon = param1.suffixBadgeStripIcon;
         var _loc2_:Boolean = param1.isSelf;
         this.selfBg.visible = _loc2_;
         this.deadBg.visible = false;
         this._isOwnSquad = param1.isOwnSquad;
         this._squadID = param1.squadID;
         var _loc3_:Boolean = param1.deathReason > -1;
         var _loc4_:IColorScheme = null;
         if(param1.isTeamKiller)
         {
            _loc4_ = this._colorMgr.getScheme(!!_loc3_ ? ColorSchemeNames.TEAMKILLER_DEAD : ColorSchemeNames.TEAMKILLER);
         }
         else if(this._isOwnSquad)
         {
            _loc4_ = this._colorMgr.getScheme(!!_loc3_ ? ColorSchemeNames.SELECTED_DEAD : ColorSchemeNames.SELECTED);
         }
         else
         {
            _loc4_ = this._colorMgr.getScheme(!!_loc3_ ? ColorSchemeNames.NORMAL_DEAD : ColorSchemeNames.NORMAL);
         }
         if(StringUtils.isNotEmpty(this._suffixBadgeIcon))
         {
            this.playerName.width -= BADGE_OFFSET;
         }
         this.playerName.userVO = param1.userVO;
         this.playerName.textColor = _loc4_.rgb;
         this.playerName.useFakeName = !(_loc2_ || this._isOwnSquad);
         this.playerName.showAnonymizerIcon = _loc2_;
         this.vehicleIcon.source = Boolean(param1.tankIcon) ? param1.tankIcon : this.vehicleIcon.sourceAlt;
         this.vehicleName.useHtml = true;
         this.vehicleName.label = this.vehicleName.toolTip = param1.vehicleName;
         this.xpLbl.text = this._locale.integer(param1.xp - param1.achievementXP);
         this.prestigePointsLbl.text = this._locale.integer(param1.prestigePoints);
         this.damageLbl.text = ZERO;
         this.vehicleName.textColor = _loc4_.rgb;
         this.fragsLbl.textColor = this.damageLbl.textColor = DAMAGE_DEFAULT_COLOR;
         if(_loc3_)
         {
            this.damageLbl.textColor = DAMAGE_DEATH_COLOR;
            this.deadBg.visible = true;
            this.vehicleIcon.filters = [getDimmFilter()];
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
         if(_loc2_)
         {
            App.utils.commons.formatPlayerName(this.playerName.textField,param1.userVO.userProps,false,true);
         }
      }
      
      override protected function updateCommonData(param1:CommonStatsVO) : void
      {
         this.squadIcon.hide();
         if(param1.isShowSquad)
         {
            if(this._squadID > 0)
            {
               this.squadIcon.show(this._isOwnSquad,this._squadID);
            }
         }
         else
         {
            this.playerName.x = this.selfBg.x + PLAYER_NAME_OFFSET | 0;
            this.playerName.width = PLAYER_NAME_WIDTH + SQUAD_WIDTH - this.playerName.x;
         }
      }
      
      private function setSuffixBadge() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._suffixBadgeIcon);
         this.testerIcon.visible = this.testerBG.visible = _loc1_;
         if(_loc1_)
         {
            this.testerIcon.source = this._suffixBadgeIcon;
            this.testerBG.source = this._suffixBadgeStripIcon;
            this.testerIcon.x = this.playerName.x + this.playerName.textWidth + BADGE_GAP >> 0;
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
         this.setSuffixBadge();
      }
   }
}
