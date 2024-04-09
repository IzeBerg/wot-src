package net.wg.gui.battle.pveBase.views.stats.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import net.wg.gui.battle.pveBase.views.stats.components.playersPanel.list.PvePlayersPanelListLeft;
   import net.wg.infrastructure.base.meta.IPvePlayersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PvePlayersPanelMeta;
   
   public class PvePlayersPanel extends PvePlayersPanelMeta implements IPvePlayersPanelMeta
   {
       
      
      public function PvePlayersPanel()
      {
         super();
      }
      
      public function as_setCountLivesVisibility(param1:Boolean) : void
      {
         if(listLeft is PvePlayersPanelListLeft)
         {
            (listLeft as PvePlayersPanelListLeft).setCountLivesVisibility(param1);
         }
      }
      
      override protected function onListRollOutHandler(param1:MouseEvent) : void
      {
         if(param1.target == listRight)
         {
            return;
         }
         super.onListRollOutHandler(param1);
      }
      
      override protected function onListRollOverHandler(param1:MouseEvent) : void
      {
         if(param1.target == listRight)
         {
            return;
         }
         super.onListRollOverHandler(param1);
      }
      
      public function as_setRightPanelVisibility(param1:Boolean) : void
      {
         (listRight as DisplayObject).visible = param1;
      }
   }
}
