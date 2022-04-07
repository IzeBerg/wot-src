package net.wg.gui.notification.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ButtonVO extends DAAPIDataClass
   {
       
      
      public var type:String = "";
      
      public var label:String = "";
      
      public var action:String = "";
      
      public var width:Number = 122;
      
      public var dynamicSizeByText:Boolean = false;
      
      public var tooltip:String = "";
      
      public function ButtonVO(param1:Object)
      {
         super(param1);
      }
   }
}
