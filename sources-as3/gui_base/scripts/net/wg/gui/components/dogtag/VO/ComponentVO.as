package net.wg.gui.components.dogtag.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ComponentVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var imageStr:String = "";
      
      public var value:String = "";
      
      public var hasData:Boolean = false;
      
      public var componentID:int = -1;
      
      public function ComponentVO(param1:Object)
      {
         super(param1);
         this.hasData = param1 != null;
      }
   }
}
