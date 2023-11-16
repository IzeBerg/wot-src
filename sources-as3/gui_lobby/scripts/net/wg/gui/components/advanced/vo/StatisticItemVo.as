package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatisticItemVo extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var value:String = "";
      
      public var name:String = "";
      
      public function StatisticItemVo(param1:Object)
      {
         super(param1);
      }
   }
}
