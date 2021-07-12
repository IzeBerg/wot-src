package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PaddingVO extends DAAPIDataClass
   {
       
      
      public var top:int = 0;
      
      public var left:int = 0;
      
      public var bottom:int = 0;
      
      public var right:int = 0;
      
      public function PaddingVO(param1:Object)
      {
         super(param1);
      }
   }
}
