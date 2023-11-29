package net.wg.gui.battle.views.postmortemPanel
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.dogtag.DogTagEvent;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.components.dogtag.ImageRepository;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PostmortemPanelMeta;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class PostmortemPanel extends PostmortemPanelMeta implements IPostmortemPanelMeta
   {
      
      private static const FADE_ANIMATION_TIME:int = 200;
      
      private static const PANEL_ANIMATION_DELAY:int = 500;
      
      private static const DOGTAG_VICTIM_MINI_MAP_OFFSET:int = -760;
      
      private static const DOGTAG_KILLER_OFFSET_Y:int = 60;
      
      private static const DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME:int = 300;
      
      private static const VICTIM_DOGTAG_LINGERING_TIME:int = 1700;
      
      private static const DEAD_REASON_ALPHA:Number = 0.5;
      
      private static const DELAY_DT_KILLER_APPEARANCE:int = 1000;
      
      private static const DELAY_DT_VICTIM_APPEARANCE:int = 600;
      
      private static const INVALID_HIDE_COMPONENTS:uint = 1 << 11;
       
      
      public var bg:BattleAtlasSprite = null;
      
      public var observerModeTitleTF:TextField = null;
      
      public var observerModeDescTF:TextField = null;
      
      public var exitToHangarTitleTF:TextField = null;
      
      public var exitToHangarDescTF:TextField = null;
      
      private var _dogTagVictim:DogtagComponent = null;
      
      private var _dogTagKiller:DogtagComponent = null;
      
      private var _vehPanelFadeInTween:Tween = null;
      
      private var _deadReasonTween:Tween = null;
      
      private var _userNameTextFieldFadeInTween:Tween = null;
      
      private var _dogTagAppearanceDelayTween:Tween = null;
      
      private var _nicknameKillerBGTween:Tween = null;
      
      private var _victimDogTagTweenIn:Tween = null;
      
      private var _victimDogTagTweenOut:Tween = null;
      
      private var _dogTagVictimMiniMapAnchor:int;
      
      private var _isEnabledSpectatorPanel:Boolean = true;
      
      public function PostmortemPanel()
      {
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
      
      override public function showDeadReason() : void
      {
         super.showDeadReason();
         if(this._dogTagKiller)
         {
            this._dogTagKiller.visible = true;
         }
         this.showSpectatorPanel(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_BG;
         nicknameKillerBG.imageName = BATTLEATLAS.POSTMORTEM_NICKNAME_BG;
         deadReasonBG.imageName = BATTLEATLAS.POSTMORTEM_DEAD_REASON_BG;
         this.observerModeTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_LABEL;
         this.observerModeDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_TEXT;
         this.exitToHangarTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_LABEL;
         this.exitToHangarDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_TEXT;
         this.showSpectatorPanel(false);
         TextFieldEx.setVerticalAutoSize(deadReasonTF,TextFieldEx.VALIGN_BOTTOM);
         setComponentsVisibility(false);
         this.updatePlayerInfoPosition();
         this.initDogTagVictim();
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
      }
      
      override protected function showKillerDogTag(param1:DogTagVO) : void
      {
         if(!this._dogTagKiller)
         {
            this.initDogTagKiller();
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
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_VEHICLE_PANEL))
         {
            if(_deadReason != Values.EMPTY_STR)
            {
               this.showSpectatorPanel(true);
            }
            nicknameKillerBG.visible = _showVehiclePanel;
            if(_userName && _userName.userVO && _userName.userVO.userName != Values.EMPTY_STR)
            {
               this.showPanel();
            }
         }
         if(isInvalid(INVALID_HIDE_COMPONENTS))
         {
            this.showSpectatorPanel(false);
            setComponentsVisibility(false);
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.observerModeTitleTF = null;
         this.observerModeDescTF = null;
         this.exitToHangarTitleTF = null;
         this.exitToHangarDescTF = null;
         if(this._dogTagVictim)
         {
            this._dogTagVictim.dispose();
         }
         if(this._dogTagKiller)
         {
            this._dogTagKiller.dispose();
         }
         this.clearTweens();
         ImageRepository.getInstance().dispose();
         super.onDispose();
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
      
      public function as_hideComponents() : void
      {
         invalidate(INVALID_HIDE_COMPONENTS);
      }
      
      public function as_setPlayerInfo(param1:String) : void
      {
         this.setPlayerInfo(param1);
      }
      
      public function as_showDeadReason() : void
      {
         this.showDeadReason();
      }
      
      private function initDogTagKiller() : void
      {
         this._dogTagKiller = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
         addChild(this._dogTagKiller);
         this._dogTagKiller.x = -this._dogTagKiller.width >> 1;
         this._dogTagKiller.y = deadReasonTF.y - this._dogTagKiller.height - DOGTAG_KILLER_OFFSET_Y;
         this._dogTagKiller.addEventListener(DogTagEvent.ON_DOGTAG_COMPONENT_ANIMATE_HIDE_START,this.onDogTagAnimateHideStart);
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
      
      public function set isEnabledSpectatorPanel(param1:Boolean) : void
      {
         this._isEnabledSpectatorPanel = param1;
      }
      
      private function showSpectatorPanel(param1:Boolean) : void
      {
         if(!param1 || this._isEnabledSpectatorPanel && param1)
         {
            this.bg.visible = param1;
            this.observerModeTitleTF.visible = param1;
            this.observerModeDescTF.visible = param1;
            this.exitToHangarTitleTF.visible = param1;
            this.exitToHangarDescTF.visible = param1;
         }
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
      }
      
      public function get deadReasonOpacity() : Number
      {
         return deadReasonTF.alpha;
      }
      
      public function set deadReasonOpacity(param1:Number) : void
      {
         deadReasonTF.alpha = param1;
         deadReasonBG.alpha = param1;
      }
      
      private function onDogTagAnimateHideStart(param1:Event) : void
      {
         onDogTagKillerOutPlaySoundS();
         this.tweenReasonAndName(false);
      }
   }
}
