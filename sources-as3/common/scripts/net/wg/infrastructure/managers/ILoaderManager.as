package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
   
   public interface ILoaderManager extends ILoaderManagerMeta, IStats
   {
       
      
      function loadLibraries(param1:Vector.<String>) : void;
      
      function stopLoadingByViewNames(param1:Array) : void;
   }
}
