package net.wg.gui.lobby.hangar.eventEntryPoint.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EntryPointVO extends DAAPIDataClass
   {
       
      
      public var entryLinkage:String = "";
      
      public var swfPath:String = "";
      
      public function EntryPointVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
