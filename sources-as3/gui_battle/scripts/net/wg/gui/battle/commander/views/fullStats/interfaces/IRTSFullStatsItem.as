package net.wg.gui.battle.commander.views.fullStats.interfaces
{
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IRTSFullStatsItem extends IDisposable, IDisplayObject
   {
       
      
      function setData(param1:IDAAPIDataClass) : void;
      
      function setFrags(param1:int) : void;
   }
}
