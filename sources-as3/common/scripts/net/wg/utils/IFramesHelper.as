package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IFramesHelper extends IDisposable
   {
       
      
      function getFrameByLabel(param1:String) : int;
      
      function getFrameBeforeLabel(param1:String) : int;
      
      function addScriptToFrame(param1:int, param2:Function) : void;
      
      function clearFrameScripts() : void;
   }
}
