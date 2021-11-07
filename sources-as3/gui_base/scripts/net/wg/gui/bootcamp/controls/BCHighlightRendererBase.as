package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BCHighlightRendererBase extends MovieClip implements IDisposable
   {
       
      
      public function BCHighlightRendererBase()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         throw new AbstractException("setProperties" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function onDispose() : void
      {
      }
   }
}
