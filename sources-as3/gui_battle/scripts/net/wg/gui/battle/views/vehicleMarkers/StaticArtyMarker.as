package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class StaticArtyMarker extends BattleUIComponent
   {
      
      private static const LOOP_ANIMATION_START:int = 32;
      
      private static const LOOP_ANIMATION_END:int = 91;
      
      private static const STATE_HIDE:String = "hide";
       
      
      public var marker:MovieClip = null;
      
      public var bgShadow:Sprite = null;
      
      private var _targetAnimation:MovieClip = null;
      
      public function StaticArtyMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._targetAnimation)
         {
            this._targetAnimation.addFrameScript(LOOP_ANIMATION_END,null);
            this._targetAnimation = null;
         }
         this.marker = null;
         this.bgShadow = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:Class = null;
         super.configUI();
         if(!this._targetAnimation)
         {
            _loc1_ = VehicleMarkersLinkages.ACTION_ATTACK_SPG;
            _loc2_ = getDefinitionByName(_loc1_) as Class;
            this._targetAnimation = new _loc2_();
            if(this._targetAnimation == null)
            {
               throw new Error(Errors.BAD_LINKAGE + _loc1_);
            }
            this._targetAnimation.addFrameScript(LOOP_ANIMATION_END,this.loopAnimation);
            this.marker.addChild(this._targetAnimation);
         }
         this._targetAnimation.gotoAndPlay(1);
      }
      
      public function hide(param1:Boolean = true) : void
      {
         if(this._targetAnimation)
         {
            if(param1)
            {
               this._targetAnimation.gotoAndPlay(STATE_HIDE);
            }
            else
            {
               this._targetAnimation.gotoAndStop(1);
            }
         }
      }
      
      private function loopAnimation() : void
      {
         this._targetAnimation.gotoAndPlay(LOOP_ANIMATION_START);
      }
   }
}
