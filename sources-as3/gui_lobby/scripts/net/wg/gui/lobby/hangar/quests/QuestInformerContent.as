package net.wg.gui.lobby.hangar.quests
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestInformerContent extends MovieClip implements IDisposable
   {
       
      
      public var icon:Image;
      
      public var iconSecond:Image;
      
      public var textFieldMc:MovieClip;
      
      private var _disposed:Boolean = false;
      
      public function QuestInformerContent()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.dispose();
         this.icon = null;
         this.iconSecond.dispose();
         this.iconSecond = null;
         this.textFieldMc = null;
      }
      
      public function updateData(param1:String, param2:String, param3:String) : void
      {
         this.icon.source = param1;
         this.iconSecond.source = param2;
         this.textFieldMc.textField.htmlText = param3;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
