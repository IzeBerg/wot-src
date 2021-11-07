package net.wg.gui.battle.views.damagePanel.interfaces
{
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
   
   public interface IDamagePanelClickableItem extends IAssetCreator
   {
       
      
      function showDestroyed() : void;
      
      function get mouseEventHitElement() : DamagePanelItemClickArea;
   }
}
