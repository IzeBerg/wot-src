package net.wg.gui.battle.pveBase.views.minimap.jacket
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class PveMinimapBaseJacket extends BattleUIComponent
   {
       
      
      protected var _currentSizeIndex:int = -1;
      
      public function PveMinimapBaseJacket()
      {
         super();
         visible = false;
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function setSize(param1:int) : void
      {
         if(this._currentSizeIndex == param1)
         {
            return;
         }
         this._currentSizeIndex = param1;
         this.onSizeChanged();
      }
      
      protected function onSizeChanged() : void
      {
      }
      
      public function get leftGap() : int
      {
         return 0;
      }
      
      public function get rightGap() : int
      {
         return 0;
      }
      
      public function get topGap() : int
      {
         return 0;
      }
      
      public function get bottomGap() : int
      {
         return 0;
      }
      
      public function get horizontalGap() : int
      {
         return this.leftGap + this.rightGap;
      }
      
      public function get verticalGap() : int
      {
         return this.topGap + this.bottomGap;
      }
   }
}
