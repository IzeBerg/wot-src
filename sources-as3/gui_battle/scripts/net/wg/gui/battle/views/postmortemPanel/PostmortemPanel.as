package net.wg.gui.battle.views.postmortemPanel
{
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.components.dogtag.DogTagEvent;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.components.dogtag.ImageRepository;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PostmortemPanelMeta;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class PostmortemPanel extends PostmortemPanelMeta implements IPostmortemPanelMeta
   {
      
      private static const FADE_ANIMATION_TIME:int = 200;
      
      private static const PANEL_ANIMATION_DELAY:int = 500;
      
      private static const DOGTAG_VICTIM_MINI_MAP_OFFSET:int = -760;
      
      private static const DOGTAG_KILLER_OFFSET_Y:int = 70;
      
      private static const DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME:int = 300;
      
      private static const VICTIM_DOGTAG_LINGERING_TIME:int = 1700;
      
      private static const DEAD_REASON_ALPHA:Number = 0.5;
      
      private static const DELAY_DT_KILLER_APPEARANCE:int = 1000;
      
      private static const DELAY_DT_VICTIM_APPEARANCE:int = 600;
      
      protected static const INVALID_HIDE_COMPONENTS:uint = 1 << 15;
      
      private static const POSTMORTEM_DC_BOTTOM_OFFSET_PERCENT_SMALL:Number = 0.79;
      
      private static const POSTMORTEM_DC_BOTTOM_OFFSET_PERCENT_BIG:Number = 0.73;
      
      private static const POSTMORTEM_DC_ANIMATION_TIME:int = 550;
      
      private static const POSTMORTEM_INFO_PANEL_HEIGHT_MULTIPLIER:Number = 0.25;
      
      private static const POSTMORTEM_INFO_PANEL_WIDTH_MULTIPLIER:Number = 0.5;
      
      private static const POST_MORTEM_INFO_NAME:String = "postmortemInfoPanel";
      
      private static const DOG_TAG_KILLER_NAME:String = "dogTagKiller";
       
      
      public var postmortemInfoPanel:PostmortemInfoPanel = null;
      
      private var _dogTagVictim:DogtagComponent = null;
      
      private var _dogTagKiller:DogtagComponent = null;
      
      private var _vehPanelFadeInTween:Tween = null;
      
      private var _deadReasonTween:Tween = null;
      
      private var _userNameTextFieldFadeInTween:Tween = null;
      
      private var _dogTagAppearanceDelayTween:Tween = null;
      
      private var _nicknameKillerBGTween:Tween = null;
      
      private var _victimDogTagTweenIn:Tween = null;
      
      private var _victimDogTagTweenOut:Tween = null;
      
      private var _postmortemDCTweenUp:Tween = null;
      
      private var _postmortemTween:Tween = null;
      
      private var _dogTagVictimMiniMapAnchor:int;
      
      private var _colorSchemeMgr:IColorSchemeManager;
      
      private var _isEnabledPostmortemPanel:Boolean = true;
      
      private var _isReplay:Boolean = false;
      
      private var _isInDeathCam:Boolean = false;
      
      private var _postmortemInfoPanelBaseYPosition:int;
      
      private var _dogTagComponentAnimateShowEndHandler:Function = null;
      
      public function PostmortemPanel()
      {
         this._colorSchemeMgr = App.colorSchemeMgr;
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function setPlayerInfo(param1:String) : void
      {
         super.setPlayerInfo(param1);
         if(this._dogTagKiller)
         {
            this._dogTagKiller.visible = false;
         }
      }
      
      override protected function invalidateDeadReasonItems(param1:Boolean, param2:uint = 0) : void
      {
         super.invalidateDeadReasonItems(param1,param2);
         if(this._dogTagKiller)
         {
            this._dogTagKiller.visible = param1;
         }
         if(param1)
         {
            this.showPostmortemInfoPanel(param1);
         }
      }
      
      override protected function configUI() : void
      {
         this.updateKillerBackground();
         this.createPostmortemPanelElements();
         this.showPostmortemInfoPanel(false);
         TextFieldEx.setVerticalAutoSize(deadReasonTF,TextFieldEx.VALIGN_BOTTOM);
         setComponentsVisibility(false);
         this.updatePlayerInfoPosition();
         this.initDogTagVictim();
         this._colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         super.configUI();
      }
      
      override protected function updatePlayerInfoPosition() : void
      {
         super.updatePlayerInfoPosition();
         if(this._dogTagKiller)
         {
            this._dogTagKiller.y = deadReasonTF.y - this._dogTagKiller.height - DOGTAG_KILLER_OFFSET_Y;
            nicknameKillerBG.x = -nicknameKillerBG.width >> 1;
            nicknameKillerBG.y = _userName.y;
         }
         if(this._isInDeathCam)
         {
            this.movePostmortemInfoUp();
         }
      }
      
      override protected function showKillerDogTag(param1:DogTagVO, param2:Boolean) : void
      {
         if(!this._dogTagKiller)
         {
            this.initDogTagKiller(param2);
         }
         this._dogTagKiller.setDogTagInfo(param1);
      }
      
      override protected function showVictimDogTag(param1:DogTagVO) : void
      {
         this.visible = true;
         this._dogTagVictim.setDogTagInfo(param1);
         onVictimDogTagInPlaySoundS();
         this.animateVictimDogTag();
      }
      
      override protected function preloadComponents(param1:Array) : void
      {
         ImageRepository.getInstance().setImages(param1);
      }
      
      override protected function canShowKillerBg() : Boolean
      {
         return isShowVehiclePanel();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.postmortemInfoPanel)
         {
            if(this.postmortemInfoPanel.width != this.parent.width)
            {
               this.postmortemInfoPanel.width = this.parent.width;
               this.postmortemInfoPanel.x = -this.postmortemInfoPanel.width * POSTMORTEM_INFO_PANEL_WIDTH_MULTIPLIER | 0;
            }
         }
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            this.showPostmortemInfoPanel(true);
            if(_userName && _userName.userVO && _userName.userVO.userName != Values.EMPTY_STR)
            {
               this.showPanel();
            }
         }
         if(isInvalid(INVALID_HIDE_COMPONENTS))
         {
            this.showPostmortemInfoPanel(false);
            setComponentsVisibility(false);
         }
      }
      
      override protected function onDispose() : void
      {
         this._colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorSchemeMgr = null;
         if(this._dogTagVictim)
         {
            this._dogTagVictim.dispose();
            this._dogTagVictim = null;
         }
         if(this._dogTagKiller)
         {
            this.removeDogTagKillerListeners();
            this._dogTagKiller.dispose();
            this._dogTagKiller = null;
         }
         if(this.postmortemInfoPanel)
         {
            removeChild(this.postmortemInfoPanel);
            this.postmortemInfoPanel = null;
         }
         if(this._dogTagComponentAnimateShowEndHandler != null)
         {
            this._dogTagComponentAnimateShowEndHandler = null;
         }
         this.clearTweens();
         ImageRepository.getInstance().dispose();
         super.onDispose();
      }
      
      public function addPostmortemInfoPanelYOffset(param1:int) : void
      {
         if(this.postmortemInfoPanel == null)
         {
            return;
         }
         this.postmortemInfoPanel.y = this._postmortemInfoPanelBaseYPosition + param1;
      }
      
      public function anchorVictimDogTag(param1:int) : void
      {
         this._dogTagVictimMiniMapAnchor = DOGTAG_VICTIM_MINI_MAP_OFFSET + param1;
         if(this._dogTagVictim)
         {
            this._dogTagVictim.y = this._dogTagVictimMiniMapAnchor;
         }
      }
      
      public function animateVictimDogTag() : void
      {
         this._dogTagVictim.visible = true;
         this._dogTagVictim.alpha = 1;
         this._dogTagVictim.x = App.appWidth >> 1;
         if(this._victimDogTagTweenIn)
         {
            this._victimDogTagTweenIn.paused = true;
         }
         if(this._victimDogTagTweenOut)
         {
            this._victimDogTagTweenOut.paused = true;
         }
         this._victimDogTagTweenIn = new Tween(DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME,this._dogTagVictim,{"x":(App.appWidth >> 1) - this._dogTagVictim.width},{
            "delay":DELAY_DT_VICTIM_APPEARANCE,
            "paused":false,
            "onComplete":this.onVictimDogTagFadeInComplete
         });
      }
      
      public function as_fadePostmortemPanelOut() : void
      {
         if(this._dogTagKiller)
         {
            this._dogTagKiller.animateHide();
         }
         this.hideDeadReason();
      }
      
      public function as_handleAsReplay() : void
      {
         this._isReplay = true;
      }
      
      public function as_hideComponents() : void
      {
         invalidate(INVALID_HIDE_COMPONENTS);
      }
      
      public function as_movePostmortemPanelUp() : void
      {
         this.movePostmortemInfoUp();
      }
      
      public function as_resetPostmortemPosition() : void
      {
         this.y = App.appHeight | 0;
         this.alpha = 1;
      }
      
      public function as_setInDeathCam(param1:Boolean) : void
      {
         this._isInDeathCam = param1;
      }
      
      public function as_setPlayerInfo(param1:String) : void
      {
         this.setPlayerInfo(param1);
      }
      
      public function as_togglePostmortemInfoPanel(param1:Boolean) : void
      {
         if(this.postmortemInfoPanel)
         {
            this.postmortemInfoPanel.visible = param1;
         }
      }
      
      protected function createPostmortemPanelElements() : void
      {
         if(!this.postmortemInfoPanel)
         {
            this.postmortemInfoPanel = new PostmortemInfoPanel();
            this.postmortemInfoPanel.name = POST_MORTEM_INFO_NAME;
            this.postmortemInfoPanel.setManageSize(true);
            this.postmortemInfoPanel.setSize(this.parent.width,this.parent.height * POSTMORTEM_INFO_PANEL_HEIGHT_MULTIPLIER | 0);
            this.postmortemInfoPanel.x = -this.postmortemInfoPanel.width * POSTMORTEM_INFO_PANEL_WIDTH_MULTIPLIER | 0;
            this.postmortemInfoPanel.y = -this.parent.height * POSTMORTEM_INFO_PANEL_HEIGHT_MULTIPLIER | 0;
            this._postmortemInfoPanelBaseYPosition = this.postmortemInfoPanel.y;
            addChild(this.postmortemInfoPanel);
            registerFlashComponentS(this.postmortemInfoPanel,BATTLE_VIEW_ALIASES.POSTMORTEM_INFO_PAGE);
         }
      }
      
      protected function showPostmortemInfoPanel(param1:Boolean) : void
      {
         if(!param1 || !this._isReplay && this._isEnabledPostmortemPanel && param1)
         {
            this.postmortemInfoPanel.visible = param1;
         }
      }
      
      private function movePostmortemInfoUp() : void
      {
         var _loc1_:Boolean = App.appWidth <= StageSizeBoundaries.WIDTH_1920 || App.appHeight <= StageSizeBoundaries.HEIGHT_1080;
         var _loc2_:Number = App.appHeight * (!!_loc1_ ? POSTMORTEM_DC_BOTTOM_OFFSET_PERCENT_SMALL : POSTMORTEM_DC_BOTTOM_OFFSET_PERCENT_BIG);
         var _loc3_:int = _loc2_ | 0;
         this._postmortemDCTweenUp = new Tween(POSTMORTEM_DC_ANIMATION_TIME,this,{"y":_loc3_},{"paused":false});
      }
      
      private function initDogTagKiller(param1:Boolean) : void
      {
         this._dogTagKiller = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         this._dogTagKiller.name = DOG_TAG_KILLER_NAME;
         addChild(this._dogTagKiller);
         this._dogTagKiller.x = -this._dogTagKiller.width >> 1;
         this._dogTagKiller.y = deadReasonTF.y - this._dogTagKiller.height - DOGTAG_KILLER_OFFSET_Y;
         this.addDogTagKillerListeners(param1);
      }
      
      private function addDogTagKillerListeners(param1:Boolean) : void
      {
         if(this._dogTagKiller == null)
         {
            return;
         }
         this._dogTagKiller.addEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START,this.onDogTagAnimateHideStart);
         this._dogTagComponentAnimateShowEndHandler = this.createDogTagAnimateShowEndHandler(param1);
         this._dogTagKiller.addEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_SHOW_END,this._dogTagComponentAnimateShowEndHandler);
      }
      
      private function removeDogTagKillerListeners() : void
      {
         if(this._dogTagKiller == null)
         {
            return;
         }
         if(this._dogTagKiller.hasEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START))
         {
            this._dogTagKiller.removeEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START,this.onDogTagAnimateHideStart);
         }
         if(this._dogTagKiller.hasEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_SHOW_END))
         {
            this._dogTagKiller.removeEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_SHOW_END,this._dogTagComponentAnimateShowEndHandler);
         }
      }
      
      private function initDogTagVictim() : void
      {
         this._dogTagVictim = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         addChild(this._dogTagVictim);
         this._dogTagVictim.x = App.appWidth >> 1;
         this._dogTagVictim.y = this._dogTagVictimMiniMapAnchor;
         this._dogTagVictim.goToLabel(DogtagComponent.DOGTAG_LABEL_END_TOP);
         this._dogTagVictim.visible = false;
         this._dogTagVictim.hideNameAndClan();
      }
      
      private function onVictimDogTagFadeInComplete(param1:Tween) : void
      {
         this._dogTagVictim.animateDogTagUpBlink();
         this._victimDogTagTweenOut = new Tween(DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME,this._dogTagVictim,{
            "alpha":0,
            "x":(App.appWidth >> 1) + this._dogTagVictim.width
         },{
            "delay":VICTIM_DOGTAG_LINGERING_TIME,
            "paused":false
         });
      }
      
      private function showPanel() : void
      {
         vehiclePanel.alpha = 0;
         _userName.alpha = 0;
         nicknameKillerBG.alpha = 0;
         this.deadReasonOpacity = 0;
         this.clearTweens(false);
         this._vehPanelFadeInTween = new Tween(FADE_ANIMATION_TIME,vehiclePanel,{"alpha":1},{
            "delay":PANEL_ANIMATION_DELAY,
            "paused":false
         });
         this._deadReasonTween = new Tween(FADE_ANIMATION_TIME,this,{"deadReasonOpacity":1},{
            "delay":PANEL_ANIMATION_DELAY,
            "paused":false
         });
         this._userNameTextFieldFadeInTween = new Tween(FADE_ANIMATION_TIME,_userName,{"alpha":1},{
            "delay":PANEL_ANIMATION_DELAY,
            "paused":false,
            "onComplete":this.onPanelFadeInAnimationComplete
         });
      }
      
      private function onPanelFadeInAnimationComplete(param1:Tween) : void
      {
         if(this._dogTagKiller)
         {
            this._dogTagAppearanceDelayTween = new Tween(0,this._dogTagKiller,{"visible":true},{
               "delay":DELAY_DT_KILLER_APPEARANCE,
               "paused":false,
               "onComplete":this.onDelayComplete
            });
         }
      }
      
      private function onDelayComplete(param1:Tween) : void
      {
         this._dogTagKiller.animate();
         onDogTagKillerInPlaySoundS();
         this.tweenReasonAndName(true);
      }
      
      private function tweenReasonAndName(param1:Boolean) : void
      {
         this._deadReasonTween = new Tween(FADE_ANIMATION_TIME,this,{"deadReasonOpacity":(!!param1 ? DEAD_REASON_ALPHA : 1)},{
            "delay":PANEL_ANIMATION_DELAY,
            "paused":false
         });
         this._nicknameKillerBGTween = new Tween(FADE_ANIMATION_TIME,nicknameKillerBG,{"alpha":(!!param1 ? 1 : 0)},{"paused":false});
      }
      
      private function hideDeadReason() : void
      {
         this._postmortemTween = new Tween(FADE_ANIMATION_TIME,this,{"alpha":0},{"paused":false});
      }
      
      private function clearTweens(param1:Boolean = true) : void
      {
         if(this._vehPanelFadeInTween)
         {
            this._vehPanelFadeInTween.paused = true;
            this._vehPanelFadeInTween.dispose();
            this._vehPanelFadeInTween = null;
         }
         if(this._userNameTextFieldFadeInTween)
         {
            this._userNameTextFieldFadeInTween.paused = true;
            this._userNameTextFieldFadeInTween.dispose();
            this._userNameTextFieldFadeInTween = null;
         }
         if(this._deadReasonTween)
         {
            this._deadReasonTween.paused = true;
            this._deadReasonTween.dispose();
            this._deadReasonTween = null;
         }
         if(this._nicknameKillerBGTween)
         {
            this._nicknameKillerBGTween.paused = true;
            this._nicknameKillerBGTween.dispose();
            this._nicknameKillerBGTween = null;
         }
         if(this._dogTagAppearanceDelayTween)
         {
            this._dogTagAppearanceDelayTween.paused = true;
            this._dogTagAppearanceDelayTween.dispose();
            this._dogTagAppearanceDelayTween = null;
         }
         if(param1)
         {
            if(this._victimDogTagTweenIn)
            {
               this._victimDogTagTweenIn.paused = true;
               this._victimDogTagTweenIn.dispose();
               this._victimDogTagTweenIn = null;
            }
            if(this._victimDogTagTweenOut)
            {
               this._victimDogTagTweenOut.paused = true;
               this._victimDogTagTweenOut.dispose();
               this._victimDogTagTweenOut = null;
            }
         }
         if(this._postmortemDCTweenUp)
         {
            this._postmortemDCTweenUp.paused = true;
            this._postmortemDCTweenUp.dispose();
            this._postmortemDCTweenUp = null;
         }
         if(this._postmortemTween)
         {
            this._postmortemTween.paused = true;
            this._postmortemTween.dispose();
            this._postmortemTween = null;
         }
      }
      
      private function updateKillerBackground() : void
      {
         var _loc1_:Boolean = this._colorSchemeMgr.getIsColorBlindS();
         if(_loc1_)
         {
            nicknameKillerBG.imageName = BATTLEATLAS.POSTMORTEM_NICKNAME_BG_PURPLE;
            deadReasonBG.imageName = BATTLEATLAS.POSTMORTEM_DEAD_REASON_BG_PURPLE;
         }
         else
         {
            nicknameKillerBG.imageName = BATTLEATLAS.POSTMORTEM_NICKNAME_BG;
            deadReasonBG.imageName = BATTLEATLAS.POSTMORTEM_DEAD_REASON_BG;
         }
      }
      
      private function createDogTagAnimateShowEndHandler(param1:Boolean) : Function
      {
         var fadeOut:Boolean = param1;
         return function(param1:Event):void
         {
            onDogTagAnimateShowEnd(fadeOut);
         };
      }
      
      private function onDogTagAnimateShowEnd(param1:Boolean) : void
      {
         if(param1)
         {
            return;
         }
         this._dogTagKiller.stop();
         onDogTagKillerOutPlaySoundS();
         this.tweenReasonAndName(false);
      }
      
      public function set isEnabledPostmortemPanel(param1:Boolean) : void
      {
         this._isEnabledPostmortemPanel = param1;
      }
      
      public function set deadReasonOpacity(param1:Number) : void
      {
         deadReasonTF.alpha = param1;
         deadReasonBG.alpha = param1;
      }
      
      public function get deadReasonOpacity() : Number
      {
         return deadReasonTF.alpha;
      }
      
      private function onDogTagAnimateHideStart(param1:Event) : void
      {
         onDogTagKillerOutPlaySoundS();
         this.tweenReasonAndName(false);
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateKillerBackground();
      }
   }
}
