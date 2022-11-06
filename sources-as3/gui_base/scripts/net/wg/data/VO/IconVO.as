package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class IconVO extends DAAPIDataClass
   {
       
      
      private var _big:String = "";
      
      private var _small:String = "";
      
      public function IconVO(param1:Object)
      {
         super(param1);
      }
      
      public function get big() : String
      {
         return this._big;
      }
      
      public function set big(param1:String) : void
      {
         this._big = param1;
      }
      
      public function get small() : String
      {
         return this._small;
      }
      
      public function set small(param1:String) : void
      {
         this._small = param1;
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:IconVO = param1 as IconVO;
         if(!_loc2_)
         {
            return false;
         }
         return this._big == _loc2_.big && this._small == _loc2_.small;
      }
   }
}
