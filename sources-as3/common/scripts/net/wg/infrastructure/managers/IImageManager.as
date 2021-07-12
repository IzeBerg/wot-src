package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.IImageManagerMeta;
   import net.wg.infrastructure.interfaces.IImageData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IImageManager extends IImageManagerMeta, IDisposable
   {
       
      
      function getImageData(param1:String, param2:int = 1) : IImageData;
   }
}
