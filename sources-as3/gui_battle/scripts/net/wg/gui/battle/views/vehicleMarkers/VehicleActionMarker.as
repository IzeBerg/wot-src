package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class VehicleActionMarker extends BaseActionMarker implements IDisposable
   {
      
      private static const BASE_HEIGHT:int = 20;
      
      private static const HIDE_DURATION:int = 1000;
      
      private static const ACTION_RENDERER_MAP:Object = {
         "reloading_gun":VehicleMarkersLinkages.ACTION_RELOADING,
         "help_me":VehicleMarkersLinkages.ACTION_HELP_ME,
         "attackSender":VehicleMarkersLinkages.ACTION_ATTACK_SENDER,
         "positive":VehicleMarkersLinkages.ACTION_POSITIVE,
         "thanks":VehicleMarkersLinkages.ACTION_THANKS,
         "help_me_ex":VehicleMarkersLinkages.ACTION_HELP_ME_EX,
         "turn_back":VehicleMarkersLinkages.ACTION_TURN_BACK,
         "supportingAlly":VehicleMarkersLinkages.ACTION_SUPPORTING_ALLY,
         "supportingYou":VehicleMarkersLinkages.ACTION_SUPPORTING_YOU,
         "attack":VehicleMarkersLinkages.ACTION_ATTACK,
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
         "defendingObjectiveAlternative":VehicleMarkersLinkages.ACTION_DEFENDING_OBJECTIVE
      };
      
      private static const ACTION_ICON_STATE:String = "actionIconState";
       
      
      private var _isVisible:Boolean = false;
      
      private var _currentRenderer:MovieClip = null;
      
      private var _hideTween:Tween = null;
      
      private var _entityName:String = "enemy";
      
      private var _actionJustChanged:Boolean = false;
      
      private var _actionIconStateMarker:ActionIconStateMarker = null;
      
      private var _count:int = 0;
      
      private var _lastState:int = -1;
      
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
         if(param1 == Values.EMPTY_STR)
         {
            return;
         }
         var _loc3_:String = this.getActionRendererLinkage(param1);
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
            }
            else
            {
               this._currentRenderer.alpha = 0;
            }
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
      
      protected function getActionRendererLinkage(param1:String) : String
      {
         return ACTION_RENDERER_MAP[param1];
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
