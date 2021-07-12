package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ViewSettingsVO extends DAAPIDataClass
   {
       
      
      public var alias:String = "";
      
      public var url:String = "";
      
      public var layer:int = -1;
      
      public var flags:int = 0;
      
      public var event:String = "";
      
      public var group:String = "";
      
      public var isGrouped:Boolean;
      
      public var canDrag:Boolean = true;
      
      public var canClose:Boolean = true;
      
      public var isModal:Boolean;
      
      public var isCentered:Boolean;
      
      public var isResizable:Boolean = true;
      
      public function ViewSettingsVO(param1:Object)
      {
         super(param1);
      }
   }
}
