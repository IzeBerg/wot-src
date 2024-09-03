package net.wg.gui.battle.comp7.stats.fullStats.tableItem
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IFullStatsPoiHolder;
   import net.wg.gui.battle.comp7.stats.PoiContainer;
   import net.wg.gui.battle.comp7.stats.components.RoleSkillLevel;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemCommon;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class StatsTableItem extends StatsTableItemCommon implements IFullStatsPoiHolder
   {
      
      private static const NUM_ROWS:int = 7;
      
      private static const POI_OFFSET_X:int = 80;
      
      private static const POI_OFFSET_Y:int = 13;
      
      private static const ROLE_SKILL_LEVEL_DEAD_ALPHA:Number = 0.25;
      
      private static const RANK_DEAD_ALPHA:Number = 0.5;
      
      private static const NOSOUND_ICON_SQUAD_Y_OFFSET:int = 4;
      
      private static const POI_CONTAINER_NAME:String = "poiContainer";
       
      
      private var _noSoundIcon:BattleAtlasSprite = null;
      
      private var _pois:PoiContainer = null;
      
      private var _rankIcon:BattleAtlasSprite = null;
      
      private var _squadIcon:BattleAtlasSprite = null;
      
      private var _rank:String = null;
      
      private var _rankDivision:String = null;
      
      private var _isQualification:Boolean = false;
      
      private var _roleSkillLevel:RoleSkillLevel = null;
      
      private var _squadIndex:int = 0;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _voiceChatConnected:Boolean = true;
      
      private var _isSuperSquad:Boolean = false;
      
      private var _noSoundIconOriginalY:int = -1;
      
      private var _noSoundIconSquadY:int = -1;
      
      public function StatsTableItem(param1:MovieClip, param2:int, param3:int)
      {
         var _loc4_:int = 0;
         this._tooltipMgr = App.toolTipMgr;
         super(param1,param2,param3);
         _loc4_ = param2 * this.numRows + param3;
         this._rankIcon = param1.rankIconsCollection[_loc4_];
         this._roleSkillLevel = param1.roleSkillLevelCollection[_loc4_];
         this._roleSkillLevel.visible = false;
         this._roleSkillLevel.addEventListener(MouseEvent.ROLL_OVER,this.onRoleSkillLevelRollOverHandler);
         this._roleSkillLevel.addEventListener(MouseEvent.ROLL_OUT,this.onRoleSkillLevelRollOutHandler);
         this._squadIcon = param1.squadIconCollection[_loc4_];
         if(param2 == 0)
         {
            this._noSoundIcon = param1.noSoundIconCollection[_loc4_];
            this._noSoundIconOriginalY = this._noSoundIcon.y;
            this._noSoundIconSquadY = this._noSoundIconOriginalY + NOSOUND_ICON_SQUAD_Y_OFFSET;
         }
         var _loc5_:Boolean = param2 != 1;
         if(_loc5_)
         {
            this._pois = new PoiContainer();
            this._pois.name = POI_CONTAINER_NAME;
            param1.addChild(this._pois);
            this._pois.x = vehicleIcon.x + vehicleIcon.width + POI_OFFSET_X >> 0;
            this._pois.y = vehicleIcon.y + POI_OFFSET_Y >> 0;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Function = null;
         var _loc4_:Boolean = false;
         super.draw();
         if(isInvalid(FullStatsValidationType.COLORS))
         {
            this._roleSkillLevel.alpha = !!isDead ? Number(ROLE_SKILL_LEVEL_DEAD_ALPHA) : Number(1);
            if(isDead)
            {
               this._roleSkillLevel.setSkillLevel(0);
            }
            this._rankIcon.alpha = !!isDead ? Number(RANK_DEAD_ALPHA) : Number(1);
         }
         if(isInvalid(FullStatsValidationType.RANK))
         {
            _loc1_ = StringUtils.isNotEmpty(this._rank) && StringUtils.isNotEmpty(this._rankDivision);
            this._rankIcon.visible = _loc1_ || this._isQualification;
            if(_loc1_)
            {
               this._rankIcon.imageName = BATTLEATLAS.getRankIcon(this._rank,this._rankDivision);
            }
            else if(this._isQualification)
            {
               this._rankIcon.imageName = BATTLEATLAS.QUALIFICATION_22X22;
            }
         }
         if(isInvalid(SquadInvalidationType.SQUAD_INDEX))
         {
            _loc2_ = this._squadIndex > 0 || this._isSuperSquad;
            this._squadIcon.visible = _loc2_;
            if(_loc2_)
            {
               if(this._isSuperSquad)
               {
                  this._squadIcon.imageName = !!isSquadPersonal ? BATTLEATLAS.SUPER_SQUAD_GOLD : BATTLEATLAS.SUPER_SQUAD_SILVER;
               }
               else
               {
                  _loc3_ = !!isSquadPersonal ? BATTLEATLAS.squad_gold : BATTLEATLAS.squad_silver;
                  this._squadIcon.imageName = _loc3_(this._squadIndex.toString());
               }
            }
            this.updateNoSoundIconY();
         }
         if(isInvalid(FullStatsValidationType.VOICE_CHAT_STATUS_CHANGED))
         {
            if(this._noSoundIcon)
            {
               _loc4_ = userProps && !this._voiceChatConnected;
               if(_loc4_)
               {
                  this._noSoundIcon.imageName = BATTLEATLAS.ICON_NO_SOUND;
                  this.updateNoSoundIconY();
               }
               this._noSoundIcon.visible = _loc4_;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._pois)
         {
            this._pois.parent.removeChild(this._pois);
            this._pois.dispose();
            this._pois = null;
         }
         this._roleSkillLevel.removeEventListener(MouseEvent.ROLL_OVER,this.onRoleSkillLevelRollOverHandler);
         this._roleSkillLevel.removeEventListener(MouseEvent.ROLL_OUT,this.onRoleSkillLevelRollOutHandler);
         this._roleSkillLevel = null;
         this._rankIcon = null;
         this._squadIcon = null;
         this._tooltipMgr = null;
         this._noSoundIcon = null;
         super.onDispose();
      }
      
      public function removeAllPOI() : void
      {
         if(this._pois)
         {
            this._pois.removeAllPOI();
         }
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         if(this._pois)
         {
            this._pois.removePointOfInterest(param2);
         }
      }
      
      public function setIsEnemy(param1:Boolean) : void
      {
         this._roleSkillLevel.setIsDisabled(param1);
      }
      
      public function setRank(param1:String, param2:String, param3:Boolean) : void
      {
         if(this._rank == param1 && this._rankDivision == param2 && this._isQualification == param3)
         {
            return;
         }
         this._rank = param1;
         this._rankDivision = param2;
         this._isQualification = param3;
         invalidate(FullStatsValidationType.RANK);
      }
      
      public function setRole(param1:String) : void
      {
         this._roleSkillLevel.setRole(param1);
         this._roleSkillLevel.visible = StringUtils.isNotEmpty(param1);
      }
      
      public function setSkillLevel(param1:uint) : void
      {
         this._roleSkillLevel.setSkillLevel(param1);
      }
      
      public function setSquadIndex(param1:int) : void
      {
         if(this._squadIndex == param1)
         {
            return;
         }
         this._squadIndex = param1;
         invalidate(SquadInvalidationType.SQUAD_INDEX);
      }
      
      public function set isSuperSquad(param1:Boolean) : void
      {
         if(param1 == this._isSuperSquad)
         {
            return;
         }
         this._isSuperSquad = param1;
         invalidate(SquadInvalidationType.SQUAD_INDEX);
      }
      
      public function setVoiceChatConnected(param1:Boolean) : void
      {
         if(this._voiceChatConnected != param1)
         {
            this._voiceChatConnected = param1;
            invalidate(FullStatsValidationType.VOICE_CHAT_STATUS_CHANGED);
         }
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void
      {
         if(this._pois)
         {
            this._pois.updatePointOfInterest(param1.type,param1.progress,param2);
         }
      }
      
      private function updateNoSoundIconY() : void
      {
         if(this._noSoundIcon)
         {
            this._noSoundIcon.y = !!this._squadIcon.visible ? Number(this._noSoundIconSquadY) : Number(this._noSoundIconOriginalY);
         }
      }
      
      override protected function get numRows() : uint
      {
         return NUM_ROWS;
      }
      
      private function onRoleSkillLevelRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.COMP7_ROLE_SKILL_BATTLE_TOOLTIP,null,this._roleSkillLevel.getRole());
      }
      
      private function onRoleSkillLevelRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
