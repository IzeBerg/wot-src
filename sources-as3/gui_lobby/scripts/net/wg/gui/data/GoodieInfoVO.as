package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class GoodieInfoVO extends DAAPIDataClass
   {
       
      
      public var windowTitle:String = "";
      
      public var name:String = "";
      
      public var icon:String = "";
      
      public var description:String = "";
      
      public function GoodieInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
