package net.wg.gui.battle.views.damageInfoPanel.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class Fire extends BattleUIComponent
   {
       
      
      public var mainEffect:MovieClip = null;
      
      public var stainsEffect:MovieClip = null;
      
      private var _stateId:int = 0;
      
      private var _isHit:Boolean = false;
      
      private const SHOW_STATE_ID:int = 0;
      
      private const HIDE_STATE_ID:int = 1;
      
      private const HIDE_IMMEDIATLY_STATE_ID:int = 2;
      
      private const STOP_ANIM_STATE_ID:int = 3;
      
      public function Fire()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._stateId == this.SHOW_STATE_ID)
            {
               visible = true;
               this.mainEffect.gotoAndPlay(1);
               this.stainsEffect.gotoAndPlay(1);
               gotoAndPlay(!!this._isHit ? DAMAGE_INFO_PANEL_CONSTS.FIRE_HIT_FRAME_LABEL : DAMAGE_INFO_PANEL_CONSTS.FIRE_SHOW_FRAME_LABEL);
            }
            else if(this._stateId == this.HIDE_STATE_ID)
            {
               this.stopChildrenAnim();
               if(currentFrame != 1 && currentFrame != 53)
               {
                  gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.FIRE_HIDE_FRAME_LABEL);
               }
            }
            else if(this._stateId == this.HIDE_IMMEDIATLY_STATE_ID)
            {
               this.stopChildrenAnim();
               visible = false;
            }
            else if(this._stateId == this.STOP_ANIM_STATE_ID)
            {
               this.stopChildrenAnim();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.stopChildrenAnim();
         this.mainEffect = null;
         this.stainsEffect = null;
         super.onDispose();
      }
      
      public function showFire(param1:Boolean) : void
      {
         this._isHit = param1;
         this._stateId = this.SHOW_STATE_ID;
         invalidate(InvalidationType.STATE);
      }
      
      public function hideFire() : void
      {
         this._stateId = this.HIDE_STATE_ID;
         invalidate(InvalidationType.STATE);
      }
      
      public function hideFireImmediately() : void
      {
         this._stateId = this.HIDE_IMMEDIATLY_STATE_ID;
         invalidate(InvalidationType.STATE);
      }
      
      public function stopAnim() : void
      {
         this._stateId = this.STOP_ANIM_STATE_ID;
         invalidate(InvalidationType.STATE);
      }
      
      public function stopChildrenAnim() : void
      {
         this.mainEffect.stop();
         this.stainsEffect.stop();
      }
   }
}
