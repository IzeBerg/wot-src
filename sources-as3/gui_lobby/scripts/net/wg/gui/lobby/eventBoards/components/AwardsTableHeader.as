package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AwardsTableHeader extends Sprite implements IDisposable
   {
       
      
      public var groupTF:TextField = null;
      
      public var positionTF:TextField = null;
      
      public var awardsTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function AwardsTableHeader()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.groupTF = null;
         this.positionTF = null;
         this.awardsTF = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
