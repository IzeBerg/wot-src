package net.wg.gui.battle.historicalBattles.stats
{
   import net.wg.infrastructure.base.meta.IHBStatsWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.HBStatsWidgetMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class HBStatsWidget extends HBStatsWidgetMeta implements IHBStatsWidgetMeta, IDisplayableComponent
   {
       
      
      protected var _isCompVisible:Boolean = true;
      
      public function HBStatsWidget()
      {
         super();
         setManageSize(true);
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         if(this._isCompVisible != param1)
         {
            this._isCompVisible = param1;
            this.updateVisibility();
         }
      }
      
      private function updateVisibility() : void
      {
         visible = this._isCompVisible;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
   }
}
