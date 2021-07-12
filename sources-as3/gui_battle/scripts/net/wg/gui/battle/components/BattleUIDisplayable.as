package net.wg.gui.battle.components
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class BattleUIDisplayable extends BaseDAAPIComponent implements IDisplayableComponent
   {
       
      
      protected var _isCompVisible:Boolean = true;
      
      public function BattleUIDisplayable()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._isCompVisible = visible;
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         if(this._isCompVisible != param1)
         {
            this._isCompVisible = param1;
            this.updateVisibility();
         }
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
      
      protected function updateVisibility() : void
      {
         visible = this._isCompVisible;
      }
   }
}
