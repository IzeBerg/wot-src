package net.wg.data.daapi
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.AssertionException;
   
   public class ViewRestrictionVO
   {
      
      public static const LAYOUT_TYPE_TOP:int = 0;
      
      public static const LAYOUT_TYPE_BOTTOM:int = 1;
      
      public static const LAYOUT_TYPE_LEFT:int = 2;
      
      public static const LAYOUT_TYPE_RIGHT:int = 3;
      
      private static const LAYOUT_TYPES:Array = [LAYOUT_TYPE_TOP,LAYOUT_TYPE_BOTTOM,LAYOUT_TYPE_LEFT,LAYOUT_TYPE_RIGHT];
       
      
      public var layoutType:int = 0;
      
      public var offset:int = 0;
      
      public function ViewRestrictionVO(param1:int, param2:int)
      {
         super();
         if(!param1 in LAYOUT_TYPES)
         {
            throw new AssertionException(Errors.WRONG_VALUE);
         }
         this.layoutType = param1;
         this.offset = param2;
      }
   }
}
