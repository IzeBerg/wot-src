package net.wg.gui.battle.comp7.stats.components.playersPanel.list
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.comp7.stats.PoiContainer;
   import net.wg.gui.battle.comp7.stats.components.playersPanel.interfaces.IComp7PlayersPanelListItem;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.stats.playersPanel.events.ChatCommandItemEvent;
   import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
   import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class Comp7PlayersPanelListItem extends BasePlayersPanelListItem implements IComp7PlayersPanelListItem
   {
      
      private static const POI_X_SMALL:int = 80;
      
      private static const POI_X_BIG:int = 103;
      
      private static const POI_Y:int = 14;
      
      private static const RANK_ICON_WIDTH:int = 22;
      
      private static const RANK_ICON_OFFSET:int = 3;
      
      private static const DOG_TAG_WIDTH:int = 22;
      
      private static const DOG_TAG_OFFSET:int = -3;
      
      private static const SQUAD_ICON_WIDTH:int = 22;
      
      private static const SQUAD_ICON_OFFSET:int = 5;
      
      private static const POI_X_ANIM_DURATION:uint = 300;
      
      private static const NOSOUND_ICON_SQUAD_Y_OFFSET:int = 4;
       
      
      public var rankIcon:BattleAtlasSprite = null;
      
      public var squadIcon:BattleAtlasSprite = null;
      
      public var noSoundIcon:BattleAtlasSprite = null;
      
      private var _isLeftAligned:Boolean = true;
      
      private var _poi:PoiContainer = null;
      
      private var _rank:String = null;
      
      private var _rankDivision:String = null;
      
      private var _isQualification:Boolean = false;
      
      private var _isSquadPersonal:Boolean = false;
      
      private var _squadIndex:int = 0;
      
      private var _poiXTween:Tween = null;
      
      private var _hasActiveCommand:Boolean = false;
      
      private var _voiceChatConnected:Boolean = true;
      
      private var _noSoundIconOriginalY:int = -1;
      
      private var _noSoundIconSquadY:int = -1;
      
      private var _isSuperSquad:Boolean = false;
      
      public function Comp7PlayersPanelListItem()
      {
         super();
         maxPlayerNameWidth = WIDTH - ICONS_AREA_WIDTH - vehicleTF.width - fragsTF.width - RANK_ICON_WIDTH - SQUAD_ICON_WIDTH;
      }
      
      override public function isSquadPersonal() : Boolean
      {
         return this._isSquadPersonal;
      }
      
      override public function setChatCommandVisibility(param1:Boolean) : void
      {
         super.setChatCommandVisibility(param1);
         this.updatePoiPosition();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.noSoundIcon.visible = false;
         this._noSoundIconOriginalY = this.noSoundIcon.y;
         this._noSoundIconSquadY = this._noSoundIconOriginalY + NOSOUND_ICON_SQUAD_Y_OFFSET;
         this._poi = new PoiContainer();
         addChild(this._poi);
         this._poi.y = POI_Y;
         this.rankIcon.mouseEnabled = this.rankIcon.mouseChildren = false;
         chatCommandState.addEventListener(ChatCommandItemEvent.ACTIVE_COMMAND_CHANGED,this.onActiveCommandChangedHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Function = null;
         var _loc4_:Boolean = false;
         super.draw();
         if(isInvalid(PlayersPanelInvalidationType.RANK_CHANGED))
         {
            _loc1_ = StringUtils.isNotEmpty(this._rank) && StringUtils.isNotEmpty(this._rankDivision);
            this.rankIcon.visible = _loc1_ || this._isQualification;
            if(_loc1_)
            {
               this.rankIcon.imageName = BATTLEATLAS.getRankIcon(this._rank,this._rankDivision);
            }
            else if(this._isQualification)
            {
               this.rankIcon.imageName = BATTLEATLAS.QUALIFICATION_22X22;
            }
         }
         if(isInvalid(SquadInvalidationType.SQUAD_INDEX))
         {
            _loc2_ = (this._squadIndex > 0 || this._isSuperSquad) && !dogTag.visible;
            this.updateSquadIconVisibility(_loc2_);
            if(_loc2_)
            {
               if(this._isSuperSquad)
               {
                  this.squadIcon.imageName = !!this._isSquadPersonal ? BATTLEATLAS.SUPER_SQUAD_GOLD : BATTLEATLAS.SUPER_SQUAD_SILVER;
               }
               else
               {
                  _loc3_ = !!this._isSquadPersonal ? BATTLEATLAS.squad_gold : BATTLEATLAS.squad_silver;
                  this.squadIcon.imageName = _loc3_(this._squadIndex.toString());
               }
            }
         }
         if(isInvalid(PlayersPanelInvalidationType.VOICE_CHAT_STATUS_CHANGED))
         {
            _loc4_ = state > PLAYERS_PANEL_STATE.HIDDEN && !this._voiceChatConnected;
            if(_loc4_)
            {
               this.noSoundIcon.imageName = BATTLEATLAS.ICON_NO_SOUND;
               this.updateNoSoundIconY();
            }
            this.noSoundIcon.visible = _loc4_;
         }
      }
      
      override protected function initializeRightAligned(param1:Boolean) : void
      {
         this._isLeftAligned = !param1;
         invalidateState();
      }
      
      override protected function updateDogTag() : void
      {
         dogTag.visible = true;
         this.updateSquadIconVisibility(false);
      }
      
      override protected function onDispose() : void
      {
         chatCommandState.removeEventListener(ChatCommandItemEvent.ACTIVE_COMMAND_CHANGED,this.onActiveCommandChangedHandler);
         if(this._poi)
         {
            this._poi.dispose();
            this._poi = null;
         }
         this.rankIcon = null;
         this.squadIcon = null;
         this.noSoundIcon = null;
         this.cleanPoiXTween();
         super.onDispose();
      }
      
      override protected function updatePositionsRight() : void
      {
         super.updatePositionsRight();
         x = -(fragsTF.x + fragsTF.width + RANK_ICON_WIDTH + DOG_TAG_WIDTH ^ 0);
         this.rankIcon.x = fragsTF.x + fragsTF.width - RANK_ICON_OFFSET ^ 0;
         dogTag.x = this.rankIcon.x + RANK_ICON_WIDTH + DOG_TAG_OFFSET;
         this.noSoundIcon.x = this.squadIcon.x = this.rankIcon.x + SQUAD_ICON_WIDTH + SQUAD_ICON_OFFSET;
      }
      
      override protected function updatePositionsLeft() : void
      {
         super.updatePositionsLeft();
         x = -(fragsTF.x - RANK_ICON_WIDTH - DOG_TAG_WIDTH ^ 0);
         this.rankIcon.x = fragsTF.x - RANK_ICON_WIDTH + RANK_ICON_OFFSET ^ 0;
         this.noSoundIcon.x = this.squadIcon.x = this.rankIcon.x - SQUAD_ICON_WIDTH;
         this.updatePoiPosition(false);
      }
      
      public function removePointOfInterest(param1:uint) : void
      {
         if(this._poi)
         {
            this._poi.removePointOfInterest(param1);
         }
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
         invalidate(PlayersPanelInvalidationType.RANK_CHANGED);
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
      
      public function setSquad(param1:Boolean, param2:int) : void
      {
         if(this._isSquadPersonal == param1 && this._squadIndex == param2)
         {
            return;
         }
         this._isSquadPersonal = param1;
         this._squadIndex = param2;
         invalidate(SquadInvalidationType.SQUAD_INDEX);
         invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
         invalidate(PlayersPanelInvalidationType.VOICE_CHAT_STATUS_CHANGED);
      }
      
      public function setVoiceChatConnected(param1:Boolean) : void
      {
         if(this._voiceChatConnected == param1)
         {
            return;
         }
         this._voiceChatConnected = param1;
         invalidate(PlayersPanelInvalidationType.VOICE_CHAT_STATUS_CHANGED);
      }
      
      public function updatePointOfInterest(param1:uint, param2:Number) : void
      {
         if(this._isLeftAligned && this._poi)
         {
            this._poi.updatePointOfInterest(param1,param2);
         }
      }
      
      private function updateNoSoundIconY() : void
      {
         this.noSoundIcon.y = !!this.squadIcon.visible ? Number(this._noSoundIconSquadY) : Number(this._noSoundIconOriginalY);
      }
      
      private function updateSquadIconVisibility(param1:Boolean) : void
      {
         this.squadIcon.visible = param1;
         this.updateNoSoundIconY();
      }
      
      private function updatePoiPosition(param1:Boolean = true) : void
      {
         if(!this._isLeftAligned || !this._poi)
         {
            return;
         }
         var _loc2_:int = (this._hasActiveCommand && chatCommandState.visible ? POI_X_BIG : POI_X_SMALL) + vehicleIcon.x;
         if(param1)
         {
            this.cleanPoiXTween();
            this._poiXTween = new Tween(POI_X_ANIM_DURATION,this._poi,{"x":_loc2_});
         }
         else
         {
            this._poi.x = _loc2_;
         }
      }
      
      private function cleanPoiXTween() : void
      {
         if(this._poiXTween)
         {
            this._poiXTween.dispose();
            this._poiXTween = null;
         }
      }
      
      private function onActiveCommandChangedHandler(param1:ChatCommandItemEvent) : void
      {
         this._hasActiveCommand = param1.isActiveCommandVisible;
         if(chatCommandState.visible)
         {
            this.updatePoiPosition();
         }
      }
   }
}
