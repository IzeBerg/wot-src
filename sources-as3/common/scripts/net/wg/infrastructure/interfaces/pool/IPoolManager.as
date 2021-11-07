package net.wg.infrastructure.interfaces.pool
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IPoolManager extends IDisposable
   {
       
      
      function addPool(param1:String, param2:IPool) : void;
      
      function getItem(param1:String) : IPoolItem;
      
      function releaseItem(param1:String, param2:IPoolItem) : void;
      
      function containsPool(param1:String) : Boolean;
   }
}
