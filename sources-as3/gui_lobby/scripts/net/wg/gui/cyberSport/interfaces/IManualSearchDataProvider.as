package net.wg.gui.cyberSport.interfaces
{
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface IManualSearchDataProvider extends IDataProvider
   {
       
      
      function requestUpdatedItems(param1:int, param2:int, param3:Function = null) : Array;
      
      function update(param1:Array) : void;
   }
}
