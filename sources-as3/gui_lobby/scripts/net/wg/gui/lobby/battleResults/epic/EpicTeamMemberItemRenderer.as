package net.wg.gui.lobby.battleResults.epic
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.ArenaBonusTypes;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.components.icons.SquadIcon;
   import net.wg.gui.lobby.battleResults.components.EfficiencyIconRenderer;
   import net.wg.gui.lobby.battleResults.components.TeamMemberRendererBase;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EpicTeamMemberItemRenderer extends TeamMemberRendererBase
   {
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const OVER_STATE:String = "over";
      
      private static const OUT_STATE:String = "out";
      
      private static const ZERO:String = "0";
      
      private static const NEW_LINE:String = "\n";
      
      private static const BADGE_OFFSET:int = 23;
      
      private static const PLAYER_NAME_WIDTH:int = 107;
       
      
      public var testerIcon:UILoaderAlt = null;
      
      public var testerBG:UILoaderAlt = null;
      
      public var clickArea:MovieClip = null;
      
      public var playerName:UserNameField = null;
      
      public var medalIcon:EfficiencyIconRenderer = null;
      
      public var squadIcon:SquadIcon = null;
      
      public var rankIcon:UILoaderAlt = null;
      
      public var xpLbl:TextField = null;
      
      public var fragsLbl:TextField = null;
      
      public var damageLbl:TextField = null;
      
      public var deathsLbl:TextField = null;
      
      public var selfBg:MovieClip = null;
      
      public var deadBg:Sprite = null;
      
      public var xpIcon:Sprite = null;
      
      public var fakeFocusIndicator:MovieClip = null;
      
      private var _suffixBadgeIcon:String = "";
      
      private var _suffixBadgeStripIcon:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      private var _locale:ILocale;
      
      private const RANK_IMAGE_LIST:Vector.<String> = new <String>[RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_RECRUIT,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_PRIVATE,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_SERGEANT,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_LIEUTENANT,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_CAPTAIN,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_MAJOR,RES_ICONS.MAPS_ICONS_LIBRARY_EPICRANK_LIST_RANK_GENERAL];
      
      public function EpicTeamMemberItemRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._colorSchemeMgr = App.colorSchemeMgr;
         this._locale = App.utils.locale;
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
         this.testerIcon.visible = false;
         this.testerBG.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.playerName.removeEventListener(Event.CHANGE,this.onPlayerNameChangeHandler);
         this.medalIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onMedalIconRollOverHandler);
         this.medalIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onMedalIconRollOutHandler);
         this.medalIcon.removeEventListener(MouseEvent.CLICK,this.onMedalIconClickHandler);
         this.medalIcon.dispose();
         this.medalIcon = null;
         this.testerIcon.dispose();
         this.testerIcon = null;
         this.testerBG.dispose();
         this.testerBG = null;
         this.playerName.dispose();
         this.playerName = null;
         this.squadIcon.dispose();
         this.squadIcon = null;
         this.rankIcon.dispose();
         this.rankIcon = null;
         this.selfBg = null;
         this.deadBg = null;
         this.damageLbl = null;
         this.fragsLbl = null;
         this.xpLbl = null;
         this.deathsLbl = null;
         this.xpIcon = null;
         this.fakeFocusIndicator = null;
         this.clickArea = null;
         this._toolTipMgr = null;
         this._colorSchemeMgr = null;
         super.onDispose();
      }
      
      override protected function showData(param1:TeamMemberItemVO) : void
      {
         this.playerName.width = PLAYER_NAME_WIDTH;
         this.selfBg.visible = param1.isSelf;
         this._suffixBadgeIcon = param1.suffixBadgeIcon;
         this._suffixBadgeStripIcon = param1.suffixBadgeStripIcon;
         this.squadIcon.hide();
         this.medalIcon.visible = false;
         var _loc2_:IColorScheme = null;
         if(param1.isOwnSquad)
         {
            _loc2_ = this._colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.SELECTED_DEAD : ColorSchemeNames.SELECTED);
         }
         else
         {
            _loc2_ = this._colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.NORMAL_DEAD : ColorSchemeNames.NORMAL);
         }
         var _loc3_:Boolean = UserTags.isCurrentPlayer(param1.userVO.tags);
         this.playerName.userVO = param1.userVO;
         this.playerName.useFakeName = !(_loc3_ || param1.isOwnSquad);
         this.playerName.showAnonymizerIcon = _loc3_;
         this.playerName.textColor = _loc2_.rgb;
         if(StringUtils.isNotEmpty(this._suffixBadgeIcon))
         {
            this.playerName.width -= BADGE_OFFSET;
         }
         this.xpLbl.text = this._locale.integer(param1.xp - param1.achievementXP);
         this.rankIcon.source = this.RANK_IMAGE_LIST[param1.playerRank];
         this.fragsLbl.visible = param1.kills > 0;
         if(this.fragsLbl.visible)
         {
            this.fragsLbl.text = param1.kills.toString();
         }
         this.damageLbl.text = ZERO;
         if(param1.damageDealt > 0)
         {
            this.damageLbl.text = this._locale.integer(param1.damageDealt);
         }
         if(param1.squadID > 0 && bonusType != ArenaBonusTypes.CYBERSPORT)
         {
            this.squadIcon.show(param1.isOwnSquad,param1.squadID);
         }
         this.xpLbl.text = this._locale.integer(param1.xp - param1.achievementXP);
         this.deathsLbl.htmlText = this._locale.integer(param1.respawns);
         this.deadBg.visible = param1.rollOuts - param1.deaths > 0;
         if(param1.medalsCount > 0)
         {
            this.medalIcon.value = param1.medalsCount;
            this.medalIcon.validateNow();
            this.medalIcon.visible = true;
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
            this.testerIcon.x = this.playerName.x + this.playerName.textWidth + FIELD_WIDTH_COMPENSATION >> 0;
            this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.fakeFocusIndicator.gotoAndPlay(OVER_STATE);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.fakeFocusIndicator.gotoAndPlay(OUT_STATE);
      }
      
      private function onPlayerNameChangeHandler(param1:Event) : void
      {
         this.setSuffixBadge();
      }
      
      private function onMedalIconRollOverHandler(param1:MouseEvent) : void
      {
         var _loc4_:Vector.<String> = null;
         var _loc5_:uint = 0;
         var _loc2_:Array = data.achievements;
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
            this._toolTipMgr.show(_loc4_.join(NEW_LINE));
         }
      }
      
      private function onMedalIconRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onMedalIconClickHandler(param1:MouseEvent) : void
      {
         handleMouseRelease(param1);
      }
   }
}
