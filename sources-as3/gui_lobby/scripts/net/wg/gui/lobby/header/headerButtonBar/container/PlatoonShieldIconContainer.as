package net.wg.gui.lobby.header.headerButtonBar.container
{
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.header.headerButtonBar.HBC_Squad;
   import net.wg.gui.lobby.header.vo.ExtendedSquadInfoVo;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PlatoonShieldIconContainer extends UIComponentEx
   {
      
      public static const STATES:Object = {
         "create":"CREATE",
         "searching":"SEARCHING",
         "inPlatoon":"IN_PLATOON",
         "squadEvent":"SQUAD_EVENT"
      };
      
      public static const SHIELDS:Object = {
         "create":"create",
         "disabled":"disabled",
         "empty":"empty",
         "event":"event",
         "inBattle":"inBattle",
         "notReady":"notReady",
         "notReadyPlayer":"notReadyPlayer",
         "ready":"ready",
         "searching":"searching"
      };
      
      public static const PLAYERS:Object = {
         "left":0,
         "current":1,
         "right":2
      };
       
      
      public var commanderIcon:UILoaderAlt = null;
      
      public var createStateShieldIcon:UILoaderAlt = null;
      
      public var spinner:InviteIndicator = null;
      
      public var shieldsIcon:MovieClip = null;
      
      public var shieldsIconAnimation:MovieClip = null;
      
      public var rightBGShieldsIcon:MovieClip = null;
      
      public var rightBGShieldsIconAnimation:MovieClip = null;
      
      public var leftBGShieldsIcon:MovieClip = null;
      
      public var leftBGShieldsIconAnimation:MovieClip = null;
      
      private var _currentState:String = "";
      
      private var _squadManArray:Array = null;
      
      private var _commanderIndex:int = 0;
      
      private var _platoonState:String = "";
      
      private var _isNormalSizePlatoon:Boolean = true;
      
      private var _iconContainerIndex:int = -1;
      
      private var _playAnimation:Boolean = false;
      
      private var _isMain:Boolean = false;
      
      private var _hasMembers:Boolean = false;
      
      private var _isWideScreen:Boolean = false;
      
      private var _isCommanderHatVisibleForThisContainer:Boolean = false;
      
      public function PlatoonShieldIconContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.commanderIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMMANDERICON;
         this.commanderIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.commanderIcon.visible = false;
         this.createStateShieldIcon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
         this.createStateShieldIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.createStateShieldIcon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.commanderIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.commanderIcon.dispose();
         this.commanderIcon = null;
         this.createStateShieldIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.createStateShieldIcon.dispose();
         this.createStateShieldIcon = null;
         this.spinner.dispose();
         this.spinner = null;
         this.shieldsIcon = null;
         this.shieldsIconAnimation.stop();
         this.shieldsIconAnimation = null;
         this.rightBGShieldsIcon = null;
         this.rightBGShieldsIconAnimation.stop();
         this.rightBGShieldsIconAnimation = null;
         this.leftBGShieldsIcon = null;
         this.leftBGShieldsIconAnimation.stop();
         this.leftBGShieldsIconAnimation = null;
         if(this._squadManArray)
         {
            this._squadManArray.splice(0,this._squadManArray.length);
            this._squadManArray = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.setEventIconVisibility(this._platoonState);
            this.commanderIcon.visible = this._isCommanderHatVisibleForThisContainer;
            if(this._hasMembers)
            {
               if(this.spinner != null)
               {
                  this.spinner.visible = this._squadManArray[this._iconContainerIndex] == SHIELDS.searching;
               }
               this.setIconData(this._squadManArray[this._iconContainerIndex]);
               if(this._squadManArray.length == HBC_Squad.SHORT_SIZE_PLATOON)
               {
                  this.rightBGShieldsIcon.visible = false;
                  this.leftBGShieldsIcon.visible = this._isMain && !this._isWideScreen;
                  this.setLeftPlayerData(this._squadManArray[PLAYERS.current]);
               }
               else
               {
                  this.leftBGShieldsIcon.visible = this.rightBGShieldsIcon.visible = this._isMain && !this._isWideScreen;
                  this.setLeftPlayerData(this._squadManArray[PLAYERS.left]);
                  this.setRightPlayerData(this._squadManArray[PLAYERS.right]);
               }
            }
            else
            {
               this.spinner.visible = false;
               this.leftBGShieldsIcon.visible = this.rightBGShieldsIcon.visible = false;
            }
            if(this._playAnimation && enabled)
            {
               this.playAnimations();
               this._playAnimation = false;
            }
         }
      }
      
      public function getIconSize(param1:String) : int
      {
         if(!visible)
         {
            return 0;
         }
         var _loc2_:int = 0;
         switch(param1)
         {
            case STATES.create:
            case STATES.squadEvent:
               _loc2_ = this.createStateShieldIcon.width;
               break;
            case STATES.searching:
            case STATES.inPlatoon:
               _loc2_ = this.shieldsIcon.width;
         }
         return _loc2_;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function isCommanderHatVisible(param1:Boolean) : void
      {
         this._isCommanderHatVisibleForThisContainer = param1 && this._commanderIndex == this._iconContainerIndex && this._platoonState;
      }
      
      public function playAnimations() : void
      {
         this.shieldsIconAnimation.play();
         this.rightBGShieldsIconAnimation.play();
         this.leftBGShieldsIconAnimation.play();
      }
      
      public function setEventIcon(param1:String) : void
      {
         this.createStateShieldIcon.source = param1;
      }
      
      public function updateIconContainer(param1:ExtendedSquadInfoVo, param2:int) : void
      {
         if(this._commanderIndex != param1.commanderIndex || this._platoonState != param1.platoonState || this._squadManArray != param1.squadManStates)
         {
            this._playAnimation = true;
         }
         this._commanderIndex = param1.commanderIndex;
         this._platoonState = param1.platoonState;
         this._isNormalSizePlatoon = param1.squadManStates.length && param1.squadManStates.length <= HBC_Squad.NORMAL_SIZE_PLATOON;
         this._squadManArray = param1.squadManStates.concat();
         this._iconContainerIndex = param2;
         this._hasMembers = this._squadManArray != null && this._squadManArray.length > 0;
         invalidateData();
      }
      
      public function updateSizeScreen(param1:Boolean) : void
      {
         this._isWideScreen = param1;
         invalidateData();
      }
      
      private function setEventIconVisibility(param1:String) : void
      {
         this.createStateShieldIcon.visible = param1 == STATES.create || param1 == STATES.inPlatoon && !this._isNormalSizePlatoon;
         this.shieldsIcon.visible = !this.createStateShieldIcon.visible;
      }
      
      private function setIconData(param1:String) : void
      {
         if(this._currentState == param1)
         {
            return;
         }
         if(this.shieldsIcon != null)
         {
            this._currentState = param1;
            this.shieldsIcon.gotoAndStop(param1);
         }
      }
      
      private function setRightPlayerData(param1:String) : void
      {
         this.rightBGShieldsIcon.gotoAndStop(param1);
      }
      
      private function setLeftPlayerData(param1:String) : void
      {
         this.leftBGShieldsIcon.gotoAndStop(param1);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(!param1)
         {
            this.shieldsIconAnimation.gotoAndStop(0);
            this.rightBGShieldsIconAnimation.gotoAndStop(0);
            this.leftBGShieldsIconAnimation.gotoAndStop(0);
         }
      }
      
      public function set isMain(param1:Boolean) : void
      {
         this._isMain = param1;
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         dispatchEvent(new UILoaderEvent(UILoaderEvent.COMPLETE));
      }
   }
}
