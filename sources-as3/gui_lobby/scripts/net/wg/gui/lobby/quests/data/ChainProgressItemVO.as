package net.wg.gui.lobby.quests.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ChainProgressItemVO extends DAAPIDataClass
   {
       
      
      public var value:String = "";
      
      public var chainID:int = -1;
      
      public function ChainProgressItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
