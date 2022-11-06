package net.wg.gui.battle.components
{
   import net.wg.infrastructure.base.BaseBattleDAAPIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class BattleDisplayable extends BaseBattleDAAPIComponent implements IDisplayableComponent
   {
       
      
      protected var _isCompVisible:Boolean = true;
      
      public var initedWidth:Number;
      
      public var initedHeight:Number;
      
      public function BattleDisplayable()
      {
         super();
         this.initedWidth = width;
         this.initedHeight = height;
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
      
      protected function updateVisibility() : void
      {
         visible = this._isCompVisible;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
   }
}
