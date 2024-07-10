package net.wg.gui.battle.races.components
{
   import net.wg.gui.battle.components.preBattleTimer.DigitAnim;
   import net.wg.gui.battle.components.preBattleTimer.DigitsChain;
   
   public class RacesDigitsChain extends DigitsChain
   {
       
      
      private var _digitShownCallback:Function = null;
      
      private var _digitHiddenCallback:Function = null;
      
      public function RacesDigitsChain(param1:Vector.<DigitAnim>)
      {
         super(param1);
      }
      
      public function setDigitAnimationCallbacks(param1:Function, param2:Function) : void
      {
         this._digitShownCallback = param1;
         this._digitHiddenCallback = param2;
      }
      
      override protected function applyDigitsShownCallback(param1:int) : void
      {
         if(this._digitShownCallback != null)
         {
            this._digitShownCallback(param1);
         }
      }
      
      override protected function applyDigitsHiddenCallback(param1:int) : void
      {
         if(this._digitHiddenCallback != null)
         {
            this._digitHiddenCallback(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this._digitShownCallback = null;
         this._digitHiddenCallback = null;
         super.onDispose();
      }
   }
}
