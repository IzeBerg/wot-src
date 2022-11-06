package net.wg.utils.helpLayout
{
   import flash.display.DisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PopupLayoutVO implements IDisposable
   {
       
      
      public var width:int;
      
      public var height:int;
      
      public var x:int;
      
      public var y:int;
      
      public var scope:DisplayObjectContainer;
      
      public function PopupLayoutVO()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.scope = null;
      }
      
      public function isDisposed() : Boolean
      {
         return true;
      }
   }
}
