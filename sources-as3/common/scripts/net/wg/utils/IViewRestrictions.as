package net.wg.utils
{
   import net.wg.data.daapi.ViewRestrictionVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IViewRestrictions extends IDisposable
   {
       
      
      function updateRestrictions(param1:String, param2:ViewRestrictionVO) : void;
      
      function get topOffset() : int;
      
      function get bottomOffset() : int;
      
      function get rightOffset() : int;
      
      function get leftOffset() : int;
      
      function get verticalOffset() : int;
      
      function get horizontalOffset() : int;
   }
}
