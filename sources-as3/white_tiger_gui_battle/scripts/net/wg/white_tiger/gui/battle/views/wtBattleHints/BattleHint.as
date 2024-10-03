package net.wg.white_tiger.gui.battle.views.wtBattleHints
{
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.data.HintInfoVO;
   import net.wg.white_tiger.infrastructure.base.meta.IWTBattleHintMeta;
   import net.wg.white_tiger.infrastructure.base.meta.impl.WTBattleHintMeta;
   
   public class BattleHint extends WTBattleHintMeta implements IWTBattleHintMeta
   {
       
      
      public var hintContainer:InfoContainer = null;
      
      private var _container:Sprite;
      
      private var _useCountdownTimer:Boolean = false;
      
      private var _offset:int = 0;
      
      private const COUNTDOWN_Y:int = 170;
      
      private const DEFAULT_Y:int = 120;
      
      public function BattleHint()
      {
         this._container = new Sprite();
         super();
         addChild(this._container);
         this._container.addChild(this.hintContainer);
      }
      
      override protected function onDispose() : void
      {
         this._container.removeChild(this.hintContainer);
         removeChild(this._container);
         this._container = null;
         this.hintContainer.dispose();
         this.hintContainer = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            y = (!!this._useCountdownTimer ? this.COUNTDOWN_Y : this.DEFAULT_Y) + this._offset;
         }
      }
      
      override protected function showHint(param1:HintInfoVO) : void
      {
         this._useCountdownTimer = param1.useCountdownTimer;
         this.hintContainer.showHint(param1);
         invalidatePosition();
      }
      
      public function as_hideHint() : void
      {
         this.hintContainer.hideHint();
      }
      
      public function setOffset(param1:int) : void
      {
         this._offset = param1;
         invalidatePosition();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.updateStage(param1,param2);
         this._container.x = param1 >> 1;
      }
   }
}
