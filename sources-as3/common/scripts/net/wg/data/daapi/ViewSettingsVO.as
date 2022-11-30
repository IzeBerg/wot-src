package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ViewSettingsVO extends DAAPIDataClass
   {
      
      private static const VIEW_TYPE_MASK:uint = 15;
      
      private static const VIEW_TYPE:uint = 1;
      
      private static const NON_REARRANGE_VIEW_TYPE:uint = 8 | VIEW_TYPE;
       
      
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
      
      public function get isNonRearrange() : Boolean
      {
         return Boolean(this.flags & VIEW_TYPE_MASK & NON_REARRANGE_VIEW_TYPE);
      }
   }
}
