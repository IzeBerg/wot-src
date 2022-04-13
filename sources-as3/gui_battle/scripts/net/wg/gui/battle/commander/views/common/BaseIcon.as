package net.wg.gui.battle.commander.views.common
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class BaseIcon extends BattleUIComponent
   {
       
      
      protected var _isShown:Boolean = true;
      
      protected var _isAlive:Boolean = true;
      
      public function BaseIcon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         invalidate(InvalidationType.ALL);
      }
      
      public function get isShown() : Boolean
      {
         return this._isShown;
      }
      
      public function set isShown(param1:Boolean) : void
      {
         if(this._isShown != param1)
         {
            this._isShown = param1;
            invalidateData();
         }
      }
      
      public function get isAlive() : Boolean
      {
         return this._isAlive;
      }
      
      public function set isAlive(param1:Boolean) : void
      {
         if(this._isAlive != param1)
         {
            this._isAlive = param1;
            invalidateData();
         }
      }
   }
}
