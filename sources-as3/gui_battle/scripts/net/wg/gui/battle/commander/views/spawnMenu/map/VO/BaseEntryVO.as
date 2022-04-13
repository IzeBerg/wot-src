package net.wg.gui.battle.commander.views.spawnMenu.map.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BaseEntryVO extends DAAPIDataClass
   {
       
      
      public var entryID:String = "";
      
      public var entryType:int = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function BaseEntryVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
