package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ViewHeaderVO extends DAAPIDataClass
   {
       
      
      public var showBackBtn:Boolean = false;
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescription:String = "";
      
      public function ViewHeaderVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
