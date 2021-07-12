package net.wg.gui.battle.views.stats.fullStats.interfaces
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   
   public interface IStatsTableItemHolderBase
   {
       
      
      function setDAAPIVehicleData(param1:DAAPIVehicleInfoVO) : void;
      
      function get containsData() : Boolean;
      
      function get isSelected() : Boolean;
   }
}
