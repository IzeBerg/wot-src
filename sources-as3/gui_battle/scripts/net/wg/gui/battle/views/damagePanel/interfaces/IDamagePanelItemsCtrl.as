package net.wg.gui.battle.views.damagePanel.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IDamagePanelItemsCtrl extends IDisposable
   {
       
      
      function getItems() : Vector.<IDamagePanelClickableItem>;
      
      function setState(param1:String, param2:String) : void;
      
      function showDestroyed() : void;
      
      function getItemByName(param1:String) : IDamagePanelClickableItem;
      
      function reset() : void;
   }
}
