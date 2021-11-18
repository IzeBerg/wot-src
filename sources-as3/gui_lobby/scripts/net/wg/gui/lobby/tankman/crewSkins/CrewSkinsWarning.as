package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrewSkinsWarning extends Sprite implements IDisposable
   {
       
      
      public var tfMessage:TextField;
      
      private var _toolTip:String;
      
      public function CrewSkinsWarning()
      {
         super();
         this.tfMessage.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function update(param1:String) : void
      {
         this.tfMessage.text = param1;
      }
      
      public function get toolTip() : String
      {
         return this._toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         this._toolTip = param1;
      }
      
      public function dispose() : void
      {
         this.tfMessage = null;
      }
   }
}
