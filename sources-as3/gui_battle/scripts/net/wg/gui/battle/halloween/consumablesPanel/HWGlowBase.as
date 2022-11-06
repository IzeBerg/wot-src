package net.wg.gui.battle.halloween.consumablesPanel
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HWGlowBase extends BattleUIComponent
   {
       
      
      protected var _isActive:Boolean;
      
      public function HWGlowBase()
      {
         super();
      }
      
      public function showGlow(param1:int) : void
      {
      }
      
      public function hideGlow() : void
      {
      }
      
      public function showAnimation(param1:String) : void
      {
         if(currentLabel != param1)
         {
            gotoAndPlay(param1);
         }
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public final function set isActive(param1:Boolean) : void
      {
         if(this._isActive == param1)
         {
            return;
         }
         this._isActive = param1;
         this.onActiveChanged();
      }
      
      public function setBindKeyText(param1:String) : void
      {
      }
      
      protected function onActiveChanged() : void
      {
      }
   }
}
