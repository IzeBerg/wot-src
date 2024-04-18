package net.wg.gui.lobby.fortifications.cmp.drctn.impl
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class ConnectedDirects extends UIComponentEx
   {
      
      public static const ATTACK_0:String = "attack0";
      
      public static const ATTACK_1:String = "attack1";
      
      public static const ATTACK_2:String = "attack2";
      
      public static const ATTACK_3:String = "attack3";
      
      public static const ATTACK_4:String = "attack4";
      
      public static const ATTACK_5:String = "attack5";
      
      public static const DEFENSE_0:String = "defense0";
      
      public static const DEFENSE_1:String = "defense1";
      
      public static const DEFENSE_2:String = "defense2";
      
      public static const DEFENSE_3:String = "defense3";
      
      public static const DEFENSE_4:String = "defense4";
      
      public static const DEFENSE_5:String = "defense5";
      
      public static const DEFINITION:String = "definition";
      
      public static const LABEL_END:String = "end";
       
      
      public var baseAlly:MovieClip = null;
      
      public var building2Ally:MovieClip = null;
      
      public var building1Ally:MovieClip = null;
      
      public var building1Enemy:MovieClip = null;
      
      public var building2Enemy:MovieClip = null;
      
      public var baseEnemy:MovieClip = null;
      
      public var crossSwords:MovieClip = null;
      
      public var swords:MovieClip = null;
      
      public var circle:MovieClip = null;
      
      private var _buildings:Vector.<MovieClip> = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _isAnimationPlayed:Boolean = false;
      
      private var _isFocused:Boolean = false;
      
      private var _canPlayAnimation:Boolean = true;
      
      private var _currentState:String = "";
      
      private var _soundType:String = "";
      
      public function ConnectedDirects()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
      }
      
      private function buildingsDispose() : void
      {
         var _loc1_:MovieClip = null;
         if(this._buildings)
         {
            for each(_loc1_ in this._buildings)
            {
               _loc1_.hitMc.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
               _loc1_.hitMc.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            }
            this._buildings.splice(0,this._buildings.length);
            this._buildings = null;
         }
         if(this.crossSwords)
         {
            this.crossSwords.hitMc.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.crossSwords.hitMc.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         }
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         this.buildingsDispose();
         this.baseAlly = null;
         this.building2Ally = null;
         this.building1Ally = null;
         this.building1Enemy = null;
         this.building2Enemy = null;
         this.baseEnemy = null;
         this.crossSwords = null;
         this.swords = null;
         this.circle = null;
         this._currentState = null;
         this._soundType = null;
         this._isAnimationPlayed = false;
         this._canPlayAnimation = false;
         super.onDispose();
      }
      
      public function setDirection(param1:String, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         this.buildingsDispose();
         App.utils.asserter.assertFrameExists(param1,this);
         this._canPlayAnimation = !param2;
         if(this._currentState != param1)
         {
            this._currentState = param1;
            this._isAnimationPlayed = false;
            this.playAnimation(this._isFocused);
         }
         this._buildings = new <MovieClip>[this.baseAlly,this.building2Ally,this.building1Ally,this.building1Enemy,this.building2Enemy,this.baseEnemy];
         for each(_loc3_ in this._buildings)
         {
            _loc3_.hitMc.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            _loc3_.hitMc.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         }
         if(this.crossSwords)
         {
            this.crossSwords.hitMc.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.crossSwords.hitMc.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         }
      }
      
      public function playAnimation(param1:Boolean) : void
      {
         var _loc2_:String = null;
         this._isFocused = param1;
         if(!this._isAnimationPlayed && this._isFocused && this._canPlayAnimation)
         {
            if(this._currentState != Values.EMPTY_STR)
            {
               gotoAndPlay(this._currentState);
               this.playSound(this._currentState);
               if(this.swords)
               {
                  this.swords.play();
               }
               if(this.circle)
               {
                  this.circle.play();
               }
               this._isAnimationPlayed = true;
            }
            else
            {
               gotoAndStop(DEFINITION);
            }
         }
         else if(!this._isAnimationPlayed && this._currentState != Values.EMPTY_STR)
         {
            if(this._canPlayAnimation)
            {
               gotoAndStop(this._currentState);
            }
            else
            {
               _loc2_ = this._currentState + LABEL_END;
               gotoAndStop(_loc2_);
            }
         }
      }
      
      private function playSound(param1:String) : void
      {
         switch(param1)
         {
            case ATTACK_0:
               this._soundType = SoundTypes.BATTLE_COUNTER_WIN;
               break;
            case ATTACK_1:
               this._soundType = SoundTypes.BATTLE_WIN_OUR_CITADEL;
               break;
            case ATTACK_2:
            case ATTACK_3:
            case ATTACK_4:
               this._soundType = SoundTypes.BATTLE_WIN;
               break;
            case ATTACK_5:
               this._soundType = SoundTypes.BATTLE_WIN_OUR_CITADEL;
               break;
            case DEFENSE_0:
               this._soundType = SoundTypes.BATTLE_COUNTER_LOOSE;
               break;
            case DEFENSE_1:
               this._soundType = SoundTypes.BATTLE_LOOSE_ENEMY_CITADEL;
               break;
            case DEFENSE_2:
            case DEFENSE_3:
            case DEFENSE_4:
               this._soundType = SoundTypes.BATTLE_LOOSE;
               break;
            case DEFENSE_5:
               this._soundType = SoundTypes.BATTLE_LOOSE_ENEMY_CITADEL;
         }
         App.soundMgr.playControlsSnd(this._soundType,SoundTypes.STRONGHOLD,null);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(this.crossSwords == param1.currentTarget.parent)
         {
            this._toolTipMgr.showComplex(App.utils.locale.makeString(FORTIFICATIONS.STRONGHOLDTOOLTIPS_CROSSSWORDS));
            return;
         }
         for each(_loc2_ in this._buildings)
         {
            if(_loc2_ == param1.currentTarget.parent)
            {
               this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.DIRECT_MODULE,null,this._buildings.indexOf(_loc2_),0);
               break;
            }
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
