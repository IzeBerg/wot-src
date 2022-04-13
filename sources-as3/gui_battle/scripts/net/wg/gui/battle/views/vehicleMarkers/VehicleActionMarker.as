package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class VehicleActionMarker extends BaseActionMarker implements IDisposable
   {
      
      private static const ACTION_ICON_STATE:String = "actionIconState";
      
      private static const BASE_HEIGHT:int = 20;
      
      private static const HIDE_DURATION:int = 1000;
      
      private static const ACTION_RENDERER_MAP:Object = {
         "reloading_gun":VehicleMarkersLinkages.ACTION_RELOADING,
         "reloading_gunSPG":VehicleMarkersLinkages.ACTION_RELOADING,
         "help_me":VehicleMarkersLinkages.ACTION_HELP_ME,
         "help_meSPG":VehicleMarkersLinkages.ACTION_HELP_ME,
         "help_me_ex":VehicleMarkersLinkages.ACTION_HELP_ME_EX,
         "help_me_exSPG":VehicleMarkersLinkages.ACTION_HELP_ME_EX,
         "follow_me":VehicleMarkersLinkages.ACTION_FOLLOW_ME,
         "follow_meSPG":VehicleMarkersLinkages.ACTION_FOLLOW_ME,
         "attackSender":VehicleMarkersLinkages.ACTION_ATTACK_SENDER,
         "attackSenderSPG":VehicleMarkersLinkages.ACTION_ATTACK_SENDER,
         "negative":VehicleMarkersLinkages.ACTION_NEGATIVE,
         "negativeSPG":VehicleMarkersLinkages.ACTION_NEGATIVE,
         "positive":VehicleMarkersLinkages.ACTION_POSITIVE,
         "positiveSPG":VehicleMarkersLinkages.ACTION_POSITIVE,
         "stop":VehicleMarkersLinkages.ACTION_STOP,
         "stopSPG":VehicleMarkersLinkages.ACTION_STOP,
         "thanks":VehicleMarkersLinkages.ACTION_THANKS,
         "turn_back":VehicleMarkersLinkages.ACTION_TURN_BACK,
         "turn_backSPG":VehicleMarkersLinkages.ACTION_TURN_BACK,
         "supportingAlly":VehicleMarkersLinkages.ACTION_SUPPORTING_ALLY,
         "supportingYou":VehicleMarkersLinkages.ACTION_SUPPORTING_YOU,
         "attack":VehicleMarkersLinkages.ACTION_ATTACK,
         "attackOrder":VehicleMarkersLinkages.ACTION_ATTACK_ORDER,
         "attackOrderBerserk":VehicleMarkersLinkages.ACTION_ATTACK_BERSERK_ORDER,
         "attackSPG":VehicleMarkersLinkages.ACTION_ATTACK_SPG,
         "allySos":VehicleMarkersLinkages.ACTION_ALLY_SOS_EX,
         "orderConfirm":VehicleMarkersLinkages.ACTION_ORDER_CONFIRM,
         "link":VehicleMarkersLinkages.ACTION_LINK,
         "smart":VehicleMarkersLinkages.ACTION_SMART,
         "hold":VehicleMarkersLinkages.ACTION_HOLD,
         "scout":VehicleMarkersLinkages.ACTION_SCOUT,
         "attackAlternative":VehicleMarkersLinkages.ACTION_ATTACK_ALTERNATIVE,
         "supportingAllyAlternative":VehicleMarkersLinkages.ACTION_SUPPORTING_ALLY_ALTERNATIVE,
         "goingToAlternative":VehicleMarkersLinkages.ACTION_GOING_TO,
         "attackBaseAlternative":VehicleMarkersLinkages.ACTION_ATTACK_BASE,
         "defendBaseAlternative":VehicleMarkersLinkages.ACTION_DEFEND_BASE,
         "attackingBaseAlternative":VehicleMarkersLinkages.ACTION_ATTACK_BASE,
         "defendingBaseAlternative":VehicleMarkersLinkages.ACTION_DEFEND_BASE,
         "attackObjectiveAlternative":VehicleMarkersLinkages.ACTION_ATTACKING_OBJECTIVE,
         "defendObjectiveAlternative":VehicleMarkersLinkages.ACTION_DEFENDING_OBJECTIVE,
         "attackingObjectiveAlternative":VehicleMarkersLinkages.ACTION_ATTACKING_OBJECTIVE,
         "defendingObjectiveAlternative":VehicleMarkersLinkages.ACTION_DEFENDING_OBJECTIVE,
         "NoCondition":VehicleMarkersLinkages.ACTION_NO_CONDITION,
         "OnFireCondition":VehicleMarkersLinkages.ACTION_ON_FIRE,
         "DrowningCondition":VehicleMarkersLinkages.ACTION_DROWNING,
         "OverturnedCondition":VehicleMarkersLinkages.ACTION_OVERTURNED,
         "NoMoveCondition":VehicleMarkersLinkages.ACTION_NO_MOVING,
         "NoShotCondition":VehicleMarkersLinkages.ACTION_NO_SHOOTING,
         "OnSOSCondition":VehicleMarkersLinkages.ACTION_HELP_ME_EX,
         "OnSpottedCondition":VehicleMarkersLinkages.ACTION_ALLY_OBSERVED_EX,
         "OnDeadCondition":VehicleMarkersLinkages.ACTION_ALLY_DEAD_EX
      };
       
      
      private var _isVisible:Boolean = false;
      
      private var _currentRenderer:MovieClip = null;
      
      private var _hideTween:Tween = null;
      
      private var _entityName:String = "enemy";
      
      private var _actionJustChanged:Boolean = false;
      
      private var _actionIconStateMarker:ActionIconStateMarker = null;
      
      private var _count:int = 0;
      
      private var _lastState:int = -1;
      
      private var _currentActionName:String = "";
      
      public const ARROW_POSITION:Point = new Point(0,0);
      
      public const REPLY_POSITION:Point = new Point(20,-1);
      
      public const DISTANCE_POSITION:Point = new Point(-43,15);
      
      public function VehicleActionMarker()
      {
         super();
      }
      
      override public function setReplyCount(param1:int) : void
      {
         this._count = param1;
         super.setReplyCount(param1);
      }
      
      override protected function onDispose() : void
      {
         this.removeActionRenderer();
         if(this._hideTween)
         {
            this._hideTween.dispose();
         }
         this._hideTween = null;
         this._currentRenderer = null;
         if(this._actionIconStateMarker != null)
         {
            this._actionIconStateMarker.dispose();
         }
         this._actionIconStateMarker = null;
         super.onDispose();
      }
      
      public function isVisible() : Boolean
      {
         return this._isVisible;
      }
      
      public function showAction(param1:String, param2:Boolean = false) : void
      {
         if(param1 == Values.EMPTY_STR || this._currentActionName == param1)
         {
            return;
         }
         this._currentActionName = param1;
         var _loc3_:String = ACTION_RENDERER_MAP[param1];
         if(_loc3_ != Values.EMPTY_STR)
         {
            this._isVisible = true;
            this._currentRenderer = this.createActionRenderer(_loc3_);
         }
         this._actionIconStateMarker = ActionIconStateMarker(this._currentRenderer.getChildByName(ACTION_ICON_STATE));
         this._actionJustChanged = true;
         if(param2 && this._lastState != -1)
         {
            this.updateActionRenderer(this._lastState);
         }
      }
      
      public function stopAction(param1:Boolean = true) : void
      {
         if(this._currentRenderer)
         {
            if(param1)
            {
               this._hideTween = new Tween(HIDE_DURATION,this._currentRenderer,{"alpha":0});
               this._hideTween.onComplete = this.onAnimationComplete;
            }
            else
            {
               if(this._hideTween)
               {
                  this._hideTween.onComplete = null;
               }
               this._currentRenderer.alpha = 0;
            }
            this._currentActionName = Values.EMPTY_STR;
            this._isVisible = false;
         }
      }
      
      public function triggerClickAnimation() : void
      {
         if(this._actionIconStateMarker != null)
         {
            this._actionIconStateMarker.playClickAnimation();
         }
      }
      
      public function updateActionRenderer(param1:int) : void
      {
         if(!this._currentRenderer)
         {
            return;
         }
         if(this._actionIconStateMarker != null)
         {
            if(this._actionJustChanged && param1 != ActionMarkerStates.REPLIED_ALLY && param1 != ActionMarkerStates.REPLIED_ME && this._count == 0)
            {
               this._actionIconStateMarker.playBlinkAnimation(true);
            }
            else if(this._count >= 1)
            {
               this._actionIconStateMarker.playBlinkAnimation(false);
            }
            this._actionJustChanged = false;
            this._actionIconStateMarker.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param1]);
            this._lastState = param1;
         }
      }
      
      private function removeActionRenderer() : void
      {
         if(!this._currentRenderer)
         {
            return;
         }
         removeChild(this._currentRenderer);
         this._currentRenderer = null;
      }
      
      private function createActionRenderer(param1:String) : MovieClip
      {
         var rendererClass:Class = null;
         var rendererLinkage:String = param1;
         this.removeActionRenderer();
         var renderer:MovieClip = null;
         try
         {
            rendererClass = getDefinitionByName(rendererLinkage) as Class;
            renderer = new rendererClass();
            if(renderer)
            {
               addChild(renderer);
            }
         }
         catch(error:ReferenceError)
         {
         }
         return renderer;
      }
      
      private function onAnimationComplete() : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      override protected function get getReplyPosition() : Point
      {
         return this.REPLY_POSITION;
      }
      
      override protected function get getArrowPosition() : Point
      {
         return this.ARROW_POSITION;
      }
      
      override protected function get getDistanceToMarkerPosition() : Point
      {
         return this.DISTANCE_POSITION;
      }
      
      override public function get height() : Number
      {
         return BASE_HEIGHT;
      }
      
      public function get entityName() : String
      {
         return this._entityName;
      }
      
      public function set entityName(param1:String) : void
      {
         this._entityName = param1;
      }
   }
}
