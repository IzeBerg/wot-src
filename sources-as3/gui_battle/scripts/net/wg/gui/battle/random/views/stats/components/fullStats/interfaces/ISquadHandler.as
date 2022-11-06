package net.wg.gui.battle.random.views.stats.components.fullStats.interfaces
{
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   
   public interface ISquadHandler
   {
       
      
      function onAcceptSquad(param1:DynamicSquadCtrl) : void;
      
      function onAddToSquad(param1:DynamicSquadCtrl) : void;
      
      function onSquadBtVisibleChange(param1:DynamicSquadCtrl) : void;
   }
}
