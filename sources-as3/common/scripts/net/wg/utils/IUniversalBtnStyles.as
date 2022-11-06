package net.wg.utils
{
   import net.wg.infrastructure.interfaces.IUniversalBtn;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IUniversalBtnStyles extends IDisposable
   {
       
      
      function setStyle(param1:IUniversalBtn, param2:String) : void;
      
      function setClassFactory(param1:IClassFactory) : void;
   }
}
