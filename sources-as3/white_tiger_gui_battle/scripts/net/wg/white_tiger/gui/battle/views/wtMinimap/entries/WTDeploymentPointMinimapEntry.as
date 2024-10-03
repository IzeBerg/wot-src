package net.wg.white_tiger.gui.battle.views.wtMinimap.entries
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.utils.ICommons;
   import scaleform.clik.motion.Tween;
   
   public class WTDeploymentPointMinimapEntry extends BattleUIComponent implements ISoundable
   {
      
      public static const DEPLOYMENT_SELECTED:String = "deploymentSelected";
      
      private static const HINT_OFFSET_X:int = 12;
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const HOVER_STATE:String = "hover";
      
      private static const SELECTED_STATE:String = "selected";
      
      private static const FADE_DURATION:int = 300;
       
      
      public var hitMc:Sprite = null;
      
      public var hint:MovieClip = null;
      
      public var stateSelectedMc:MovieClip = null;
      
      public var stateNormalMc:MovieClip = null;
      
      private var _id:String = "";
      
      private var _state:String = "normal";
      
      private var _hintX:int = -1;
      
      private var normalFadeTween:Tween = null;
      
      private var selectedFadeTween:Tween = null;
      
      private var hintFadeTween:Tween = null;
      
      private var _soundMgr:ISoundManager;
      
      private var _commons:ICommons;
      
      public function WTDeploymentPointMinimapEntry()
      {
         this._soundMgr = App.soundMgr;
         this._commons = App.utils.commons;
         super();
         mouseChildren = false;
         hitArea = this.hitMc;
         this.stateSelectedMc.alpha = this.hint.alpha = 0;
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEventRollOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEventRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onMouseEventClickHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEventHandler);
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.clearTweens();
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEventRollOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEventRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onMouseEventClickHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEventHandler);
         hitArea = null;
         this.hitMc = null;
         this.hint = null;
         this.stateNormalMc = null;
         this.stateSelectedMc = null;
         this._soundMgr.removeSoundHdlrs(this);
         this._soundMgr = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._hintX = this.hint.x;
         var _loc1_:TextField = TextField(this.hint.hintTF);
         _loc1_.text = EVENT.MINIMAP_RESPAWNENTRY_HINTTEXT;
         this._soundMgr.addSoundsHdlrs(this);
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this._state != SELECTED_STATE;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.WT_EVENT_DEPLOY_POINT;
      }
      
      public function setId(param1:String) : void
      {
         this._id = param1;
      }
      
      public function setIsSelected(param1:Boolean) : void
      {
         this.state = !!param1 ? SELECTED_STATE : NORMAL_STATE;
      }
      
      private function clearTweens() : void
      {
         if(this.normalFadeTween)
         {
            this.normalFadeTween.dispose();
            this.normalFadeTween = null;
         }
         if(this.selectedFadeTween)
         {
            this.selectedFadeTween.dispose();
            this.selectedFadeTween = null;
         }
         if(this.hintFadeTween)
         {
            this.hintFadeTween.dispose();
            this.hintFadeTween = null;
         }
      }
      
      private function showNormal() : void
      {
         this.clearTweens();
         this.normalFadeTween = new Tween(FADE_DURATION,this.stateNormalMc,{"alpha":1},{"ease":Cubic.easeIn});
         this.selectedFadeTween = new Tween(FADE_DURATION,this.stateSelectedMc,{"alpha":0},{"ease":Cubic.easeIn});
         this.hintFadeTween = new Tween(FADE_DURATION,this.hint,{
            "alpha":0,
            "x":this._hintX
         },{"ease":Cubic.easeIn});
      }
      
      private function showHover() : void
      {
         this.clearTweens();
         this.normalFadeTween = new Tween(FADE_DURATION,this.stateNormalMc,{"alpha":0},{"ease":Cubic.easeIn});
         this.selectedFadeTween = new Tween(FADE_DURATION,this.stateSelectedMc,{"alpha":1},{"ease":Cubic.easeIn});
         this.hintFadeTween = new Tween(FADE_DURATION,this.hint,{
            "alpha":0,
            "x":this._hintX
         },{"ease":Cubic.easeIn});
      }
      
      private function showSelected() : void
      {
         this.clearTweens();
         this.normalFadeTween = new Tween(FADE_DURATION,this.stateNormalMc,{"alpha":0},{"ease":Cubic.easeIn});
         this.selectedFadeTween = new Tween(FADE_DURATION,this.stateSelectedMc,{"alpha":1},{"ease":Cubic.easeIn});
         this.hintFadeTween = new Tween(FADE_DURATION,this.hint,{
            "alpha":1,
            "x":this._hintX + HINT_OFFSET_X
         },{"ease":Cubic.easeIn});
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      private function set state(param1:String) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            switch(this._state)
            {
               case SELECTED_STATE:
                  this.showSelected();
                  break;
               case HOVER_STATE:
                  this.showHover();
                  break;
               case NORMAL_STATE:
               default:
                  this.showNormal();
            }
         }
      }
      
      private function onMouseEventRollOverHandler(param1:MouseEvent) : void
      {
         if(this._state == SELECTED_STATE)
         {
            return;
         }
         this.state = HOVER_STATE;
      }
      
      private function onMouseEventRollOutHandler(param1:MouseEvent) : void
      {
         if(this._state == SELECTED_STATE)
         {
            return;
         }
         this.state = NORMAL_STATE;
      }
      
      private function onMouseEventClickHandler(param1:MouseEvent) : void
      {
         if(this._commons.isLeftButton(param1))
         {
            dispatchEvent(new Event(DEPLOYMENT_SELECTED,true));
         }
      }
      
      private function onMouseDownEventHandler(param1:MouseEvent) : void
      {
         if(!this._commons.isLeftButton(param1))
         {
            param1.stopImmediatePropagation();
         }
      }
   }
}
