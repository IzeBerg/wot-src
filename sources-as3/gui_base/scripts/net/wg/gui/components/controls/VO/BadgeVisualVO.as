package net.wg.gui.components.controls.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BadgeVisualVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var content:String = "";
      
      public var sizeContent:String = "";
      
      public var isDynamic:Boolean = false;
      
      public var isAtlasSource:Boolean = false;
      
      public function BadgeVisualVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:BadgeVisualVO = param1 as BadgeVisualVO;
         if(_loc2_ == null)
         {
            return false;
         }
         return this.icon == _loc2_.icon && this.content == _loc2_.content && this.sizeContent == _loc2_.sizeContent;
      }
   }
}
